/datum/species/synthliz
	name = "Synthetic Lizardperson"
	id = "synthliz"
	say_mod = "beeps"
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAS_FLESH,HAS_BONE,HAIR)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	default_features = null
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("ipc_antenna" = ACC_RANDOM, "tail" = ACC_RANDOM, "snout" = ACC_RANDOM, "legs" = "Digitigrade Legs", "taur" = "None")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/icons/mob/species/synthliz_parts_greyscale.dmi'
