/datum/preference/text/pda_ringtone
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pda_ringer" // Keeping it named like this because that's what it used to be called


/datum/preference/text/pda_ringtone/create_default_value()
	return "beep"


/datum/preference/text/pda_ringtone/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
