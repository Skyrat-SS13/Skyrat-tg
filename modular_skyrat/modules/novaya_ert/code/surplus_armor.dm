// THESE WILL (MOSTLY) SPAWN WITH A RANDOM 'CAMO' COLOR WHEN ORDERED THROUGH CARGO
// THE STANDARD COLORS FOR USE WILL BE BELOW

#define CIN_WINTER_COLORS "#bbbbc9"
#define CIN_MOUNTAIN_DESERT_COLORS "#aa6d4c"
#define CIN_FOREST_COLORS "#6D6D51"
#define CIN_MARINE_COLORS "#51517b"
#define CIN_EVIL_COLORS "#5d5d66"

#define CIN_WINTER_COLORS_COMPLIMENT "#838392"
#define CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT "#a37e45"
#define CIN_FOREST_COLORS_COMPLIMENT "#474734"
#define CIN_MARINE_COLORS_COMPLIMENT "#39394d"
#define CIN_EVIL_COLORS_COMPLIMENT "#3d3d46"

#define HELMET_NO_ACCESSORIES "plain"
#define HELMET_CHINSTRAP "strap"
#define HELMET_GLASS_VISOR "glass"
#define HELMET_BOTH_OF_THE_ABOVE "both"

// Shared Armor Datum
// CIN armor does decently against both bullets and lasers, however can break when shot enough

/datum/armor/cin_surplus_armor
	melee = ARMOR_LEVEL_WEAK
	bullet = ARMOR_LEVEL_MID
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_WEAK
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_STANDARD

// Hats

/obj/item/clothing/head/helmet/cin_surplus_helmet
	name = "'Klamra' combat helmet"
	desc = "An outdated helmet used by CIN military forces. \
		The design dates back to the years leading up to CIN - SolFed border war, and can still be seen today \
		in some parts of CIN territories where its not so important for equipment to be the best of the best. \
		While the armor will wear down over time, it covers both your arms and torso, and provides exceptional \
		projectile and laser protection."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor_object.dmi'
	icon_state = "helmet_plain"
	greyscale_config = /datum/greyscale_config/cin_surplus_helmet/object
	greyscale_config_worn = /datum/greyscale_config/cin_surplus_helmet
	greyscale_colors = CIN_WINTER_COLORS
	armor_type = /datum/armor/cin_surplus_armor
	max_integrity = 150
	limb_integrity = 150
	resistance_flags = FIRE_PROOF
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

	/// Controls what helmet accessories will be present in a weighted format
	var/static/list/accessories_weighted_list = list(
		HELMET_NO_ACCESSORIES = 15,
		HELMET_CHINSTRAP = 10,
		HELMET_GLASS_VISOR = 10,
		HELMET_BOTH_OF_THE_ABOVE = 5,
	)

/obj/item/clothing/head/helmet/cin_surplus_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_damaged_by_bullets, 0.75)
	generate_random_accessories()

/// Takes accessories_weighted_list and picks what icon_state suffix to use
/obj/item/clothing/head/helmet/cin_surplus_helmet/proc/generate_random_accessories()
	var/chosen_accessories = pick_weight(accessories_weighted_list)

	icon_state = "helmet_[chosen_accessories]"

	if(chosen_accessories == (HELMET_GLASS_VISOR || HELMET_BOTH_OF_THE_ABOVE))
		flags_cover = HEADCOVERSEYES
	else
		flags_cover = NONE

	update_appearance()

/obj/item/clothing/head/helmet/cin_surplus_helmet/examine_more(mob/user)
	. = ..()

	. += "The 'Klamra' series of coalition armor was a collaborative project between the NRI and TransOrbital \
		to develop a frontline soldier's armor set that could withstand attacks from the Solar Federation's \
		then relatively new pulse ballistics. The design itself is based upon a far older pattern \
		of armor originally developed by SolFed themselves, which was the standard pattern of armor design \
		granted to the first colony ships leaving Sol. Armor older than any of the CIN member states, \
		upgraded with modern technology. This helmet in particular encloses the entire head save for \
		the face, and should come with a glass visor and relatively comfortable internal padding. Should, \
		anyways, surplus units such as this are infamous for arriving with several missing accessories."

	return .

/obj/item/clothing/head/helmet/cin_surplus_helmet/desert
	greyscale_colors = CIN_MOUNTAIN_DESERT_COLORS

/obj/item/clothing/head/helmet/cin_surplus_helmet/forest
	greyscale_colors = CIN_FOREST_COLORS

/obj/item/clothing/head/helmet/cin_surplus_helmet/marine
	greyscale_colors = CIN_MARINE_COLORS

