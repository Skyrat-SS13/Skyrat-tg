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

/datum/preference_middleware/backgrounds/New(datum/preferences)
	. = ..()
	sanitize_backgrounds()

/// Clean and reset backgrounds where appropriate. Typically only does anything on background codedels and renames.
/// Returns TRUE on any changes made.
/datum/preference_middleware/backgrounds/proc/sanitize_backgrounds()
	if(!preferences)
		return FALSE
	// I'm not remaking code I already made.
	if(!verify_origin(list("background" = "[preferences.origin]"), keep_existing_if_valid = TRUE))
		preferences.origin = null
		preferences.social_background = null
		preferences.employment = null
		return TRUE

	if(!verify_social_background(list("background" = "[preferences.social_background]"), keep_existing_if_valid = TRUE))
		preferences.social_background = null
		preferences.employment = null
		return TRUE

	if(!verify_employment(list("background" = "[preferences.employment]")))
		preferences.employment = null
		return TRUE

	return FALSE

/datum/preference_middleware/get_ui_assets()
	return list(
		get_asset_datum(/datum/asset/spritesheet/backgrounds)
	)

/// Runs through each background entry, and generates all relevant data for TGUI.
/datum/preference_middleware/backgrounds/proc/get_ui_data_entries(datum/background_info/background_info, valid, list/list_of_backgrounds, loaded_background_info_type)
	var/selected = FALSE
	var/list/sub_backgrounds = list()
	var/sub_backgrounds_count = 0

	if(valid)
		selected = background_info.type == loaded_background_info_type
		for(var/datum/background_info/culture as anything in subtypesof(background_info.type))
			var/list/value = get_ui_data_entry(list_of_backgrounds[culture], culture == loaded_background_info_type, TRUE)
			if(value["selected"])
				selected = CHILD_BACKGROUND_SELECTED
			if(selected)
				sub_backgrounds += list(value)
			sub_backgrounds_count += 1

	var/list/data = get_ui_data_entry(background_info, selected, valid)
	data["sub_backgrounds"] = sub_backgrounds
	data["sub_background_amount"] = sub_backgrounds_count
	return data

/// A convienience proc for generating UI data entries for backgrounds, otherwise there'd be a lot of repeated code.
/datum/preference_middleware/backgrounds/proc/get_ui_data_entry(datum/background_info/background_info, selected, valid)
	var/list/feature_names = list()
	for(var/datum/background_feature/feature as anything in background_info.features)
		feature_names += list(initial(feature.name))

	// Saves a crapton of cycles if I just skip over all unnecessary data.
	if(!selected)
		return list(
			"name" = background_info.name,
			"features" = feature_names,
			"valid" = valid,
			"path" = "[background_info.type]",
		)

	var/required_lang_name = null
	if(background_info.required_lang)
		var/datum/language/required_lang = background_info.required_lang
		required_lang_name = initial(required_lang.name)

	var/list/additional_langs = list()
	for(var/datum/language/language as anything in background_info.additional_langs)
		language = GLOB.language_datum_instances[language]
		additional_langs += list(initial(language.name))

	var/list/data = list(
		"name" = background_info.name,
		"description" = background_info.description,
		"economic_power" = background_info.economic_power,
		"required_lang" = required_lang_name,
		"additional_langs" = additional_langs,
		"features" = feature_names,
		"valid" = valid,
		"selected" = selected,
		"path" = "[background_info.type]",
	)

	if(istype(background_info, /datum/background_info/origin))
		var/datum/background_info/origin/location = background_info
		data["ruler"] = location.ruling_body
		data["distance"] = location.distance
		data["capital"] = location.capital

	return data

/datum/preference_middleware/backgrounds/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences)
	/* Uncomment in a later PR. Added in this PR to avoid conflicts.
	// Assumes that if they don't already have a passport, that they should get one.
	if(!target.get_passport())
		target.give_passport()
	*/
	target.origin = preferences.origin
	target.social_background = preferences.social_background
	target.employment = preferences.employment

