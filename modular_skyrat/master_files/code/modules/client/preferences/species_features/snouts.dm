/datum/preference/choiced/snout
	savefile_key = "feature_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "snout"

/datum/preference/choiced/snout/init_possible_values()
	return generate_head_side_shots(GLOB.sprite_accessories[relevant_mutant_bodypart], relevant_mutant_bodypart, TRUE)

/datum/preference/choiced/snout/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts["snout"])
		target.dna.mutant_bodyparts["snout"] = list()
	target.dna.mutant_bodyparts["snout"][MUTANT_INDEX_NAME] = value

	//target.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_COLOR_LIST] = your_list_with_colors //This list must be 3 hexa colors
