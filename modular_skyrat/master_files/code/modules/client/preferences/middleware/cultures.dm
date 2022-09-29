#define CHILD_CULTURE_SELECTED 2

/datum/asset/spritesheet/cultures
	name = "cultures"
	early = TRUE
	cross_round_cachable = TRUE

/datum/asset/spritesheet/cultures/create_spritesheets()
	for(var/datum/cultural_feature/cultural_feature as anything in subtypesof(/datum/cultural_feature))
		var/icon/language_icon = icon(initial(cultural_feature.icon_path), icon_state = initial(cultural_feature.icon_state))
		Insert(sanitize_css_class_name(initial(cultural_feature.name)), language_icon)

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
			selected = cultural_info.type == preferences.culture_culture
			for(var/datum/background_info/culture as anything in subtypesof(cultural_info.type))
				value = get_ui_data_entry(GLOB.employment[culture], culture == preferences.culture_culture, TRUE)
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)
		else if(istype(cultural_info, /datum/background_info/origin))
			selected = cultural_info.type == preferences.culture_location
			for(var/datum/background_info/culture as anything in subtypesof(cultural_info.type))
				value = get_ui_data_entry(GLOB.origins[culture], culture == preferences.culture_location, check_valid(culture, preferences.culture_culture))
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)
		else if(istype(cultural_info, /datum/background_info/social_background))
			selected = cultural_info.type == preferences.culture_faction
			for(var/datum/background_info/culture as anything in subtypesof(cultural_info.type))
				value = get_ui_data_entry(GLOB.social_backgrounds[culture], culture == preferences.culture_faction, check_valid(culture, preferences.culture_culture) && check_valid(cultural_info, preferences.culture_location))
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
	for(var/datum/cultural_feature/feature as anything in cultural_info.features)
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
		locations += list(get_ui_data_entries(GLOB.origins[cultural_info], check_valid(cultural_info, preferences.culture_culture)))

	for(var/datum/background_info/cultural_info as anything in get_immediate_subtypes(/datum/background_info/social_background, GLOB.social_backgrounds))
		factions += list(get_ui_data_entries(GLOB.social_backgrounds[cultural_info], check_valid(cultural_info, preferences.culture_culture) && check_valid(cultural_info, preferences.culture_location)))

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
	if(preferences.culture_faction && !culture)
		preferences.culture_faction = null
		return TRUE
	if(preferences.culture_location && !(culture || preferences.culture_faction))
		preferences.culture_faction = null
		preferences.culture_location = null
		return TRUE

	if(culture)
		if(!check_valid(culture, preferences.culture_location))
			preferences.culture_location = null
			preferences.culture_faction = null
		if(!check_valid(culture, preferences.culture_faction))
			preferences.culture_faction = null
		preferences.culture_culture = culture.type
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.culture_culture = null
	return TRUE

/datum/preference_middleware/cultures/proc/verify_location(list/params, mob/user)
	var/datum/background_info/origin/location = GLOB.origins[text2path(params["culture"])]

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(!preferences.culture_culture)
		preferences.culture_faction = null
		preferences.culture_location = null
		return TRUE

	if(location)
		if(!check_valid(location, preferences.culture_faction))
			preferences.culture_faction = null
		preferences.culture_location = location.type
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.culture_location = null
	return TRUE

/datum/preference_middleware/cultures/proc/verify_faction(list/params, mob/user)
	var/datum/background_info/social_background/faction = GLOB.social_backgrounds[text2path(params["culture"])]

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(!preferences.culture_culture)
		preferences.culture_faction = null
		preferences.culture_location = null
		return TRUE
	if(!preferences.culture_location)
		preferences.culture_location = null
		return TRUE

	// Nothing to validate.
	if(faction)
		preferences.culture_faction = faction.type
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.culture_faction = null
	return TRUE

#undef CHILD_CULTURE_SELECTED
