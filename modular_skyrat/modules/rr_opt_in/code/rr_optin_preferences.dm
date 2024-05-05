/datum/config_entry/flag/disable_rr_opt_in_preferences
	default = FALSE

/datum/preference/choiced/rr_opt_in_status
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "rr_opt_in_status_pref"

/datum/preference/choiced/rr_opt_in_status/init_possible_values()
	return list(RR_OPT_IN, RR_OPT_OUT)

/datum/preference/choiced/rr_opt_in_status/create_default_value()
	return RR_OPT_LEVEL_DEFAULT

/datum/preference/choiced/rr_opt_in_status/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return !(CONFIG_GET(flag/disable_rr_opt_in_preferences))

/datum/preference/choiced/rr_opt_in_status/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_rr_opt_in_preferences))
		return RR_OPT_LEVEL_DEFAULT

	return ..()

/datum/preference/choiced/rr_opt_in_status/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/rr_opt_in_status/compile_constant_data()
	var/list/data = ..()

	// An assoc list of values to display names so we don't show players numbers in their settings!
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.rr_opt_in_strings

	return data
