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
	icon_state = "lewdapron_pink"
	base_icon_state = "lewdapron"
	inhand_icon_state = "lewdapron_pink"
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

/obj/item/clothing/under/costume/lewdmaid/Initialize(mapload)
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

//to change model
/obj/item/clothing/accessory/lewdapron/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, apron_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_color = choice
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/// to check if we can change kinkphones's model
/obj/item/clothing/accessory/lewdapron/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/accessory/lewdapron/Initialize(mapload)
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!length(apron_designs))
		populate_apron_designs()
	update_icon_state()
	update_icon()
	. = ..()

/obj/item/clothing/accessory/lewdapron/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(base_icon_state)]_[current_color]"
	inhand_icon_state = "[initial(base_icon_state)]_[current_color]"

/obj/item/clothing/under/costume/lewdmaid/attach_accessory(obj/item/attack_item)
	. = ..()
	var/obj/item/clothing/accessory/prime_accessory = attached_accessories[1]
	var/accessory_color = prime_accessory.icon_state
	accessory_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "[accessory_color]", ABOVE_MOB_LAYER + 0.1)
	accessory_overlay.alpha = prime_accessory.alpha
	accessory_overlay.color = prime_accessory.color
	if(!ishuman(loc))
		return TRUE
	var/mob/living/carbon/human/wearer = loc
	wearer.update_worn_undersuit()
	wearer.update_worn_oversuit()
	wearer.fan_hud_set_fandom()
	return TRUE

//Not a maid, yeah. I dont care, it's going with the other lewd stuff, and there WONT be a whole new file just for it.
/obj/item/clothing/under/costume/bunnylewd
	name = "bunny suit"
	desc = "Makes the wearer more attractive, even men."
	icon_state = "bunnysuit"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN
	can_adjust = TRUE
	alt_covers_chest = FALSE

/obj/item/clothing/under/costume/bunnylewd/white
	name = "white bunny suit"
	icon_state = "whitebunnysuit"
	can_adjust = FALSE
