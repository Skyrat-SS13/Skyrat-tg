/datum/species/humanoid
	name = "Humanoid"
	id = "humanoid"
	default_color = "4B4B4B"
	species_traits = list(MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 0.75
	limbs_id = "human"

	flavor_text = "The galaxy is a large place, and to quantify the total amount of species in it is an impossible task. Most, however, follow the formula of two arms, two legs, a torso, and a head. Any that do follow this format are collectively called 'Humanoids'"
