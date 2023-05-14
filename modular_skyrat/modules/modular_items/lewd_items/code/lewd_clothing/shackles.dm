/obj/item/clothing/suit/straight_jacket/shackles
	name = "shackles"
	desc = "Fancy shackles with a fake lock."
	inhand_icon_state = null
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	icon_state = "shackles_metal"
	base_icon_state = "shackles"
	body_parts_covered = null//they don't cover anything, but these code parts need to be here, because if they are not here - they make clothing disappear. Magic.
	flags_inv = null
	equip_delay_self = NONE
	strip_delay = 120
	breakouttime = 5 SECONDS //Users should always have the option to stop an uncomfortable situation. No ERP item should have a breakout time longer than 5 seconds.

	slowdown = 1
	/// The current variant of the shackles' color.
	var/current_color = "metal" //yes, metal color. Don't ask.
	var/color_changed = FALSE
	var/static/list/shackles_designs

/*
*	MODEL CHANGES
*/

//create radial menu
/obj/item/clothing/suit/straight_jacket/shackles/proc/populate_shackles_designs()
	shackles_designs = list(
		"pink" = image (icon = src.icon, icon_state = "shackles_pink"),
		"teal" = image (icon = src.icon, icon_state = "shackles_teal"),
		"metal" = image (icon = src.icon, icon_state = "shackles_metal"))

//to change model
/obj/item/clothing/suit/straight_jacket/shackles/AltClick(mob/user)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user, src, shackles_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change shackles' model
/obj/item/clothing/suit/straight_jacket/shackles/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/suit/straight_jacket/shackles/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	if(!length(shackles_designs))
		populate_shackles_designs()

/obj/item/clothing/suit/straight_jacket/shackles/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"
	inhand_icon_state = "[base_icon_state]_[current_color]"

//message when equipping that thing
/obj/item/clothing/suit/straight_jacket/shackles/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	if(src == affected_mob.wear_suit)
		to_chat(user, span_purple("The shackles are restraining your body."))
	else
		return

//message when unequipping that thing
/obj/item/clothing/suit/straight_jacket/shackles/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	if(src == affected_mob.wear_suit)
		to_chat(user, span_purple("The shackles are no longer restraining your body."))
