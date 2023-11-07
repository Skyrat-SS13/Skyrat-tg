/datum/config_entry/flag/disable_antag_opt_in_preferences
	default = FALSE

/datum/preference/toggle/master_antag_opt_in_preferences
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "master_antag_opt_in_pref"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/master_antag_opt_in_preferences/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_antag_opt_in_preferences))
		return FALSE

	return TRUE

/datum/preference/toggle/master_antag_opt_in_preferences/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_antag_opt_in_preferences))
		return FALSE
	. = ..()

/datum/preference/toggle/antag_opt_in
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "antag_opt_in_pref"
	default_value = TRUE

/datum/preference/toggle/antag_opt_in/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_antag_opt_in_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_antag_opt_in_preferences)

/datum/preference/toggle/antag_opt_in/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_antag_opt_in_preferences))
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/master_antag_opt_in_preferences))
		return FALSE
	return ..()


/datum/preference/choiced/antag_opt_in_status
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "antag_opt_in_status_pref"


/datum/preference/choiced/antag_opt_in_status/init_possible_values()
	return list(OPT_IN_YES_TEMP, OPT_IN_YES_KILL, OPT_IN_YES_ROUND_REMOVE, OPT_IN_NOT_TARGET)

/datum/preference/choiced/antag_opt_in_status/create_default_value()
	return OPT_IN_YES_KILL

/datum/preference/choiced/antag_opt_in_status/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_antag_opt_in_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_antag_opt_in_preferences)

/datum/preference/choiced/antag_opt_in_status/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_antag_opt_in_preferences))
		return OPT_IN_YES_KILL
	if(!preferences.read_preference(/datum/preference/toggle/master_antag_opt_in_preferences))
		return OPT_IN_YES_KILL
	. = ..()

/datum/preference/choiced/antag_opt_in_status/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.mind.ideal_opt_in_level = value

/datum/preference/choiced/antag_opt_in_status/compile_constant_data()
	var/list/data = ..()

	// An assoc list of values to display names so we don't show players numbers in their settings
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = list(
		"0" = "No",
		"1" = "Yes - Temporary/Inconvienence",
		"2" = "Yes - Kill",
		"3" = "Yes - Round Remove",
	)

	return data

