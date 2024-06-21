// The naming of every path in this file is going to be awful :smiling_imp:

// Outfit Datum

/datum/outfit/primitive_catgirl
	name = "Icemoon Dweller"

	uniform = /obj/item/clothing/under/dress/skirt/primitive_catgirl_body_wraps
	shoes = /obj/item/clothing/shoes/winterboots/ice_boots/primitive_catgirl_boots
	gloves = /obj/item/clothing/gloves/fingerless/primitive_catgirl_armwraps
	suit = /obj/item/clothing/suit/jacket/primitive_catgirl_coat
	neck = /obj/item/clothing/neck/scarf/primitive_catgirl_scarf

	back = /obj/item/forging/reagent_weapon/axe/fake_copper

// Under

/obj/item/clothing/under/dress/skirt/primitive_catgirl_body_wraps
	name = "body wraps"
	desc = "Some pretty simple wraps to cover up your lower bits."
	icon_state = "wraps"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	body_parts_covered = GROIN
	greyscale_config = /datum/greyscale_config/primitive_catgirl_wraps
	greyscale_config_worn = /datum/greyscale_config/primitive_catgirl_wraps/worn
	greyscale_colors = "#cec8bf#364660"
	flags_1 = IS_PLAYER_COLORABLE_1
	has_sensor = FALSE

// Hands

/obj/item/clothing/gloves/fingerless/primitive_catgirl_armwraps
	name = "arm wraps"
	desc = "Simple cloth to wrap around one's arms."
	icon_state = "armwraps"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	greyscale_config = /datum/greyscale_config/primitive_catgirl_armwraps
	greyscale_config_worn = /datum/greyscale_config/primitive_catgirl_armwraps/worn
	greyscale_colors = "#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/gloves/fingerless/primitive_catgirl_gauntlets
	name = "gauntlets"
	desc = "Simple cloth arm wraps with overlying metal protection."
	icon_state = "gauntlets"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	greyscale_config = /datum/greyscale_config/primitive_catgirl_gauntlets
	greyscale_config_worn = /datum/greyscale_config/primitive_catgirl_gauntlets/worn
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = "#cec8bf#c55a1d"
	flags_1 = IS_PLAYER_COLORABLE_1

// Suit

/obj/item/clothing/suit/jacket/primitive_catgirl_coat
	name = "primitive fur coat"
	desc = "A large piece of animal hide stuffed with fur, likely from the same animal."
	icon_state = "coat"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	body_parts_covered = CHEST
	cold_protection = CHEST
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/primitive_catgirl_coat
	greyscale_config_worn = /datum/greyscale_config/primitive_catgirl_coat/worn
	greyscale_colors = "#594032#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/apron/chef/colorable_apron/primitive_catgirl_leather
	greyscale_colors = "#594032"

// Shoes

/obj/item/clothing/shoes/winterboots/ice_boots/primitive_catgirl_boots
	name = "primitive hiking boots"
	desc = "A pair of heavy boots lined with fur and with soles special built to prevent slipping on ice."
	icon_state = "boots"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	greyscale_config = /datum/greyscale_config/primitive_catgirl_boots
	greyscale_config_worn = /datum/greyscale_config/primitive_catgirl_boots/worn
	greyscale_colors = "#594032#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1

// Neck

/obj/item/clothing/neck/scarf/primitive_catgirl_scarf
	greyscale_colors = "#cec8bf#cec8bf"

/obj/item/clothing/neck/large_scarf/primitive_catgirl_off_white
	greyscale_colors = "#cec8bf#cec8bf"

/obj/item/clothing/neck/infinity_scarf/primitive_catgirl_blue
	greyscale_colors = "#364660"

/obj/item/clothing/neck/mantle/recolorable/primitive_catgirl_off_white
	greyscale_colors = "#cec8bf"

/obj/item/clothing/neck/ranger_poncho/primitive_catgirl_leather
	greyscale_colors = "#594032#594032"

// Masks

/obj/item/clothing/mask/primitive_catgirl_greyscale_gaiter
	name = "neck gaiter"
	desc = "A cloth for covering your neck, and usually part of your face too, but that part's optional."
	icon_state = "gaiter"
	inhand_icon_state = "balaclava"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	greyscale_config = /datum/greyscale_config/primitive_catgirl_gaiter
	greyscale_config_worn = /datum/greyscale_config/primitive_catgirl_gaiter/worn
	greyscale_colors = "#364660"
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_inv = HIDEFACE|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH
	flags_1 = IS_PLAYER_COLORABLE_1
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/primitive_catgirl_greyscale_gaiter/attack_self(mob/user)
	adjust_visor(user)

// Head

/obj/item/clothing/head/hooded/standalone_hood/primitive_catgirl_colors
	greyscale_colors = "#594032#364660"

// Misc Items

/obj/item/forging/reagent_weapon/axe/fake_copper
	custom_materials = list(/datum/material/copporcitite = SHEET_MATERIAL_AMOUNT)
