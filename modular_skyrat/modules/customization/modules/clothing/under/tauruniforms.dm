/obj/item/clothing/under
	/// Set in human_update_icons.dm, in both update_inv_wear_uniform() and update_inv_wear_suit(). Is set whenever a accessory overlay is shifted due to a taur sprite.
	var/has_overlays_shifted_due_to_taur = FALSE

/obj/item/clothing
	/// Used for storing applied_style, used in human_update_icons.dm
	var/applied_style_store

//Greyscale override for taur uniforms.

/obj/item/clothing/under/color
	greyscale_config_worn_taur_snake = /datum/greyscale_config/jumpsuit_worn/taur/snake

/obj/item/clothing/under/chameleon
	greyscale_config_worn_taur_snake = /datum/greyscale_config/jumpsuit_worn/taur/snake

/obj/item/clothing/under/rank/prisoner
	greyscale_config_worn_taur_snake = /datum/greyscale_config/jumpsuit_prison_worn/taur/snake

