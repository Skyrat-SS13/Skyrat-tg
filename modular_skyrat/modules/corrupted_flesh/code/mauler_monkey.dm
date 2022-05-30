/datum/species/monkey/mauler
	name = "Mauler Monkey"
	id = SPECIES_MONKEY_MAULER
	say_mod = "gargles"
	bodytype = BODYTYPE_ORGANIC | BODYTYPE_MONKEY
	attack_verb = "mauls"
	changesource_flags = MIRROR_BADMIN
	liked_food = GROSS | TOXIC
	punchdamagelow = 5
	punchdamagehigh = 7
	punchstunthreshold = 6
	mutant_organs = null
	mutant_bodyparts = null
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/monkey/mauler,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/monkey/mauler,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/monkey/mauler,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/monkey/mauler,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/monkey/mauler,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/monkey/mauler,
	)

/obj/item/bodypart/head/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_head"
	wound_resistance = 15
	uses_mutcolor = FALSE
	animal_origin = null
	is_dimorphic = FALSE

/obj/item/bodypart/chest/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_chest"
	wound_resistance = 15
	uses_mutcolor = FALSE
	animal_origin = null
	is_dimorphic = FALSE

/obj/item/bodypart/l_arm/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_l_arm"
	wound_resistance = 15
	uses_mutcolor = FALSE
	animal_origin = null

/obj/item/bodypart/r_arm/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_r_arm"
	wound_resistance = 15
	uses_mutcolor = FALSE
	animal_origin = null

/obj/item/bodypart/l_leg/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_l_leg"
	wound_resistance = 15
	uses_mutcolor = FALSE
	animal_origin = null

/obj/item/bodypart/r_leg/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_r_leg"
	wound_resistance = 15
	uses_mutcolor = FALSE
	animal_origin = null


/mob/living/carbon/human/species/monkey/angry/mauler
	icon_state = "monkey" //for mapping
	race = /datum/species/monkey/mauler
	faction = list(FACTION_CORRUPTED_FLESH)
	ai_controller = /datum/ai_controller/monkey/angry
