/datum/species/robotic/synthetic_human
	name = "Synthetic Humanoid"
	id = SPECIES_SYNTHHUMAN
	say_mod = "states"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		EYECOLOR,
		LIPS,
		HAIR,
		ROBOTIC_LIMBS,
		FACEHAIR,
		NOTRANSSTING
	)
	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)
	use_skintones = TRUE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	reagent_flags = PROCESS_SYNTHETIC
	species_language_holder = /datum/language_holder/machine
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/mutant/human,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/mutant/human,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/mutant/human,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/mutant/human,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/robot/mutant/human,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/robot/mutant/human,
	)
