/datum/config_entry/flag/disable_erp_preferences
	default = FALSE

/datum/preference/toggle/master_erp_preferences
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "master_erp_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/master_erp_preferences/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return TRUE

/datum/preference/toggle/erp
	default_value = FALSE

/datum/preference/toggle/erp/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/toggle/erp/deserialize(input, datum/preferences/preferences)
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

/datum/preference/toggle/erp/cum_face
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "cum_face_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/erp/sex_toy
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "sextoy_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/erp/noncon
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "noncon_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/erp/bimbofication
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "bimbofication_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/erp/aphro
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "aphro_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/erp/breast_enlargement
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "breast_enlargement_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/erp/penis_enlargement
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "penis_enlargement_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/erp/gender_change
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "gender_change_pref"
	savefile_identifier = PREFERENCE_PLAYER
