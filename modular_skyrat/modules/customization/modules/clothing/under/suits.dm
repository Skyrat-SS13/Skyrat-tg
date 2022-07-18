
/obj/item/clothing/under/suit/fancy
	name = "fancy suit"
	desc = "A fancy suit and jacket with an elegant shirt."
	icon_state = "fancy_suit"
	greyscale_config = /datum/greyscale_config/fancy_suit
	greyscale_config_worn = /datum/greyscale_config/fancy_suit/worn
	greyscale_colors = "#FFFFFA#0075C4#7C787D"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = NONE


// Modular Overwrites
/obj/item/clothing/under/suit
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/suit/white/skirt
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/suit/black/skirt
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/suit/black_really/skirt
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
