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

/datum/preference_middleware/cultures/proc/get_ui_data_entries(datum/cultural_info/cultural_info, valid)
	var/selected = FALSE
	var/list/sub_cultures = list()
	if(valid)
		if(ispath(cultural_info, /datum/cultural_info/culture))
			selected = ispath(cultural_info, preferences.culture_culture)
			for(var/datum/cultural_info/culture as anything in subtypesof(cultural_info))
				var/value = get_ui_data_entry(culture, culture == preferences.culture_culture, TRUE)
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)
		if(ispath(cultural_info, /datum/cultural_info/location))
			selected = ispath(cultural_info, preferences.culture_location)
			for(var/datum/cultural_info/culture as anything in subtypesof(cultural_info))
				var/value = get_ui_data_entry(culture, culture == preferences.culture_location, check_valid(culture, preferences.culture_culture))
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)
		if(ispath(cultural_info, /datum/cultural_info/faction))
			selected = ispath(cultural_info, preferences.culture_faction)
			for(var/datum/cultural_info/culture as anything in subtypesof(cultural_info))
				var/value = get_ui_data_entry(culture, culture == preferences.culture_faction, check_valid(culture, preferences.culture_culture) && check_valid(cultural_info, preferences.culture_location))
				if(value["selected"])
					selected = CHILD_CULTURE_SELECTED
				sub_cultures += list(value)

	var/list/data = get_ui_data_entry(cultural_info, selected, valid)
	data["sub_cultures"] = sub_cultures
	data["sub_culture_amount"] = sub_cultures.len
	return data

/datum/preference_middleware/cultures/proc/get_ui_data_entry(datum/cultural_info/cultural_info, selected, valid)
	cultural_info = new cultural_info()
	var/required_lang_name = initial(cultural_info.required_lang.name)
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
	if(istype(cultural_info, /datum/cultural_info/location))
		var/datum/cultural_info/location/location = cultural_info
		data += list(
			"ruler" = location.ruling_body,
			"distance" = location.distance,
			"capital" = location.capital,
		)
	return data

/datum/preference_middleware/cultures/proc/get_immediate_subtypes(obj/type)
	var/list/types = list()
	for(var/datum/subtype as anything in subtypesof(type))
		subtype = new subtype()
		if(subtype.parent_type == type)
			types += list(subtype.type)
	return types

/datum/preference_middleware/cultures/get_ui_data(mob/user)
	var/list/cultures = list()
	var/list/locations = list()
	var/list/factions = list()
	var/list/features = list()

	for(var/datum/cultural_feature/cultural_feature as anything in subtypesof(/datum/cultural_feature))
		cultural_feature = new cultural_feature()
		features += list("[cultural_feature.name]" = list(
			"name" = cultural_feature.name,
			"description" = cultural_feature.description,
			"icon" = sanitize_css_class_name(cultural_feature.name),
			"css_class" = cultural_feature.css_class,
		))

	for(var/datum/cultural_info/cultural_info as anything in get_immediate_subtypes(/datum/cultural_info/culture))
		cultures += list(get_ui_data_entries(cultural_info, TRUE))

	for(var/datum/cultural_info/cultural_info as anything in get_immediate_subtypes(/datum/cultural_info/location))
		locations += list(get_ui_data_entries(cultural_info, check_valid(cultural_info, preferences.culture_culture)))

	for(var/datum/cultural_info/cultural_info as anything in get_immediate_subtypes(/datum/cultural_info/faction))
		factions += list(get_ui_data_entries(cultural_info, check_valid(cultural_info, preferences.culture_culture) && check_valid(cultural_info, preferences.culture_location)))

	return list(
		"cultures" = cultures,
		"locations" = locations,
		"factions" = factions,
		"features" = features,
	)

/datum/preference_middleware/cultures/proc/check_valid(datum/cultural_info/cultural_info, datum/cultural_info/loaded_cultural_info)
	if(!cultural_info || !loaded_cultural_info)
		return FALSE
	if(initial(cultural_info.groups) == CULTURE_ALL || initial(loaded_cultural_info.groups) == CULTURE_ALL)
		return TRUE
	if(initial(cultural_info.groups) & initial(loaded_cultural_info.groups))
		return TRUE
	return FALSE

/datum/preference_middleware/cultures/proc/verify_culture(list/params, mob/user)
	var/datum/cultural_info/culture = text2path(params["culture"])
	world.log << "[culture]"

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(preferences.culture_faction && !culture)
		preferences.culture_faction = null
		return TRUE
	if(preferences.culture_location && !(culture || preferences.culture_faction))
		preferences.culture_faction = null
		preferences.culture_location = null
		return TRUE

	if(GLOB.culture_cultures[culture])
		if(!check_valid(culture, preferences.culture_location))
			preferences.culture_location = null
			preferences.culture_faction = null
		if(!check_valid(culture, preferences.culture_faction))
			preferences.culture_faction = null
		preferences.culture_culture = culture
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.culture_culture = null
	return TRUE

/datum/preference_middleware/cultures/proc/verify_location(list/params, mob/user)
	var/datum/cultural_info/location = text2path(params["culture"])
	world.log << "[location]"

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(!preferences.culture_culture)
		preferences.culture_faction = null
		preferences.culture_location = null
		return TRUE

	if(GLOB.culture_locations[location])
		if(!check_valid(location, preferences.culture_faction))
			preferences.culture_faction = null
		preferences.culture_location = location
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.culture_location = null
	return TRUE

/datum/preference_middleware/cultures/proc/verify_faction(list/params, mob/user)
	var/datum/cultural_info/faction = text2path(params["culture"])
	world.log << "[faction]"

	// If a preresiquite isn't selected, yeet everything that shouldn't be selected.
	if(!preferences.culture_culture)
		preferences.culture_faction = null
		preferences.culture_location = null
		return TRUE
	if(!preferences.culture_location)
		preferences.culture_location = null
		return TRUE

	// Nothing to validate.
	if(GLOB.culture_factions[faction])
		preferences.culture_faction = faction
		return TRUE

	// It isn't valid, let's not let the game try to use whatever was sent.
	preferences.culture_faction = null
	return TRUE

#undef CHILD_CULTURE_SELECTED
