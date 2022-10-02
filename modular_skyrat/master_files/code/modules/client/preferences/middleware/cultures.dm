#define CHILD_CULTURE_SELECTED 2

/datum/asset/spritesheet/cultures
	name = "cultures"
	early = TRUE
	cross_round_cachable = TRUE

/datum/asset/spritesheet/cultures/create_spritesheets()
	for(var/datum/background_feature/background_feature as anything in subtypesof(/datum/background_feature))
		var/icon/language_icon = icon(initial(background_feature.icon_path), icon_state = initial(background_feature.icon_state))
		Insert(sanitize_css_class_name(initial(background_feature.name)), language_icon)

/datum/preference_middleware/cultures
	action_delegations = list(
		"select_culture" = .proc/verify_culture,
		"select_faction" = .proc/verify_faction,
		"select_location" = .proc/verify_location,
	)

/datum/preference_middleware/get_ui_assets()
	return list(
		get_asset_datum(/datum/asset/spritesheet/cultures)
	)

/datum/preference_middleware/cultures/proc/get_ui_data_entries(datum/background_info/cultural_info, valid)
	var/selected = FALSE
	var/list/sub_cultures = list()
	if(valid)
		var/value
		if(istype(cultural_info, /datum/background_info/employment))
			selected = cultural_info.type == preferences.employment
			for(var/datum/background_info/culture as anything in subtypesof(cultural_info.type))
				value = get_ui_data_entry(GLOB.employment[culture], culture == preferences.employment, TRUE)
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)
		else if(istype(cultural_info, /datum/background_info/origin))
			selected = cultural_info.type == preferences.origin
			for(var/datum/background_info/culture as anything in subtypesof(cultural_info.type))
				value = get_ui_data_entry(GLOB.origins[culture], culture == preferences.origin, check_valid(culture, preferences.employment))
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)
		else if(istype(cultural_info, /datum/background_info/social_background))
			selected = cultural_info.type == preferences.social_background
			for(var/datum/background_info/culture as anything in subtypesof(cultural_info.type))
				value = get_ui_data_entry(GLOB.social_backgrounds[culture], culture == preferences.social_background, check_valid(culture, preferences.employment) && check_valid(cultural_info, preferences.origin))
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)

	var/list/data = get_ui_data_entry(cultural_info, selected, valid)
	data["sub_cultures"] = sub_cultures
	data["sub_culture_amount"] = sub_cultures.len
	return data

/datum/preference_middleware/cultures/proc/get_ui_data_entry(datum/background_info/cultural_info, selected, valid)
	var/required_lang_name = null
	if(cultural_info.required_lang)
		var/datum/language/required_lang = GLOB.language_datum_instances[cultural_info.required_lang]
		required_lang_name = initial(required_lang.name)
	var/list/additional_langs = list()
	for(var/datum/language/language as anything in cultural_info.additional_langs)
		language = GLOB.language_datum_instances[language]
		additional_langs += list(initial(language.name))
	var/list/feature_names = list()
	for(var/datum/background_feature/feature as anything in cultural_info.features)
		feature_names += list(initial(feature.name))
	var/list/data = list(
		"name" = cultural_info.name,
		"description" = cultural_info.description,
		"economic_power" = cultural_info.economic_power,
		"required_lang" = required_lang_name,
		"additional_langs" = additional_langs,
		"features" = feature_names,
		"valid" = valid,
		"selected" = selected,
		"path" = "[cultural_info.type]"
	)
	if(istype(cultural_info, /datum/background_info/origin))
		var/datum/background_info/origin/location = cultural_info
		data["ruler"] = location.ruling_body
		data["distance"] = location.distance
		data["capital"] = location.capital
	return data

/datum/preference_middleware/cultures/proc/get_immediate_subtypes(type, list/type_list)
	var/list/types = list()
	for(var/datum/subtype as anything in subtypesof(type))
		subtype = type_list[subtype]
		if(subtype.parent_type == type)
			types += list(subtype.type)
	return types

/datum/preference_middleware/cultures/get_ui_data(mob/user)
	var/list/cultures = list()
	var/list/locations = list()
	var/list/factions = list()

	for(var/datum/background_info/cultural_info as anything in get_immediate_subtypes(/datum/background_info/employment, GLOB.employment))
		cultures += list(get_ui_data_entries(GLOB.employment[cultural_info], TRUE))

	for(var/datum/background_info/cultural_info as anything in get_immediate_subtypes(/datum/background_info/origin, GLOB.origins))
		locations += list(get_ui_data_entries(GLOB.origins[cultural_info], check_valid(cultural_info, preferences.employment)))

	for(var/datum/background_info/cultural_info as anything in get_immediate_subtypes(/datum/background_info/social_background, GLOB.social_backgrounds))
		factions += list(get_ui_data_entries(GLOB.social_backgrounds[cultural_info], check_valid(cultural_info, preferences.employment) && check_valid(cultural_info, preferences.origin)))

	return list(
		"cultures" = cultures,
		"locations" = locations,
		"factions" = factions,
		"features" = GLOB.culture_features,
	)

/datum/preference_middleware/cultures/proc/check_valid(datum/background_info/cultural_info, datum/background_info/loaded_cultural_info)
	if(!cultural_info || !loaded_cultural_info)
		return FALSE
	if(initial(cultural_info.groups) == CULTURE_ALL || initial(loaded_cultural_info.groups) == CULTURE_ALL)
		return TRUE
	if(initial(cultural_info.groups) & initial(loaded_cultural_info.groups))
		return TRUE
	return FALSE

/datum/preference_middleware/cultures/proc/verify_culture(list/params, mob/user)
	var/datum/background_info/employment/culture = GLOB.employment[text2path(params["culture"])]

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(preferences.social_background && !culture)
		preferences.social_background = null
		return TRUE
	if(preferences.origin && !(culture || preferences.social_background))
		preferences.social_background = null
		preferences.origin = null
		return TRUE

	if(culture)
		if(!check_valid(culture, preferences.origin))
			preferences.origin = null
			preferences.social_background = null
		if(!check_valid(culture, preferences.social_background))
			preferences.social_background = null
		preferences.employment = culture.type
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.employment = null
	return TRUE

/datum/preference_middleware/cultures/proc/verify_location(list/params, mob/user)
	var/datum/background_info/origin/location = GLOB.origins[text2path(params["culture"])]

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(!preferences.employment)
		preferences.social_background = null
		preferences.origin = null
		return TRUE

	if(location)
		if(!check_valid(location, preferences.social_background))
			preferences.social_background = null
		preferences.origin = location.type
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.origin = null
	return TRUE

/datum/preference_middleware/cultures/proc/verify_faction(list/params, mob/user)
	var/datum/background_info/social_background/faction = GLOB.social_backgrounds[text2path(params["culture"])]

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(!preferences.employment)
		preferences.social_background = null
		preferences.origin = null
		return TRUE
	if(!preferences.origin)
		preferences.origin = null
		return TRUE

	// Nothing to validate.
	if(faction)
		preferences.social_background = faction.type
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.social_background = null
	return TRUE

#undef CHILD_CULTURE_SELECTED
