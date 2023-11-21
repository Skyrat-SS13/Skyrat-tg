#define TESHARI_TEMP_OFFSET -30 // K, added to comfort/damage limit etc
#define TESHARI_HEATMOD 1.3
#define TESHARI_COLDMOD 0.67 // Except cold.

/datum/species/teshari
	name = "Teshari"
	id = SPECIES_TESHARI
	eyes_icon = 'modular_skyrat/modules/organs/icons/teshari_eyes.dmi'
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_HAS_MARKINGS,
	)
	digitigrade_customization = DIGITIGRADE_NEVER
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.0
	mutanttongue = /obj/item/organ/internal/tongue/teshari
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = TESHARI_HEAD_ICON,
		LOADOUT_ITEM_MASK = TESHARI_MASK_ICON,
		LOADOUT_ITEM_NECK = TESHARI_NECK_ICON,
		LOADOUT_ITEM_SUIT = TESHARI_SUIT_ICON,
		LOADOUT_ITEM_UNIFORM = TESHARI_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  TESHARI_HANDS_ICON,
		LOADOUT_ITEM_SHOES = TESHARI_FEET_ICON,
		LOADOUT_ITEM_GLASSES = TESHARI_EYES_ICON,
		LOADOUT_ITEM_BELT = TESHARI_BELT_ICON,
		LOADOUT_ITEM_MISC = TESHARI_BACK_ICON,
		LOADOUT_ITEM_ACCESSORY = TESHARI_ACCESSORIES_ICON,
		LOADOUT_ITEM_EARS = TESHARI_EARS_ICON
	)
	coldmod = TESHARI_COLDMOD
	heatmod = TESHARI_HEATMOD
	bodytemp_normal = BODYTEMP_NORMAL + TESHARI_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	species_language_holder = /datum/language_holder/teshari
	body_size_restricted = TRUE
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/teshari,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/teshari,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/teshari,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/teshari,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/teshari,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/teshari,
	)

/datum/species/teshari/get_default_mutant_bodyparts()
	return list(
		"legs" = list(MUTANT_INDEX_NAME = "Normal Legs", MUTANT_INDEX_CAN_RANDOMIZE = FALSE),
		"tail" = list(MUTANT_INDEX_NAME = "Teshari (Default)", MUTANT_INDEX_CAN_RANDOMIZE = TRUE),
		"ears" = list(MUTANT_INDEX_NAME = "Teshari Regular", MUTANT_INDEX_CAN_RANDOMIZE = TRUE),
		"legs" = list(MUTANT_INDEX_NAME = "Normal Legs", MUTANT_INDEX_CAN_RANDOMIZE = FALSE),
	)


/obj/item/organ/internal/tongue/teshari
	liked_foodtypes = MEAT
	disliked_foodtypes = GROSS | GRAIN


/datum/species/teshari/random_name(gender, unique, lastname)
	if(unique)
		return random_unique_teshari_name()

	var/randname = teshari_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/teshari/prepare_human_for_preview(mob/living/carbon/human/tesh)
	var/base_color = "#c0965f"
	var/ear_color = "#e4c49b"

	tesh.dna.features["mcolor"] = base_color
	tesh.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Teshari Feathers Upright", MUTANT_INDEX_COLOR_LIST = list(ear_color, ear_color, ear_color))
	tesh.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Teshari (Default)", MUTANT_INDEX_COLOR_LIST = list(base_color, base_color, ear_color))
	regenerate_organs(tesh, src, visual_only = TRUE)
	tesh.update_body(TRUE)
