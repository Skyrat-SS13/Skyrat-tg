/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define SLASHER_DODGE_EVASION	60
#define SLASHER_DODGE_DURATION	1.5 SECONDS

/datum/species/necromorph/slasher
	name = SPECIES_NECROMORPH_SLASHER
	id = SPECIES_NECROMORPH_SLASHER
	can_have_genitals = FALSE
	say_mod = "hisses"
	limbs_id = "slasher"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher.dmi'
	//body_position_pixel_x_offset = 0
	//body_position_pixel_y_offset = 0
//	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	//eyes_icon = 'modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi'
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
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


	//Slashers hold their arms up in an overhead pose, so they override height too
	mutant_bodyparts = list(
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/blade, "height" = new /vector2(1.6,2)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/blade/right, "height" = new /vector2(1.6,2))
	)

#undef SLASHER_DODGE_EVASION
#undef SLASHER_DODGE_DURATION