/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color
	/// The different colors this helmet can choose from when initializing
	var/static/list/possible_spawning_colors = list(
		CIN_WINTER_COLORS,
		CIN_MOUNTAIN_DESERT_COLORS,
		CIN_FOREST_COLORS,
		CIN_MARINE_COLORS,
		CIN_EVIL_COLORS,
	)

/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color/Initialize(mapload)
	greyscale_colors = pick(possible_spawning_colors)

	. = ..()

// Undersuits

/obj/item/clothing/under/syndicate/rus_army/cin_surplus
	name = "\improper CIN combat uniform"
	desc = "A CIN designed combat uniform that can come in any number of camouflauge variations. Despite this particular design being developed in the years leading up to the CIN-SolFed border war, the uniform is still in use by many member states to this day."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor_object.dmi'
	icon_state = "undersuit_greyscale"
	greyscale_config = /datum/greyscale_config/cin_surplus_undersuit/object
	greyscale_config_worn = /datum/greyscale_config/cin_surplus_undersuit
	greyscale_config_worn_digi = /datum/greyscale_config/cin_surplus_undersuit/digi
	greyscale_colors = "#bbbbc9#bbbbc9#34343a"

/obj/item/clothing/under/syndicate/rus_army/cin_surplus/desert
	greyscale_colors = "#aa6d4c#aa6d4c#34343a"

/obj/item/clothing/under/syndicate/rus_army/cin_surplus/forest
	greyscale_colors = "#6D6D51#6D6D51#34343a"

/obj/item/clothing/under/syndicate/rus_army/cin_surplus/marine
	greyscale_colors = "#51517b#51517b#34343a"

/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color
	/// What colors the jumpsuit can spawn with (only does the arms and legs of it)
	var/static/list/possible_limb_colors = list(
		CIN_WINTER_COLORS,
		CIN_MOUNTAIN_DESERT_COLORS,
		CIN_FOREST_COLORS,
		CIN_MARINE_COLORS,
		CIN_EVIL_COLORS,
	)

/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color/Initialize(mapload)
	greyscale_colors = "[pick(possible_limb_colors)][pick(possible_limb_colors)][CIN_EVIL_COLORS]"

	. = ..()

// Vests

/obj/item/clothing/suit/armor/vest/cin_surplus_vest
	name = "\improper 'Klamra' armor vest"
	desc = "An outdated armor vest used by CIN military forces. \
		The design dates back to the years leading up to CIN - SolFed border war, and can still be seen today \
		in some parts of CIN territories where its not so important for equipment to be the best of the best. \
		While the armor will wear down over time, it covers both your arms and torso, and provides exceptional \
		projectile and laser protection."
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor_object.dmi'
	icon_state = "vest_basic"
	greyscale_config = /datum/greyscale_config/cin_surplus_vest/object
	greyscale_config_worn = /datum/greyscale_config/cin_surplus_vest
	greyscale_colors = CIN_WINTER_COLORS
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	limb_integrity = 150
	armor_type = /datum/armor/cin_surplus_armor
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_damaged_by_bullets, 0.75)

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/examine_more(mob/user)
	. = ..()

	. += "The 'Klamra' series of coalition armor was a collaborative project between the NRI and TransOrbital \
		to develop a frontline soldier's armor set that could withstand attacks from the Solar Federation's \
		then relatively new pulse ballistics. The design itself is based upon a far older pattern \
		of armor originally developed by SolFed themselves, which was the standard pattern of armor design \
		granted to the first colony ships leaving Sol. Armor older than any of the CIN member states, \
		upgraded with modern technology. This vest in particular is made up of several large, dense plates \
		front and back. While vests like this were also produced with extra plating to protect the groin, many \
		surplus vests are missing them due to the popularity of removing the plates and using them as seating \
		during wartime."

	return .

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/desert
	greyscale_colors = CIN_MOUNTAIN_DESERT_COLORS

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/forest
	greyscale_colors = CIN_FOREST_COLORS

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/marine
	greyscale_colors = CIN_MARINE_COLORS

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/random_color
	/// The different colors this can choose from when initializing
	var/static/list/possible_spawning_colors = list(
		CIN_WINTER_COLORS,
		CIN_MOUNTAIN_DESERT_COLORS,
		CIN_FOREST_COLORS,
		CIN_MARINE_COLORS,
		CIN_EVIL_COLORS,
	)

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/random_color/Initialize(mapload)
	greyscale_colors = pick(possible_spawning_colors)

	. = ..()

// Chest Rig

/obj/item/storage/belt/military/cin_surplus
	name = "'Mały' chest rig"
	desc = "The smaller of the two common CIN chest rigs, able to hold small items."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor_object.dmi'
	icon_state = "chestrig"
	worn_icon_state = "chestrig"
	greyscale_config = /datum/greyscale_config/cin_surplus_chestrig/object
	greyscale_config_worn = /datum/greyscale_config/cin_surplus_chestrig
	greyscale_colors = CIN_WINTER_COLORS_COMPLIMENT

