/// Legs
/datum/preference/choiced/digitigrade_legs
	savefile_key = "digitigrade_legs"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"

/datum/preference/choiced/digitigrade_legs/init_possible_values()
	return assoc_to_keys(GLOB.sprite_accessories["legs"])

/datum/preference/choiced/digitigrade_legs/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["legs"] = value

/datum/preference/choiced/digitigrade_legs/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	return passed_initial_check || allowed
