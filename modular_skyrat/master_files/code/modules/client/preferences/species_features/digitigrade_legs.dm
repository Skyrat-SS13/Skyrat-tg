/// Legs
/datum/preference/choiced/digitigrade_legs
	savefile_key = "digitigrade_legs"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"


/datum/preference/choiced/digitigrade_legs/create_default_value()
	return "Normal Legs"


/datum/preference/choiced/digitigrade_legs/init_possible_values()
	return assoc_to_keys(GLOB.sprite_accessories["legs"])


/datum/preference/choiced/digitigrade_legs/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["legs"] = value