/obj/item/storage/belt/military/cin_surplus/desert
	greyscale_colors = CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT

/obj/item/storage/belt/military/cin_surplus/forest
	greyscale_colors = CIN_FOREST_COLORS_COMPLIMENT

/obj/item/storage/belt/military/cin_surplus/marine
	greyscale_colors = CIN_MARINE_COLORS_COMPLIMENT

/obj/item/storage/belt/military/cin_surplus/random_color
	/// The different colors this can choose from when initializing
	var/static/list/possible_spawning_colors = list(
		CIN_WINTER_COLORS_COMPLIMENT,
		CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT,
		CIN_FOREST_COLORS_COMPLIMENT,
		CIN_MARINE_COLORS_COMPLIMENT,
		CIN_EVIL_COLORS_COMPLIMENT,
	)

/obj/item/storage/belt/military/cin_surplus/random_color/Initialize(mapload)
	greyscale_colors = pick(possible_spawning_colors)

	. = ..()

/obj/item/storage/belt/military/big_cin_surplus
	name = "'Ciężki' large chest rig"
	desc = "The larger of the two common CIN chest rigs, able to hold four normal sized items."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor_object.dmi'
	icon_state = "bigrig"
	worn_icon_state = "bigrig"
	greyscale_config = /datum/greyscale_config/cin_surplus_bigrig/object
	greyscale_config_worn = /datum/greyscale_config/cin_surplus_bigrig
	greyscale_colors = CIN_WINTER_COLORS_COMPLIMENT

/obj/item/storage/belt/military/big_cin_surplus/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/military/big_cin_surplus/desert
	greyscale_colors = CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT

/obj/item/storage/belt/military/big_cin_surplus/forest
	greyscale_colors = CIN_FOREST_COLORS_COMPLIMENT

/obj/item/storage/belt/military/big_cin_surplus/marine
	greyscale_colors = CIN_MARINE_COLORS_COMPLIMENT

/obj/item/storage/belt/military/big_cin_surplus/random_color
	/// The different colors this can choose from when initializing
	var/static/list/possible_spawning_colors = list(
		CIN_WINTER_COLORS_COMPLIMENT,
		CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT,
		CIN_FOREST_COLORS_COMPLIMENT,
		CIN_MARINE_COLORS_COMPLIMENT,
		CIN_EVIL_COLORS_COMPLIMENT,
	)

/obj/item/storage/belt/military/big_cin_surplus/random_color/Initialize(mapload)
	greyscale_colors = pick(possible_spawning_colors)

	. = ..()

// Backpack

/obj/item/storage/backpack/industrial/cin_surplus
	name = "\improper CIN military backpack"
	desc = "A rugged backpack often used by the CIN's military forces."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor_object.dmi'
	icon_state = "backpack"
	greyscale_config = /datum/greyscale_config/cin_surplus_backpack/object
	greyscale_config_worn = /datum/greyscale_config/cin_surplus_backpack
	greyscale_colors = CIN_WINTER_COLORS_COMPLIMENT

/obj/item/storage/backpack/industrial/cin_surplus/desert
	greyscale_colors = CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT

/obj/item/storage/backpack/industrial/cin_surplus/forest
	greyscale_colors = CIN_FOREST_COLORS_COMPLIMENT

/obj/item/storage/backpack/industrial/cin_surplus/marine
	greyscale_colors = CIN_MARINE_COLORS_COMPLIMENT

/obj/item/storage/backpack/industrial/cin_surplus/random_color
	/// The different colors this can choose from when initializing
	var/static/list/possible_spawning_colors = list(
		CIN_WINTER_COLORS_COMPLIMENT,
		CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT,
		CIN_FOREST_COLORS_COMPLIMENT,
		CIN_MARINE_COLORS_COMPLIMENT,
		CIN_EVIL_COLORS_COMPLIMENT,
	)

/obj/item/storage/backpack/industrial/cin_surplus/random_color/Initialize(mapload)
	greyscale_colors = pick(possible_spawning_colors)

	. = ..()

#undef CIN_WINTER_COLORS
#undef CIN_MOUNTAIN_DESERT_COLORS
#undef CIN_FOREST_COLORS
#undef CIN_MARINE_COLORS
#undef CIN_EVIL_COLORS

#undef CIN_WINTER_COLORS_COMPLIMENT
#undef CIN_MOUNTAIN_DESERT_COLORS_COMPLIMENT
#undef CIN_FOREST_COLORS_COMPLIMENT
#undef CIN_MARINE_COLORS_COMPLIMENT
#undef CIN_EVIL_COLORS_COMPLIMENT
