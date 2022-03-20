/obj/item/clothing/under
	var/has_overlays_shifted_due_to_taur = FALSE

/obj/item/clothing
	var/applied_style_store

//Greyscale override for taur uniforms.

/obj/item/clothing/under/color
	greyscale_config_worn_taur_snake = /datum/greyscale_config/jumpsuit_worn/taur/snake

/obj/item/clothing/under/chameleon
	greyscale_config_worn_taur_snake = /datum/greyscale_config/jumpsuit_worn/taur/snake

/obj/item/clothing/under/rank/prisoner
	greyscale_config_worn_taur_snake = /datum/greyscale_config/jumpsuit_prison_worn/taur/snake

