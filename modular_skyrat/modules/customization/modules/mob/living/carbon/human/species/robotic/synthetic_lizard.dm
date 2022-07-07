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
