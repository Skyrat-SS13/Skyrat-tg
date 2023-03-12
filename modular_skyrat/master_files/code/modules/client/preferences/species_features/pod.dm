/datum/preference/choiced/pod_hair
	relevant_mutant_bodypart = "pod_hair"

/datum/preference/choiced/pod_hair/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts["pod_hair"])
		target.dna.mutant_bodyparts["pod_hair"] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))

	target.dna.mutant_bodyparts["pod_hair"][MUTANT_INDEX_NAME] = value
