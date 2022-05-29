/datum/species/monkey/mauler
	name = "Mauler Monkey"
	id = SPECIES_MONKEY_MAULER
	say_mod = "gargles"
	bodytype = BODYTYPE_ORGANIC | BODYTYPE_MONKEY
	attack_verb = "mauls"
	attack_effect = ATTACK_EFFECT_BITE
	attack_sound = 'sound/weapons/bite.ogg'
	miss_sound = 'sound/weapons/bite.ogg'
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN | SLIME_EXTRACT
	liked_food = MEAT | FRUIT
	disliked_food = CLOTH
	damage_overlay_type = "monkey"
	sexes = FALSE
	punchdamagelow = 5
	punchdamagehigh = 7
	punchstunthreshold = 6

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
	icon_husk = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_chest"
	wound_resistance = 15
	uses_mutcolor = FALSE

/obj/item/bodypart/chest/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_husk = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_chest"
	wound_resistance = 15
	uses_mutcolor = FALSE

/obj/item/bodypart/l_arm/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_husk = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_chest"
	wound_resistance = 15
	uses_mutcolor = FALSE

/obj/item/bodypart/r_arm/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_husk = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_chest"
	wound_resistance = 15
	uses_mutcolor = FALSE

/obj/item/bodypart/l_leg/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_husk = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_chest"
	wound_resistance = 15
	uses_mutcolor = FALSE

/obj/item/bodypart/r_leg/monkey/mauler
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_greyscale = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_static = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_husk = 'modular_skyrat/modules/corrupted_flesh/icons/mauler_monkey_parts.dmi'
	icon_state = "monkey_chest"
	wound_resistance = 15
	uses_mutcolor = FALSE


/mob/living/carbon/human/species/monkey/angry/mauler
	icon_state = "monkey" //for mapping
	race = /datum/species/monkey/mauler
	faction = list(FACTION_CORRUPTED_FLESH)
	ai_controller = /datum/ai_controller/monkey/angry
