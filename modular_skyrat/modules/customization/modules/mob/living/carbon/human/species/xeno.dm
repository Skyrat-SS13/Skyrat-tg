/datum/species/xeno
	// A cloning mistake, crossing human and xenomorph DNA
	name = "Xenomorph Hybrid"
	id = "xeno"
	say_mod = "hisses"
	default_color = "00FF00"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "Xenomorph Tail",
		"legs" = "Digitigrade Legs",
		"xenodorsal" = ACC_RANDOM,
		"xenohead" = ACC_RANDOM,
		"taur" = "None"
	)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = MEAT
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/xeno_parts_greyscale.dmi'
	damage_overlay_type = "xeno"

	flavor_text = "Sometimes, people experience freak accidents. Sometimes, people allow themselves to become under the whims of mad science. Whatever the case, there exists a race of peoples known as the Xenomorph Hybrids. They're self explanatory. A bastardisation of Xenomorph and some base race, usually human, and their offspring. While no doubt terrifying to those living in the core worlds, out in the frontiers, there's much, much worse, and hybrids rarely get a second glance."
