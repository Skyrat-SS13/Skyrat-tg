/obj/item/clothing/glasses/blindfold/kinky
	name = "kinky blindfold"
	desc = "Covers the eyes, preventing sight. But it looks so nice..."
	icon_state = "kblindfold_pink"
	base_icon_state = "kblindfold"
	inhand_icon_state = "kblindfold_pink"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_eyes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_eyes.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// IF the color has been changed before
	var/color_changed = FALSE
	/// Current color of the blindfold. Can be changed and affect sprite
	var/current_kinkfold_color = "pink"
	/// List of blindfold designs, used when picking one in the radial menu
	var/static/list/kinkfold_designs

//create radial menu
/obj/item/clothing/glasses/blindfold/kinky/proc/populate_kinkfold_designs()
	kinkfold_designs = list(
		"pink" = image (icon = src.icon, icon_state = "kblindfold_pink"),
		"teal" = image(icon = src.icon, icon_state = "kblindfold_teal"))

//to change model
/obj/item/clothing/glasses/blindfold/kinky/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, kinkfold_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_kinkfold_color = choice
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/// to check if we can change kinkphones's model
/obj/item/clothing/glasses/blindfold/kinky/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/glasses/blindfold/kinky/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	if(!length(kinkfold_designs))
		populate_kinkfold_designs()

/obj/item/clothing/glasses/blindfold/kinky/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_kinkfold_color]"
	inhand_icon_state = "[base_icon_state]_[current_kinkfold_color]"

//message when equipping that thing
/obj/item/clothing/glasses/blindfold/kinky/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(src == user.glasses)
		to_chat(user, span_purple("The blindfold blocks your vision! You can't make out anything on the other side..."))

//message when unequipping that thing
/obj/item/clothing/glasses/blindfold/kinky/dropped(mob/living/carbon/user)
	. = ..()
	if(src == user.glasses)
		to_chat(user, span_purple("The blindfold no longer restricts your vision."))
