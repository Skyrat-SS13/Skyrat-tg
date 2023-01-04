//DO NOT CHANGE THOSE LISTS UNLESS YOU KNOW WHAT YOURE DOING (will mess savefiles)


GLOBAL_LIST_INIT(breast_size_translation, list(
	"0" = BREAST_SIZE_FLATCHESTED,
	"1" = BREAST_SIZE_A,
	"2" = BREAST_SIZE_B,
	"3" = BREAST_SIZE_C,
	"4" = BREAST_SIZE_D,
	"5" = BREAST_SIZE_E,
	"6" = BREAST_SIZE_F,
	"7" = BREAST_SIZE_G,
	"8" = BREAST_SIZE_H,
	"9" = BREAST_SIZE_I,
	"10" = BREAST_SIZE_J,
	"11" = BREAST_SIZE_K,
	"12" = BREAST_SIZE_L,
	"13" = BREAST_SIZE_M,
	"14" = BREAST_SIZE_N,
	"15" = BREAST_SIZE_O,
	"16" = BREAST_SIZE_P,
	))

GLOBAL_LIST_INIT(breast_size_to_number, list(
	BREAST_SIZE_FLATCHESTED = 0,
	BREAST_SIZE_A = 1,
	BREAST_SIZE_B = 2,
	BREAST_SIZE_C = 3,
	BREAST_SIZE_D = 4,
	BREAST_SIZE_E = 5,
	BREAST_SIZE_F = 6,
	BREAST_SIZE_G = 7,
	BREAST_SIZE_H = 8,
	BREAST_SIZE_I = 9,
	BREAST_SIZE_J = 10,
	BREAST_SIZE_K = 11,
	BREAST_SIZE_L = 12,
	BREAST_SIZE_M = 13,
	BREAST_SIZE_N = 14,
	BREAST_SIZE_O = 15,
	BREAST_SIZE_P = 16,
	))

GLOBAL_LIST_INIT(balls_size_translation, list(
	"0" = "Small",
	"1" = "Average",
	"2" = "Big",
	"3" = "Enormous"
	))

GLOBAL_LIST_INIT(marking_zone_to_bitflag, list(
	BODY_ZONE_HEAD = HEAD,
	BODY_ZONE_CHEST = CHEST,
	BODY_ZONE_L_LEG = LEG_LEFT,
	BODY_ZONE_R_LEG = LEG_RIGHT,
	BODY_ZONE_L_ARM = ARM_LEFT,
	BODY_ZONE_R_ARM = ARM_RIGHT,
	BODY_ZONE_PRECISE_L_HAND = HAND_LEFT,
	BODY_ZONE_PRECISE_R_HAND = HAND_RIGHT
	))

GLOBAL_LIST_INIT(marking_zones, list(
	BODY_ZONE_HEAD,
	BODY_ZONE_CHEST,
	BODY_ZONE_L_LEG,
	BODY_ZONE_R_LEG,
	BODY_ZONE_L_ARM,
	BODY_ZONE_R_ARM,
	BODY_ZONE_PRECISE_L_HAND,
	BODY_ZONE_PRECISE_R_HAND,
	))

GLOBAL_LIST_INIT(preference_balls_sizes, list(
	"Small",
	"Average",
	"Big",
	"Enormous",
	))

GLOBAL_LIST_INIT(robotic_styles_list, list(
	"None" = "None",
	"Surplus" = 'icons/mob/augmentation/surplus_augments.dmi',
	"Cyborg" = 'icons/mob/augmentation/augments.dmi',
	"Engineering" = 'icons/mob/augmentation/augments_engineer.dmi',
	"Mining" = 'icons/mob/augmentation/augments_mining.dmi',
	"Security" = 'icons/mob/augmentation/augments_security.dmi',
	"Morpheus Cyberkinetics" = 'modular_skyrat/master_files/icons/mob/augmentation/mcgipc.dmi',
	"Bishop Cyberkinetics" = 'modular_skyrat/master_files/icons/mob/augmentation/bshipc.dmi',
	"Bishop Cyberkinetics 2.0" = 'modular_skyrat/master_files/icons/mob/augmentation/bs2ipc.dmi',
	"Hephaestus Industries" = 'modular_skyrat/master_files/icons/mob/augmentation/hsiipc.dmi',
	"Hephaestus Industries 2.0" = 'modular_skyrat/master_files/icons/mob/augmentation/hi2ipc.dmi',
	"Shellguard Munitions Standard Series" = 'modular_skyrat/master_files/icons/mob/augmentation/sgmipc.dmi',
	"Ward-Takahashi Manufacturing" = 'modular_skyrat/master_files/icons/mob/augmentation/wtmipc.dmi',
	"Xion Manufacturing Group" = 'modular_skyrat/master_files/icons/mob/augmentation/xmgipc.dmi',
	"Xion Manufacturing Group 2.0" = 'modular_skyrat/master_files/icons/mob/augmentation/xm2ipc.dmi',
	"Zeng-Hu Pharmaceuticals" = 'modular_skyrat/master_files/icons/mob/augmentation/zhpipc.dmi'
	))

//ghoul colors
GLOBAL_LIST_INIT(color_list_ghoul, list( \
	"Necrotic Green" = "bfc474", \
	"Rotting Tan" = "c4af7c", \
	"Plutonium Blue" = "a5cfcc", \
	"Marked Red" = "f05b68" \
))
