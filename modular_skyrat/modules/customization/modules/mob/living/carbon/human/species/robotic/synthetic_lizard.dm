/datum/species/robotic/synthliz
	name = "Synthetic Lizardperson"
	id = SPECIES_SYNTHLIZ
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		MUTCOLORS,EYECOLOR,
		LIPS,
		HAIR,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"ipc_antenna" = ACC_RANDOM,
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"legs" = "Digitigrade Legs",
		"taur" = "None",
		"wings" = "None"
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/mutant/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/mutant/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/mutant/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/mutant/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/robot/mutant/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/robot/mutant/lizard,
	)

/datum/species/robotic/synthliz/get_random_body_markings(list/passed_features)
	var/name = pick("Synth Pecs Lights", "Synth Scutes", "Synth Pecs")
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/robotic/synthliz/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,6)
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
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned

/datum/species/synthliz/prepare_human_for_preview(mob/living/carbon/human/synthliz)
	var/synthliz_color = "#22BBFF"
	synthliz.dna.features["mcolor"] = synthliz_color
	synthliz.dna.features["mcolor2"] = synthliz_color
	synthliz.dna.features["mcolor3"] = synthliz_color
	synthliz.update_body(TRUE)
