/obj/item/clothing/under/costume/lewdmaid
	name = "latex maid costume"
	desc = "A maid costume made of a thick latex."
	icon_state = "lewdmaid"
	inhand_icon_state = "lewdmaid"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	body_parts_covered = CHEST
	can_adjust = FALSE

/obj/item/clothing/accessory/lewdapron
	name = "shiny maid apron"
	desc = "The best part of a maid costume. Now with different colors!"
	icon_state = "lewdapron"
	inhand_icon_state = "lewdapron"
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	minimize_when_attached = FALSE
	attachment_slot = null
	/// If the color has been changed before
	var/color_changed = FALSE
	/// Current color of the apron, can change and affects sprite
	var/current_color = "red"
	/// List of all apron designs, used in selecting one in the radial menu
	var/static/list/apron_designs

/obj/item/clothing/under/costume/lewdmaid/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/lewdapron/apron_accessory = new(src)
	attach_accessory(apron_accessory)

/// create radial menu
/obj/item/clothing/accessory/lewdapron/proc/populate_apron_designs()
	apron_designs = list(
		"red" = image (icon = src.icon, icon_state = "lewdapron_red"),
		"green" = image (icon = src.icon, icon_state = "lewdapron_green"),
		"pink" = image (icon = src.icon, icon_state = "lewdapron_pink"),
		"teal" = image(icon = src.icon, icon_state = "lewdapron_teal"),
		"yellow" = image (icon = src.icon, icon_state = "lewdapron_yellow"))

//to update model lol
/obj/item/clothing/accessory/lewdapron/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/accessory/lewdapron/AltClick(mob/user)
	if(color_changed)
		return
	. = ..()
	if(.)
		return
	var/choice = show_radial_menu(user, src, apron_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	current_color = choice
	update_icon()
	color_changed = TRUE

/// to check if we can change kinkphones's model
/obj/item/clothing/accessory/lewdapron/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/accessory/lewdapron/Initialize()
	if(!length(apron_designs))
		populate_apron_designs()
	update_icon_state()
	update_icon()
	. = ..()

/obj/item/clothing/accessory/lewdapron/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/under/costume/lewdmaid/attach_accessory(obj/item/attack_item)
	. = ..()
	var/accessory_color = attached_accessory.icon_state
	accessory_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "[accessory_color]", ABOVE_MOB_LAYER + 0.1)
	accessory_overlay.alpha = attached_accessory.alpha
	accessory_overlay.color = attached_accessory.color
	if(!ishuman(loc))
		return TRUE
	var/mob/living/carbon/human/wearer = loc
	wearer.update_inv_w_uniform()
	wearer.update_inv_wear_suit()
	wearer.fan_hud_set_fandom()
	return TRUE
