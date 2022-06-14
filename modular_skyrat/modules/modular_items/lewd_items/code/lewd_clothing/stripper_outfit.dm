/obj/item/clothing/under/stripper_outfit
	name = "stripper outfit"
	desc = "An item of clothing that leaves little to the imagination."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL
	can_adjust = FALSE
	icon_state = "stripper_cyan"
	inhand_icon_state = "stripper_cyan"
	unique_reskin = list("Cyan" = "stripper_cyan",
						"Yellow" = "stripper_yellow",
						"Green" = "stripper_green",
						"Red" = "stripper_red",
						"Latex" = "stripper_latex",
						"Orange" = "stripper_orange",
						"White" = "stripper_white",
						"Purple" = "stripper_purple",
						"Black" = "stripper_black",
						"Black-teal" = "stripper_tealblack")

/obj/item/clothing/under/stripper_outfit/AltClick(mob/user)
	. = ..()
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		reskin_obj(user)
