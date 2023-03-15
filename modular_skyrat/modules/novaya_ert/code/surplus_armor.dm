// THESE WILL (MOSTLY) SPAWN WITH A RANDOM 'CAMO' COLOR WHEN ORDERED THROUGH CARGO
// THE STANDARD COLORS FOR USE WILL BE BELOW

#define NRI_WINTER_COLORS "#bbbbc9"
#define NRI_MOUNTAIN_DESERT_COLORS "#aa6d4c"
#define NRI_FOREST_COLORS "#6D6D51"
#define NRI_MARINE_COLORS "#51517b"
#define NRI_EVIL_COLORS "#5d5d66"

// Hats

/obj/item/clothing/head/helmet/nri_surplus_helmet
	name = "\improper GZ-03 combat helmet"
	desc = "An outdated service helmet previously used by CIN military forces. The design dates back to the years leading up to CIN - SolFed border war, and was in service until the advent of VOSKHOD powered armor becoming standard issue."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	icon_state = "helmet_plain"
	greyscale_config = /datum/greyscale_config/nri_surplus_helmet
	greyscale_config_worn = /datum/greyscale_config/nri_surplus_helmet
	greyscale_colors = NRI_WINTER_COLORS
	armor_type = /datum/armor/rus_helmet_nri
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

	/// Controls what helmet accessories will be present in a weighted format
	var/static/list/accessories_weighted_list = list(
		"plain" = 15,
		"strap" = 10,
		"glass" = 10,
		"both" = 5,
	)

/obj/item/clothing/head/helmet/nri_surplus_helmet/Initialize(mapload)
	. = ..()

	generate_random_accessories()

/// Takes accessories_weighted_list and picks what icon_state suffix to use
/obj/item/clothing/head/helmet/nri_surplus_helmet/proc/generate_random_accessories()
	var/chosen_accessories = pick_weight(accessories_weighted_list)

	icon_state = "helmet_[chosen_accessories]"
	update_appearance()

/obj/item/clothing/head/helmet/nri_surplus_helmet/examine_more(mob/user)
	. = ..()

	. += "The GZ-03 series of coalition armor was a collaborative project between the NRI and TransOrbital \
		to develop a frontline soldier's armor set that could withstand attacks from the Solar Federation's \
		then relatively new pulse ballistics. The design itself is based upon a far older pattern \
		of armor originally developed by SolFed themselves, which was the standard pattern of armor design \
		granted to the first colony ships leaving Sol. Armor older than any of the CIN member states, \
		upgraded with modern technology. This helmet in particular encloses the entire head save for \
		the face, and should come with a glass visor and relatively comfortable internal padding. Should, \
		anyways, surplus units such as this are infamous for arriving with several missing accessories."

	return .

/obj/item/clothing/head/helmet/nri_surplus_helmet/desert
	greyscale_colors = NRI_MOUNTAIN_DESERT_COLORS

/obj/item/clothing/head/helmet/nri_surplus_helmet/forest
	greyscale_colors = NRI_FOREST_COLORS

/obj/item/clothing/head/helmet/nri_surplus_helmet/marine
	greyscale_colors = NRI_MARINE_COLORS

/obj/item/clothing/head/helmet/nri_surplus_helmet/random_color
	/// The different colors this helmet can choose from when initializing
	var/static/list/possible_spawning_colors = list(
		NRI_WINTER_COLORS,
		NRI_MOUNTAIN_DESERT_COLORS,
		NRI_FOREST_COLORS,
		NRI_MARINE_COLORS,
		NRI_EVIL_COLORS,
	)

/obj/item/clothing/head/helmet/nri_surplus_helmet/random_color/Initialize(mapload)
	greyscale_colors = pick(possible_spawning_colors)

	. = ..()

// Undersuits

/obj/item/clothing/under/syndicate/rus_army/nri_surplus
	name = "surplus nri uniform"
	desc = "Wait a minute, there should be something here!."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	icon_state = "undersuit_greyscale"
	greyscale_config = /datum/greyscale_config/nri_surplus_undersuit
	greyscale_config_worn = /datum/greyscale_config/nri_surplus_undersuit
	greyscale_config_worn_digi = /datum/greyscale_config/nri_surplus_undersuit/digi
	greyscale_colors = "#bbbbc9#bbbbc9#34343a"

