/datum/species/vox_primalis
	name = "Vox Primalis"
	id = SPECIES_VOX_PRIMALIS
	eyes_icon = 'modular_skyrat/modules/better_vox/icons/bodyparts/vox_eyes.dmi'
	say_mod = "skrees"
	can_augment = FALSE
	digitigrade_customization = DIGITIGRADE_NEVER // We have our own unique sprites!
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	mutantlungs = /obj/item/organ/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/brain/vox
	breathid = "n2"
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "Vox Primalis Tail",
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = MEAT | FRIED
	payday_modifier = 0.75
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	learnable_languages = list(/datum/language/common, /datum/language/vox, /datum/language/schechi)

	// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox_primalis,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox_primalis,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/vox_primalis,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/vox_primalis,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/vox_primalis,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/vox_primalis,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = VOX_PRIMALIS_HEAD_ICON,
		LOADOUT_ITEM_MASK = VOX_PRIMALIS_MASK_ICON,
		LOADOUT_ITEM_SUIT = VOX_PRIMALIS_SUIT_ICON,
		LOADOUT_ITEM_UNIFORM = VOX_PRIMALIS_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  VOX_PRIMALIS_HANDS_ICON,
		LOADOUT_ITEM_SHOES = VOX_PRIMALIS_FEET_ICON,
		LOADOUT_ITEM_GLASSES = VOX_PRIMALIS_EYES_ICON,
		LOADOUT_ITEM_BELT = VOX_PRIMALIS_BELT_ICON,
		LOADOUT_ITEM_MISC = VOX_PRIMALIS_BACK_ICON,
		LOADOUT_ITEM_EARS = VOX_PRIMALIS_EARS_ICON,
	)


/datum/species/vox_primalis/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	var/datum/outfit/vox/vox_outfit = new /datum/outfit/vox
	equipping.equipOutfit(vox_outfit, visuals_only)
	equipping.internal = equipping.get_item_for_held_index(2)
	equipping.update_internals_hud_icon(1)

/datum/species/vox_primalis/random_name(gender, unique, lastname)
	if(unique)
		return random_unique_vox_name()

	var/randname = vox_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/vox_primalis/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_vox

/datum/species/vox_primalis/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_vox = icon

/datum/species/vox_primalis/get_species_description()
	return placeholder_description

/datum/species/vox_primalis/get_species_lore()
	return list(placeholder_lore)
