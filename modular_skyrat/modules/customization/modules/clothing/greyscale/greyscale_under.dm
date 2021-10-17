/*
Self explanatory, this file is for uniforms that are GAGSified. If it doesnt have greyscale, it doesnt go here.
*/
/obj/item/clothing/under/sweater
	name = "turtleneck sweater"
	desc = "Why trade style for comfort? Now you can go commando down south and still be cozy up north."
	icon_state = "bb_turtle"
	greyscale_config = /datum/greyscale_config/hoodie/branded
	greyscale_config_worn = /datum/greyscale_config/hoodie/branded/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF"
	body_parts_covered = CHEST|GROIN|ARMS
	mutant_variants = NONE
	can_adjust = TRUE

///Preset greyscales
/obj/item/clothing/under/sweater/cream
	greyscale_colors = "#E1D9C9"

/obj/item/clothing/under/sweater/black
	greyscale_colors = "#303030"

/obj/item/clothing/under/sweater/purple
	greyscale_colors = "#400062"

/obj/item/clothing/under/sweater/green
	greyscale_colors = "#09591D"

/obj/item/clothing/under/sweater/red
	greyscale_colors = "#620000"

/obj/item/clothing/under/sweater/blue
	greyscale_colors = "#000082"

//Todo - greyscale this?
/obj/item/clothing/under/sweater/keyhole
	name = "keyhole sweater"
	desc = "What is the point of this, anyway?"
	icon_state = "keyholesweater"
	can_adjust = FALSE

/obj/item/clothing/under/misc/kilt
	name = "kilt"
	desc = "It's not a skirt!"
	icon_state = "kilt"
	greyscale_config = /datum/greyscale_config/hoodie/branded
	greyscale_config_worn = /datum/greyscale_config/hoodie/branded/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	mutant_variants = NONE

/obj/item/clothing/under/dress/skirt/polychromic
/obj/item/clothing/under/dress/skirt/polychromic/pleated
/obj/item/clothing/under/misc/poly_shirt
/obj/item/clothing/under/misc/polyshorts
/obj/item/clothing/under/misc/polyjumpsuit
/obj/item/clothing/under/misc/poly_bottomless
/obj/item/clothing/under/misc/polysweater
/obj/item/clothing/under/misc/poly_tanktop
/obj/item/clothing/under/misc/poly_tanktop/female
/obj/item/clothing/under/shorts/polychromic
/obj/item/clothing/under/shorts/polychromic/pantsu


/obj/item/card/id/advanced/polychromic
