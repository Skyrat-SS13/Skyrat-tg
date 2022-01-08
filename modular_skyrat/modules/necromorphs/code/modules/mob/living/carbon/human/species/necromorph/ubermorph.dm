/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

/datum/species/necromorph/ubermorph
	name = SPECIES_NECROMORPH_UBERMORPH
	id = SPECIES_NECROMORPH_UBERMORPH
	can_have_genitals = FALSE
	say_mod = "hisses"
	limbs_id = "ubermorph"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/ubermorph.dmi'

//	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/ubermorph/fleshy.dmi'
	//eyes_icon = 'modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi'
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/ubermorph/fleshy.dmi'
//	mutant_bodyparts = list()

	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		NO_UNDERWEAR,
		FACEHAIR
	)

	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sexes = 0

/*
	Slasher variant. Damage Calculation and Effects
*/

	damage_overlay_type = "xeno"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	attack_verb = "slash"

	attack_effect = ATTACK_EFFECT_CLAW

/*
	Slasher variant. Traits
*/

	species_traits = list(HAS_FLESH, HAS_BONE)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_XENO_IMMUNE,
		TRAIT_NOCLONELOSS,
	)


/*
	Slasher variant. Mutant Parts
*/
	mutanteyes = /obj/item/organ/eyes/night_vision
	mutanttongue = /obj/item/organ/tongue/zombie

	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph)




