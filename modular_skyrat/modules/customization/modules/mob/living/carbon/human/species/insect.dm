/datum/species/insect
	name = "Anthromorphic Insect"
	id = SPECIES_INSECT
	say_mod = "chitters"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"horns" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"taur" = "None",
		"fluff" = "None",
		"wings" = "Bee",
		"moth_antennae" = "None"
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = GROSS | RAW | TOXIC
	disliked_food = CLOTH | GRAIN | FRIED
	toxic_food = DAIRY
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_INSECT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/insect,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/insect,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/insect,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/insect,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/insect,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/insect,
	)

/datum/species/insect/get_species_description()
	return {"Anthromorphic Insect is a catch-all term for any anthropomorphic creature, often arthropods, that is either not registered in any official Sapient Universal Species Database under the Sol Federation, Taj Empire, Agurrkral Kingdom, Novaya Rossiyskaya Imperiya, and other major States - or is simply a result of genetical modification."}

/datum/species/insect/get_species_lore()
	return list({"Anthromorphic Insects are a template species! You can write any sort of backstory as long as it's compliant with the Character Creation Guidelines document.
	
	If you have no idea what to do, a regular course of action is writing them as a gene-modded Human."})
