// Chronological age
/datum/preference/numeric/chronological_age
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "chrono_age"
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = AGE_MIN
	maximum = AGE_CHRONO_MAX

/datum/preference/numeric/chronological_age/create_informed_default_value(datum/preferences/preferences)
	return preferences.read_preference(/datum/preference/numeric/age)

/datum/preference/numeric/chronological_age/apply_to_human(mob/living/carbon/human/target, value)
	target.chrono_age = value
