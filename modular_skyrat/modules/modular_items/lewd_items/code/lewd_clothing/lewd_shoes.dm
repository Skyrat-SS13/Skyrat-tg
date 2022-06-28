//heels item
/obj/item/clothing/shoes/latexheels
	name = "latex heels"
	desc = "A pair of latex heels. Lace up before use."
	icon_state = "latexheels"
	inhand_icon_state = "latexheels"
	// We really need to find a way to condense there.
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL
  
/obj/item/clothing/shoes/latexheels/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/modules/modular_items/lewd_items/sounds/highheel1.ogg' = 1, 'modular_skyrat/modules/modular_items/lewd_items/sounds/highheel2.ogg' = 1), 70)

/*
*	LATEX SOCKS
*/

/obj/item/clothing/shoes/latex_socks
	name = "latex socks"
	desc = "A pair of shiny, split-toe socks made of some strange material."
	icon_state = "latexsocks"
	inhand_icon_state = "latexsocks"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
