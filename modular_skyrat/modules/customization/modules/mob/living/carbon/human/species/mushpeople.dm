/datum/species/mush/get_default_mutant_bodyparts()
	return list(
		"caps" = list("Round", FALSE), // we don't want cap-less mushpeople
	)

/datum/species/mush/randomize_features()
	var/list/features = ..()
	features["caps"] = pick(GLOB.caps_list - list("None")) // No tail-less monkeys. // No cap-less mushpeople.
	return features

/datum/species/mush/prepare_human_for_preview(mob/living/carbon/human/shrooman)
	shrooman.dna.mutant_bodyparts["caps"] = list(MUTANT_INDEX_NAME = "Round", MUTANT_INDEX_COLOR_LIST = list("#FF4B19"))
	regenerate_organs(shrooman, src, visual_only = TRUE)
	shrooman.update_body(TRUE)
