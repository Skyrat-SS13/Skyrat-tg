/datum/species/lizard
	mutant_bodyparts = list()
	external_organs = list()
	payday_modifier = 1.0

/datum/species/lizard/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Smooth", TRUE),
		"snout" = list("Sharp + Light", TRUE),
		"spines" = list("Long + Membrane", TRUE),
		"frills" = list("Short", TRUE),
		"horns" = list("Curled", TRUE),
		"body_markings" = list("Light Belly", TRUE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"taur" = list("None", FALSE),
		"wings" = list("None", FALSE),
	)

/datum/species/lizard/ashwalker/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts["spines"] = list("None", TRUE)
	return default_parts

/datum/species/lizard/silverscale/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts["spines"] = list("None", TRUE)
	return default_parts

/datum/species/lizard/randomize_features()
	var/list/features = ..()
	var/main_color = "#[random_color()]"
	var/second_color
	var/third_color
	var/random = rand(1,3)
	switch(random)
		if(1) //First random case - all is the same
			second_color = main_color
			third_color = main_color
		if(2) //Second case, derrivatory shades, except there's no helpers for that and I dont feel like writing them
			second_color = main_color
			third_color = main_color
		if(3) //Third case, more randomisation
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	features["mcolor"] = main_color
	features["mcolor2"] = second_color
	features["mcolor3"] = third_color
	return features

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#009999")
	lizard.dna.features["mcolor"] = lizard_color
	lizard.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Light Tiger", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Simple", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Aquatic", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.features["legs"] = "Normal Legs"
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)

/datum/species/lizard/ashwalker
	always_customizable = TRUE
	inherent_traits = list(
		TRAIT_NO_UNDERWEAR,
		TRAIT_MUTANT_COLORS,
		TRAIT_TACKLING_TAILED_DEFENDER,
	)


/datum/species/lizard/ashwalker/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#990000")
	. = ..(lizard, lizard_color)


/datum/species/lizard/silverscale/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#eeeeee")
	lizard.eye_color_left = "#0000a0"
	lizard.eye_color_right = "#0000a0"
	. = ..(lizard, lizard_color)
