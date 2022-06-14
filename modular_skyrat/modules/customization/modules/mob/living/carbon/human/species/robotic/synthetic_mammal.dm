/datum/species/robotic/synthetic_mammal
	name = "Synthetic Anthromorph"
	id = SPECIES_SYNTHMAMMAL
	say_mod = "states"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		MUTCOLORS,EYECOLOR,
		LIPS,HAIR,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
		FACEHAIR
	)
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"horns" = "None",
		"ears" = ACC_RANDOM,
		"legs" = ACC_RANDOM,
		"taur" = "None",
		"fluff" = "None",
		"wings" = "None",
		"head_acc" = "None",
		"neck_acc" = "None"
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/robot/mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/robot/mutant,
	)

/datum/species/robotic/synthetic_mammal/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,7)
	switch(random)
		if(1)
			main_color = "#FFFFFF"
			second_color = "#333333"
			third_color = "#333333"
		if(2)
			main_color = "#FFFFDD"
			second_color = "#DD6611"
			third_color = "#AA5522"
		if(3)
			main_color = "#DD6611"
			second_color = "#FFFFFF"
			third_color = "#DD6611"
		if(4)
			main_color = "#CCCCCC"
			second_color = "#FFFFFF"
			third_color = "#FFFFFF"
		if(5)
			main_color = "#AA5522"
			second_color = "#CC8833"
			third_color = "#FFFFFF"
		if(6)
			main_color = "#FFFFDD"
			second_color = "#FFEECC"
			third_color = "#FFDDBB"
		if(7) //Oh no you've rolled the sparkle dog
			main_color = "#[random_color()]"
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned

/datum/species/robotic/synthetic_mammal/get_random_body_markings(list/passed_features)
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
