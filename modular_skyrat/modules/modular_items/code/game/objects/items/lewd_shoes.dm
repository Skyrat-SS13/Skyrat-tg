//heels item
/obj/item/clothing/shoes/latexheels
	name = "latex heels"
	desc = "Lace up before use. Pretty hard to walk in these."
	icon_state = "latexheels"
	inhand_icon_state = "latexheels"
	icon = 'modular_skyrat/modules/modular_items/icons/obj/items/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/icons/mob/lewd_shoes_digi.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/icons/mob/lewd_shoes.dmi'
	equip_delay_other = 120
	equip_delay_self = 120
	strip_delay = 120
	slowdown = 4

//it takes time to put them off, do not touch
/obj/item/clothing/shoes/latexheels/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.shoes)
			if(!do_after(C, 40, target = src))
				return
	. = ..()

//latex socks item
/obj/item/clothing/shoes/latex_socks
	name = "Latex socks"
	desc = "Splitting toe shiny socks made of some strange material."
	icon_state = "latexsocks"
	inhand_icon_state = "latexsocks"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_skyrat/modules/modular_items/icons/obj/items/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/icons/mob/lewd_shoes_digi.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/icons/mob/lewd_shoes.dmi'
