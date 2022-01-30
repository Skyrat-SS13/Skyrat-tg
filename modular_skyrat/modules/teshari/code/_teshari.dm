#define TESHARI_TEMP_OFFSET -30 // K, added to comfort/damage limit etc
#define TESHARI_BURNMOD 1.25 // They take more damage from practically everything
#define TESHARI_BRUTEMOD 1.2
#define TESHARI_HEATMOD 1.3
#define TESHARI_COLDMOD 0.67 // Except cold.
#define TESHARI_PUNCH_LOW 2 // Lower bound punch damage
#define TESHARI_PUNCH_HIGH 6

/datum/species/teshari
	name = "Teshari"
	id = "teshari"
	default_color = "6060FF"
	eyes_icon = 'modular_skyrat/master_files/icons/mob/species/teshari_eyes.dmi'
	species_traits = list(MUTCOLORS,
		EYECOLOR,
		NO_UNDERWEAR,
		HAS_FLESH,
		HAS_BONE,
		HAS_MARKINGS,
		)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP
	)
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	disliked_food = GROSS | GRAIN
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/teshari_matrixcolor_clothes.dmi'
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/teshari_parts_greyscale.dmi'
	offset_features = list(OFFSET_UNIFORM = list(0,0), OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_GLASSES = list(0,0), OFFSET_EARS = list(0,-4), OFFSET_SHOES = list(0,0), OFFSET_S_STORE = list(0,0), OFFSET_FACEMASK = list(0,-5), OFFSET_HEAD = list(1,-4), OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,-4), OFFSET_SUIT = list(0,0), OFFSET_NECK = list(0,0), OFFSET_ACCESSORY = list(0, -4))
	coldmod = TESHARI_COLDMOD
	heatmod = TESHARI_HEATMOD
	brutemod = TESHARI_BRUTEMOD
	burnmod = TESHARI_BURNMOD
	punchdamagelow = TESHARI_PUNCH_LOW
	punchdamagehigh = TESHARI_PUNCH_HIGH
	bodytemp_normal = BODYTEMP_NORMAL + TESHARI_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	species_language_holder = /datum/language_holder/teshari
	body_size_restricted = TRUE
	learnable_languages = list(/datum/language/common, /datum/language/vox, /datum/language/schechi)