/obj/item/clothing/under/syndicate/rus_army/nri_surplus/Initialize(mapload)
	. = ..()

/*
	var/camo_icon_to_use = icon('modular_skyrat/modules/novaya_ert/icons/surplus_armor/camo_overlay.dmi', "tiger_[rand(1, 3)]")

	ADD_KEEP_TOGETHER(src, INNATE_TRAIT)
	add_filter("camo_clothing_filter", priority = 1, params = layering_filter(icon = camo_icon_to_use, blend_mode = BLEND_INSET_OVERLAY))
*/

/obj/item/clothing/under/syndicate/rus_army/nri_surplus/desert
	greyscale_colors = "#aa6d4c#aa6d4c#34343a"

/obj/item/clothing/under/syndicate/rus_army/nri_surplus/forest
	greyscale_colors = "#6D6D51#6D6D51#34343a"

/obj/item/clothing/under/syndicate/rus_army/nri_surplus/marine
	greyscale_colors = "#51517b#51517b#34343a"

/obj/item/clothing/under/syndicate/rus_army/nri_surplus/random_color
	/// What colors the jumpsuit can spawn with (only does the arms and legs of it)
	var/static/list/possible_limb_colors = list(
		NRI_WINTER_COLORS,
		NRI_MOUNTAIN_DESERT_COLORS,
		NRI_FOREST_COLORS,
		NRI_MARINE_COLORS,
	)

/obj/item/clothing/under/syndicate/rus_army/nri_surplus/random_color/Initialize(mapload)
	greyscale_colors = "[pick(possible_limb_colors)][pick(possible_limb_colors)][NRI_EVIL_COLORS]"

	. = ..()

// Vests

/obj/item/clothing/suit/armor/vest/nri_surplus_vest
name = "\improper GZ-03 combat armor"
	desc = "An outdated armor vest previously used by CIN military forces. The design dates back to the years leading up to CIN - SolFed border war, and was in service until the advent of VOSKHOD powered armor becoming standard issue."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_armor/surplus_armor.dmi'
	icon_state = "vest_basic"
	armor_type = /datum/armor/russian_nri
	supports_variations_flags = CLOTHING_NO_VARIATION

	/// Weighted list for determining if the vest will have its extra plates or not
	var/static/list/extra_plates_yeah_or_nah = list(
		"has_da_plates" = 1,
		"do_not_the_cat" = 2,
	)

/obj/item/clothing/suit/armor/vest/nri_surplus_vest/Initialize(mapload)
	. = ..()

	generate_random_accessories()

/// Decides if the armor vest should have its extra plates or not
/obj/item/clothing/suit/armor/vest/nri_surplus_vest/proc/generate_random_accessories()
	if(pick_weight(extra_plates_yeah_or_nah) == "has_da_plates")
		icon_state = "vest_extra"
	else
		icon_state = "vest_basic"

	update_appearance()

/obj/item/clothing/suit/armor/vest/nri_surplus_vest/examine_more(mob/user)
	. = ..()

	. += "The GZ-03 series of coalition armor was a collaborative project between the NRI and TransOrbital \
		to develop a frontline soldier's armor set that could withstand attacks from the Solar Federation's \
		then relatively new pulse ballistics. The design itself is based upon a far older pattern \
		of armor originally developed by SolFed themselves, which was the standard pattern of armor design \
		granted to the first colony ships leaving Sol. Armor older than any of the CIN member states, \
		upgraded with modern technology. This vest in particular is made up of several large, dense plates \
		front and back. While vests like this were also produced with extra plating to protect the groin, many \
		surplus vests are missing them due to the popularity of removing the plates and using them as seating \
		during wartime."

	return .

#undef NRI_WINTER_COLORS
#undef NRI_MOUNTAIN_DESERT_COLORS
#undef NRI_FOREST_COLORS
#undef NRI_MARINE_COLORS
#undef NRI_EVIL_COLORS
