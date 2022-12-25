// Under

/obj/item/clothing/under/dress/skirt/icebox_catgirl_body_wraps
	name = "body wraps"
	desc = "Some pretty simple wraps to cover up the chest and the groin."
	icon_state = "wraps"
	icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi'
	body_parts_covered = GROIN|CHEST
	greyscale_config = /datum/greyscale_config/icebox_catgirl_wraps
	greyscale_config_worn = /datum/greyscale_config/icebox_catgirl_wraps/worn
	greyscale_colors = "#cec8bf#364660"
	flags_1 = IS_PLAYER_COLORABLE_1
"#cec8bf"
"#364660"
"#594032"
// Hands

/obj/item/clothing/gloves/fingerless/icebox_catgirl_armwraps
	name = "arm wraps"
	desc = "Simple cloth to wrap around one's arms."
	icon_state = "armwraps"
	icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi'
	greyscale_config = /datum/greyscale_config/icebox_catgirl_armwraps
	greyscale_config_worn = /datum/greyscale_config/icebox_catgirl_armwraps/worn
	greyscale_colors = "#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1

// Suit

/obj/item/clothing/suit/jacket/icebox_catgirl_coat
	name = "primitive fur coat"
	desc = "A large piece of animal hide stuffed with fur, likely from the same animal."
	icon_state = "coat"
	icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi'
	body_parts_covered = CHEST
	cold_protection = CHEST
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/icebox_catgirl_coat
	greyscale_config_worn = /datum/greyscale_config/icebox_catgirl_coat/worn
	greyscale_colors = "#594032#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1

// Shoes

/obj/item/clothing/shoes/winterboots/ice_boots/icebox_catgirl_boots
	name = "primitive hiking boots"
	desc = "A pair of heavy boots lined with fur and with soles special built to prevent slipping on ice."
	icon_state = "boots"
	icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_skyrat/modules/icebox_catgirls/icons/clothing_greyscale.dmi
	greyscale_config = /datum/greyscale_config/icebox_catgirl_boots
	greyscale_config_worn = /datum/greyscale_config/icebox_catgirl_boots/worn
	greyscale_colors = "#594032#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1
