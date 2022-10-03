#define CHILD_BACKGROUND_SELECTED 2

/datum/asset/spritesheet/backgrounds
	name = "backgrounds"
	early = TRUE
	cross_round_cachable = TRUE

/datum/asset/spritesheet/backgrounds/create_spritesheets()
	for(var/datum/background_feature/background_feature as anything in subtypesof(/datum/background_feature))
		var/icon/language_icon = icon(initial(background_feature.icon_path), icon_state = initial(background_feature.icon_state))
		Insert(sanitize_css_class_name(initial(background_feature.name)), language_icon)

/datum/preference_middleware/backgrounds
	action_delegations = list(
		"select_origin" = .proc/verify_origin,
		"select_social_background" = .proc/verify_social_background,
		"select_employment" = .proc/verify_employment,
	)

/datum/preference_middleware/get_ui_assets()
	return list(
		get_asset_datum(/datum/asset/spritesheet/backgrounds)
	)

/datum/preference_middleware/backgrounds/proc/get_ui_data_entries(datum/background_info/background_info, valid)
	var/selected = FALSE
	var/list/sub_backgrounds = list()
	if(valid)
		var/value
		if(istype(background_info, /datum/background_info/origin))
			selected = background_info.type == preferences.origin
			for(var/datum/background_info/culture as anything in subtypesof(background_info.type))
				value = get_ui_data_entry(GLOB.origins[culture], culture == preferences.origin, TRUE)
				if(value["selected"])
					selected = CHILD_BACKGROUND_SELECTED
				sub_backgrounds += list(value)
		else if(istype(background_info, /datum/background_info/social_background))
			selected = background_info.type == preferences.social_background
			for(var/datum/background_info/culture as anything in subtypesof(background_info.type))
				value = get_ui_data_entry(GLOB.social_backgrounds[culture], culture == preferences.social_background, check_valid(culture, preferences.origin))
				if(value["selected"])
					selected = CHILD_BACKGROUND_SELECTED
				sub_backgrounds += list(value)
		else if(istype(background_info, /datum/background_info/employment))
			selected = background_info.type == preferences.employment
			for(var/datum/background_info/culture as anything in subtypesof(background_info.type))
				value = get_ui_data_entry(GLOB.employments[culture], culture == preferences.employment, check_valid(culture, preferences.origin) && check_valid(background_info, preferences.social_background))
				if(value["selected"])
					selected = CHILD_BACKGROUND_SELECTED
				sub_backgrounds += list(value)

	var/list/data = get_ui_data_entry(background_info, selected, valid)
	data["sub_backgrounds"] = sub_backgrounds
	data["sub_background_amount"] = sub_backgrounds.len
	return data

/datum/preference_middleware/backgrounds/proc/get_ui_data_entry(datum/background_info/background_info, selected, valid)
	var/required_lang_name = null
	if(background_info.required_lang)
		var/datum/language/required_lang = GLOB.language_datum_instances[background_info.required_lang]
		required_lang_name = initial(required_lang.name)
	var/list/additional_langs = list()
	for(var/datum/language/language as anything in background_info.additional_langs)
		language = GLOB.language_datum_instances[language]
		additional_langs += list(initial(language.name))
	var/list/feature_names = list()
	for(var/datum/background_feature/feature as anything in background_info.features)
		feature_names += list(initial(feature.name))
	var/list/data = list(
		"name" = background_info.name,
		"description" = background_info.description,
		"economic_power" = background_info.economic_power,
		"required_lang" = required_lang_name,
		"additional_langs" = additional_langs,
		"features" = feature_names,
		"valid" = valid,
		"selected" = selected,
		"path" = "[background_info.type]"
	)
	if(istype(background_info, /datum/background_info/origin))
		var/datum/background_info/origin/location = background_info
		data["ruler"] = location.ruling_body
		data["distance"] = location.distance
		data["capital"] = location.capital
	return data

/datum/preference_middleware/backgrounds/proc/get_immediate_subtypes(type, list/type_list)
	var/list/types = list()
	for(var/datum/subtype as anything in subtypesof(type))
		subtype = type_list[subtype]
		if(subtype.parent_type == type)
			types += list(subtype.type)
	return types

/datum/preference_middleware/backgrounds/get_ui_data(mob/user)
	var/list/origins = list()
	var/list/social_backgrounds = list()
	var/list/employments = list()

	for(var/datum/background_info/background_info as anything in get_immediate_subtypes(/datum/background_info/origin, GLOB.origins))
		origins += list(get_ui_data_entries(GLOB.origins[background_info], TRUE))

	for(var/datum/background_info/background_info as anything in get_immediate_subtypes(/datum/background_info/social_background, GLOB.social_backgrounds))
		social_backgrounds += list(get_ui_data_entries(GLOB.social_backgrounds[background_info], check_valid(background_info, preferences.origin)))

	for(var/datum/background_info/background_info as anything in get_immediate_subtypes(/datum/background_info/employment, GLOB.employments))
		employments += list(get_ui_data_entries(GLOB.employments[background_info], check_valid(background_info, preferences.origin) && check_valid(background_info, preferences.social_background)))

	return list(
		"origins" = origins,
		"social_backgrounds" = social_backgrounds,
		"employments" = employments,
		"features" = GLOB.background_features,
	)

/datum/preference_middleware/backgrounds/proc/check_valid(datum/background_info/background_info, datum/background_info/loaded_cultural_info)
	if(!background_info || !loaded_cultural_info)
		return FALSE
	if(initial(background_info.groups) == CULTURE_ALL || initial(loaded_cultural_info.groups) == CULTURE_ALL)
		return TRUE
	if(initial(background_info.groups) & initial(loaded_cultural_info.groups))
		return TRUE
	return FALSE

/datum/preference_middleware/backgrounds/proc/verify_origin(list/params, mob/user)
	var/datum/background_info/origin/origin = GLOB.origins[text2path(params["background"])]

	// It isn't valid, let's not let the game try to use whatever was sent.
	if(!origin)
		return TRUE

	preferences.origin = origin.type
	// I give up on doing advanced code for this. Too much effort for too little gain.
	preferences.social_background = null
	preferences.employment = null
	return TRUE

/datum/preference_middleware/backgrounds/proc/verify_social_background(list/params, mob/user)
	var/datum/background_info/social_background/social_background = GLOB.social_backgrounds[text2path(params["background"])]

	// It isn't valid, let's not let the game try to use whatever was sent.
	if(!check_valid(social_background, preferences.origin))
		return TRUE

	preferences.social_background = social_background.type
	preferences.employment = null
	return TRUE

/datum/preference_middleware/backgrounds/proc/verify_employment(list/params, mob/user)
	var/datum/background_info/employment/employment = GLOB.employments[text2path(params["background"])]

	// It isn't valid, let's not let the game try to use whatever was sent.
	if(!check_valid(employment, preferences.origin) || !check_valid(employment, preferences.social_background))
		return TRUE

	preferences.origin = employment.type
	return TRUE

#undef CHILD_BACKGROUND_SELECTED
