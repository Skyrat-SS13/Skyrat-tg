/datum/species/moth
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"fluff" = "None",
		"wings" = ACC_RANDOM,
		"moth_antennae" = ACC_RANDOM,
	)

/datum/species/moth/New()
	. = ..()
	species_traits |= MUTCOLORS

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
