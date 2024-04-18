
/obj/item/clothing/mask/masquerade
	name = "masquerade mask"
	desc = "You'll never guess who's under that mask, it's the perfect disguise!"
	icon_state = "maskerade"
	icon = 'modular_skyrat/modules/GAGS/icons/mask/masquerade_mask.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/mask/masquerade_mask_worn.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1
	clothing_flags = MASKINTERNALS
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION | CLOTHING_SNOUTED_VOX_VARIATION | CLOTHING_SNOUTED_BETTER_VOX_VARIATION
	greyscale_colors = "#ececec#333333#9b1e1e"
	greyscale_config = /datum/greyscale_config/masquerade_mask
	greyscale_config_worn = /datum/greyscale_config/masquerade_mask/worn
	greyscale_config_worn_muzzled = /datum/greyscale_config/masquerade_mask/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/masquerade_mask/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/masquerade_mask/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/masquerade_mask/worn/teshari

/obj/item/clothing/mask/masquerade/feathered
	name = "feathered masquerade mask"
	desc = "You'll never guess who's under that mask, it's the perfect disguise! This one even has a feather, to make it fancier!"
	icon_state = "maskerade_feather"

/obj/item/clothing/mask/masquerade/two_colors
	name = "split masquerade mask"
	desc = "You'll never guess who's under that mask, it's the perfect disguise! There's even two colors, to add to the confusion!"
	icon_state = "maskerade_two_colors"

/obj/item/clothing/mask/masquerade/two_colors/feathered
	name = "feathered split masquerade mask"
	desc = "You'll never guess who's under that mask, it's the perfect disguise! There's even two colors AND a feather, making it the most fancy masquerade mask yet!"
	icon_state = "maskerade_two_colors_feather"
