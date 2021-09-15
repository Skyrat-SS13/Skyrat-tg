/datum/preference/choiced/tail
	savefile_key = "feature_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "tail"

/datum/preference/choiced/tail/init_possible_values()
	return assoc_to_keys(GLOB.sprite_accessories["tails"])

/datum/preference/choiced/tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail"] = value
