/obj/item/clothing/ears/kinky_headphones
	name = "kinky headphones"
	desc = "Protect your ears from loud noises. It has a switch on the right hand side."
	icon_state = "kinkphones"
	inhand_icon_state = "kinkphones"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_ears.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_ears.dmi'
	strip_delay = 15
	custom_price = PAYCHECK_CREW * 2
	/// If the headphones are on or off
	var/kinky_headphones_on = FALSE
	/// Current color of the headphones, can affect sprite and can change
	var/current_kinkphones_color = "pink"
	/// If the color has been changed before
	var/color_changed = FALSE
	/// List of designs used when picking a color in the radial menu
	var/static/list/kinkphones_designs
	actions_types = list(/datum/action/item_action/toggle_kinky_headphones)
	slot_flags = ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_NECK
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'

//create radial menu
/obj/item/clothing/ears/kinky_headphones/proc/populate_kinkphones_designs()
	kinkphones_designs = list(
		"pink" = image (icon = src.icon, icon_state = "kinkphones_pink_on"),
		"teal" = image(icon = src.icon, icon_state = "kinkphones_teal_on"))

//to prevent hearing and e.t.c
/obj/item/clothing/ears/kinky_headphones/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/earhealing)
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/ears/kinky_headphones/AltClick(mob/user)
	if(color_changed)
		return
	. = ..()
	if(.)
		return
	var/choice = show_radial_menu(user, src, kinkphones_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	current_kinkphones_color = choice
	update_icon()
	color_changed = TRUE

/// to check if we can change kinkphones's model
/obj/item/clothing/ears/kinky_headphones/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

//we equipping it so we deaf now
/obj/item/clothing/ears/kinky_headphones/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(istype(user) && slot == ITEM_SLOT_EARS))
		return
	to_chat(user, span_purple("[!kinky_headphones_on ? "You can barely hear anything! Your other senses have become more apparent..." : "Strange but relaxing music fills your mind. You feel so... Calm."]"))
	ADD_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)

//we dropping item so we not deaf now. hurray.
/obj/item/clothing/ears/kinky_headphones/dropped(mob/living/carbon/human/user)
	. = ..()
	if(!(src == user.ears))
		return
	REMOVE_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
	to_chat(user, span_purple("You can finally hear the world around you once more."))


//to make it change model on click

/obj/item/clothing/ears/kinky_headphones/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(kinkphones_designs))
		populate_kinkphones_designs()

/obj/item/clothing/ears/kinky_headphones/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_kinkphones_color]_[kinky_headphones_on? "on" : "off"]"
	inhand_icon_state = "[initial(icon_state)]_[current_kinkphones_color]_[kinky_headphones_on? "on" : "off"]"

/obj/item/clothing/ears/kinky_headphones/proc/toggle(owner)
	kinky_headphones_on = !kinky_headphones_on
	update_icon()
	to_chat(owner, span_notice("You turn the music [kinky_headphones_on ? "on. It plays relaxing music." : "off."]"))

/datum/action/item_action/toggle_kinky_headphones
	name = "Toggle kinky headphones"
	desc = "Plays some nice relaxing music"

/datum/action/item_action/toggle_kinky_headphones/Trigger(trigger_flags)
	var/obj/item/clothing/ears/kinky_headphones/headphones = target
	if(istype(headphones))
		headphones.toggle(owner)
