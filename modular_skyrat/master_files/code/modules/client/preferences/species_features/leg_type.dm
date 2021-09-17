/datum/preference/choiced/leg_type
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_DEFAULT
	savefile_key = "feature_leg_type"
	savefile_identifier = PREFERENCE_CHARACTER
	relevant_mutant_bodypart = "legs"

/datum/preference/choiced/leg_type/init_possible_values()
	return GLOB.sprite_accessories["legs"]

/datum/preference/choiced/leg_type/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.species.mutant_bodyparts["legs"])
		target.dna.species.mutant_bodyparts["legs"] = list()
	target.dna.species.mutant_bodyparts["legs"][MUTANT_INDEX_NAME] = value
