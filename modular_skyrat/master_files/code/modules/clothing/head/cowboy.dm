/obj/item/clothing/head/cowboy
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/cowboy/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/cowboy.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/cowboy.dmi'
	worn_icon_state = null //TG defaults this to "hunter" and breaks our items
	flags_inv = SHOWSPRITEEARS
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0) //TG defaults cowboy hats with armor
	resistance_flags = NONE //TG defaults cowboy hats to fireproof/acidproof

/obj/item/clothing/head/cowboy/skyrat/wide
	name = "wide brimmed hat"
	desc = "A wide-brimmed hat, to keep the sun out of your eyes in style."
	icon_state = "widebrimmed"
	greyscale_colors = "#4D4D4D#DE9754"
	greyscale_config = /datum/greyscale_config/cowboy_wide
	greyscale_config_worn = /datum/greyscale_config/cowboy_wide/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/cowboy/skyrat/wide/feathered
	name = "wide brimmed feathered hat"
	desc = "A wide-brimmed hat adorned with a feather, the perfect flourish to a rugged outfit."
	icon_state = "widebrimmed_feathered"
	greyscale_colors = "#4D4D4D#DE9754#D5D5B9"
	greyscale_config = /datum/greyscale_config/cowboy_wide_feathered
	greyscale_config_worn = /datum/greyscale_config/cowboy_wide_feathered/worn

/obj/item/clothing/head/cowboy/skyrat/flat
	name = "flat brimmed hat"
	desc = "A finely made hat with a short flat brim, perfect for an old fashioned shootout."
	icon_state = "flatbrimmed"
	greyscale_colors = "#BE925B#914C2F"
	greyscale_config = /datum/greyscale_config/cowboy_flat
	greyscale_config_worn = /datum/greyscale_config/cowboy_flat/worn
	flags_1 = IS_PLAYER_COLORABLE_1

//Flat-brim Presets
/obj/item/clothing/head/cowboy/skyrat/flat/sheriff
	name = "sheriff hat"
	desc = "A dark brown hat with a smell of whiskey. There's a small set of antlers embroidered on the inside."
	greyscale_colors = "#704640#8f89ae"
	flags_1 = NONE //No recoloring presets

/obj/item/clothing/head/cowboy/skyrat/flat/deputy
	name = "deputy hat"
	desc = "A light brown hat with a smell of iron. There's a small set of antlers embroidered on the inside."
	greyscale_colors = "#c26934#8f89ae"
	flags_1 = NONE //No recoloring presets

//NOT CHANGED YET
/obj/item/clothing/head/costume/cowboyhat/sheriff
	name = "winter cowboy hat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "sheriff_hat"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	desc = "A dark hat from the cold wastes of the Frosthill mountains. So it was done, all according to the law. There's a small set of antlers embroidered on the inside."
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR | SHOWSPRITEEARS
