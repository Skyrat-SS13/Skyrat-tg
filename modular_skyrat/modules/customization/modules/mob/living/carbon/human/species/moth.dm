/datum/species/moth
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"fluff" = "None",
		"wings" = ACC_RANDOM,
		"moth_antennae" = ACC_RANDOM,
	)
	inherent_traits = list(
		TRAIT_HAS_MARKINGS,
		TRAIT_TACKLING_WINGED_ATTACKER,
		TRAIT_ANTENNAE,
		TRAIT_MUTANT_COLORS,
	)

/datum/species/moth/randomize_features(mob/living/carbon/human/human_mob)
	human_mob.dna.features["mcolor"] = "#E5CD99"

/datum/species/moth/get_random_body_markings(list/passed_features)
	var/name = "None"
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && !(id in setter.recommended_species))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/moth/prepare_human_for_preview(mob/living/carbon/human/moth)
	moth.dna.features["mcolor"] = "#E5CD99"
	moth.dna.mutant_bodyparts["moth_antennae"] = list(MUTANT_INDEX_NAME = "Plain", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	moth.dna.mutant_bodyparts["moth_markings"] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	moth.dna.mutant_bodyparts["wings"] = list(MUTANT_INDEX_NAME = "Moth (Plain)", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	regenerate_organs(moth, src, visual_only = TRUE)
	moth.update_body(TRUE)
