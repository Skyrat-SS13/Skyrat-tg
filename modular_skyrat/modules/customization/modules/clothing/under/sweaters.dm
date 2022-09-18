/obj/item/clothing/under/sweater
	name = "sweater"
	desc = "Why trade style for comfort? Now you can go commando down south and still be cozy up north."
	icon_state = "sweater"
	greyscale_config = /datum/greyscale_config/sweater
	greyscale_config_worn = /datum/greyscale_config/sweater/worn
	greyscale_colors = "#b2a484"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = TRUE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/sweater/black
	name = "black sweater"
	greyscale_colors = "#4f4f4f"

/obj/item/clothing/under/sweater/red
	name = "red sweater"
	greyscale_colors = "#9a0000"

/obj/item/clothing/under/keyhole_sweater
	name = "keyhole sweater"
	desc = "What is the point of this, anyway?"
	icon_state = "keyholesweater"
	greyscale_config = /datum/greyscale_config/sweater/keyhole
	greyscale_config_worn = /datum/greyscale_config/sweater/keyhole/worn
	greyscale_colors = "#920092"
	can_adjust = TRUE
	flags_1 = IS_PLAYER_COLORABLE_1
