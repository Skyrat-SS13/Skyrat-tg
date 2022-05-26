/datum/species/xeno
	// A cloning mistake, crossing human and xenomorph DNA
	name = "Xenomorph Hybrid"
	id = SPECIES_XENO
	say_mod = "hisses"
	family_heirlooms = list(/obj/item/toy/plush/rouny, /obj/item/toy/toy_xeno,)
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "Xenomorph Tail",
		"xenodorsal" = ACC_RANDOM,
		"xenohead" = ACC_RANDOM,
		"taur" = "None"
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = MEAT
	learnable_languages = list(/datum/language/common, /datum/language/xenoknockoff)
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	damage_overlay_type = SPECIES_XENO
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/xenohybrid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/xenohybrid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/xenohybrid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/xenohybrid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/xenohybrid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/xenohybrid,
	)

/datum/species/xeno/get_species_description()
	return placeholder_description

/datum/species/xeno/get_species_lore()
	return list(placeholder_lore)