/// Useful little proc that filters a provided list to only the immediate subtypes of the provided type.
/// Used here to figure out the base background types dynamically without adding yet another typelist.
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
		origins += list(get_ui_data_entries(GLOB.origins[background_info], TRUE, GLOB.origins, preferences.origin))

	for(var/datum/background_info/background_info as anything in get_immediate_subtypes(/datum/background_info/social_background, GLOB.social_backgrounds))
		social_backgrounds += list(get_ui_data_entries(GLOB.social_backgrounds[background_info], check_valid(background_info, preferences.origin), GLOB.social_backgrounds, preferences.social_background))

	for(var/datum/background_info/background_info as anything in get_immediate_subtypes(/datum/background_info/employment, GLOB.employments))
		employments += list(get_ui_data_entries(GLOB.employments[background_info], check_valid(background_info, preferences.origin) && check_valid(background_info, preferences.social_background), GLOB.employments, preferences.employment))

	return list(
		"origins" = origins,
		"social_backgrounds" = social_backgrounds,
		"employments" = employments,
		"features" = GLOB.background_features,
	)

/// Compares two background info datums against each other to see if they are compatible. Simple in theory, a pain in my ass in practise.
/datum/preference_middleware/backgrounds/proc/check_valid(datum/background_info/background_info, datum/background_info/loaded_cultural_info)
	if(!background_info || !loaded_cultural_info)
		return FALSE

	if(initial(background_info.groups) == BACKGROUNDS_ALL || initial(loaded_cultural_info.groups) == BACKGROUNDS_ALL)
		return TRUE

	if(initial(background_info.groups) & initial(loaded_cultural_info.groups))
		return TRUE

	return FALSE

/// Verifies the provided origin, which basically consists of getting from a list of valid origins and running a null check on the result.
/// Resets `social_background` and `employment` if the provided origin is valid by default, can be overridden with `keep_existing_if_valid`.
/datum/preference_middleware/backgrounds/proc/verify_origin(list/params, mob/user, keep_existing_if_valid = FALSE)
	var/datum/background_info/origin/origin = GLOB.origins[text2path(params["background"])]

	// It isn't valid, let's not let the game try to use whatever was sent.
	if(!origin)
		return FALSE

	preferences.origin = origin.type

	// I give up on doing advanced code for this. Too much effort for too little gain.
	if(!keep_existing_if_valid)
		preferences.social_background = null
		preferences.employment = null

	return TRUE

/// Verifies the provided social background, which consists of getting from a list of valid social backgrounds, running a null check on the result, and running `check_valid` against the existing origin.
/// Resets `employment` if the provided origin is valid by default, can be overridden with `keep_existing_if_valid`.
/datum/preference_middleware/backgrounds/proc/verify_social_background(list/params, mob/user, keep_existing_if_valid = FALSE)
	var/datum/background_info/social_background/social_background = GLOB.social_backgrounds[text2path(params["background"])]

	// It isn't valid, let's not let the game try to use whatever was sent.
	if(!check_valid(social_background, preferences.origin))
		return FALSE

	preferences.social_background = social_background.type

	if(!keep_existing_if_valid)
		preferences.employment = null

	return TRUE

/// Verifies the provided employment, which consists of getting from a list of valid employments, running a null check on the result, and running `check_valid` against the existing origin and sopcial background.
/datum/preference_middleware/backgrounds/proc/verify_employment(list/params, mob/user)
	var/datum/background_info/employment/employment = GLOB.employments[text2path(params["background"])]

	// It isn't valid, let's not let the game try to use whatever was sent.
	if(!check_valid(employment, preferences.origin) || !check_valid(employment, preferences.social_background))
		return FALSE

	preferences.employment = employment.type

	return TRUE

#undef CHILD_BACKGROUND_SELECTED
