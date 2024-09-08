/obj/item/clothing/head/deprivation_helmet
	name = "deprivation helmet"
	desc = "Completely cuts off the wearer from the outside world."
	icon_state = "dephelmet_pink"
	base_icon_state = "dephelmet"
	inhand_icon_state = "dephelmet_pinkn"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_hats.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_hats.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	body_parts_covered = HEAD
	clothing_flags = SNUG_FIT
	var/color_changed = FALSE
	//these three vars needed to turn deprivation stuff on or off
	var/muzzle = FALSE
	var/earmuffs = FALSE
	var/prevent_vision = FALSE
	/// The current color of the helmet.
	var/current_helmet_color = "pink"
	var/static/list/helmet_designs
	actions_types = list(
		/datum/action/item_action/toggle_vision,
		/datum/action/item_action/toggle_hearing,
		/datum/action/item_action/toggle_speech,
	)

//Declare action types
/datum/action/item_action/toggle_vision
	name = "Vision switch"
	desc = "Makes it impossible to see anything"

/datum/action/item_action/toggle_hearing
	name = "Hearing switch"
	desc = "Makes it impossible to hear anything"

/datum/action/item_action/toggle_speech
	name = "Speech switch"
	desc = "Makes it impossible to say anything"

//Vision switcher
/datum/action/item_action/toggle_vision/Trigger(trigger_flags)
	var/obj/item/clothing/head/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("vision")

//Hearing switcher
/datum/action/item_action/toggle_hearing/Trigger(trigger_flags)
	var/obj/item/clothing/head/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("hearing")

//Speech switcher
/datum/action/item_action/toggle_speech/Trigger(trigger_flags)
	var/obj/item/clothing/head/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("speech")

//Helmet switcher
/obj/item/clothing/head/deprivation_helmet/proc/SwitchHelmet(button)
	var/user_client = button
	if(user_client == "speech")
		if(muzzle == TRUE)
			muzzle = FALSE
			conditional_pref_sound(usr, 'sound/weapons/magout.ogg', 40, TRUE)
			to_chat(usr, span_notice("Speech switch off"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				REMOVE_TRAIT(usr, TRAIT_MUTE, CLOTHING_TRAIT)
				//to_chat(U, span_purple("Your mouth is free. you breathe out with relief."))
		else
			muzzle = TRUE
			conditional_pref_sound(usr, 'sound/weapons/magin.ogg', 40, TRUE)
			to_chat(usr, span_notice("Speech switch on"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				ADD_TRAIT(usr, TRAIT_MUTE, CLOTHING_TRAIT)
				to_chat(usr, span_purple("Something is gagging your mouth! You can barely make a sound..."))
	if(user_client == "hearing")
		if(earmuffs == TRUE)
			earmuffs = FALSE
			conditional_pref_sound(usr, 'sound/weapons/magout.ogg', 40, TRUE)
			to_chat(usr, span_notice("Hearing switch off"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				REMOVE_TRAIT(usr, TRAIT_DEAF, CLOTHING_TRAIT)
				//to_chat(U, span_purple("Finally you can hear the world around again."))
		else
			earmuffs = TRUE
			conditional_pref_sound(usr, 'sound/weapons/magin.ogg', 40, TRUE)
			to_chat(usr, span_notice("Hearing switch on"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				ADD_TRAIT(usr, TRAIT_DEAF, CLOTHING_TRAIT)
				to_chat(usr, span_purple("You can barely hear anything! Your other senses have become more apparent..."))
	if(user_client == "vision")
		var/mob/living/carbon/human/user = usr
		if(prevent_vision == TRUE)
			prevent_vision = FALSE
			conditional_pref_sound(usr, 'sound/weapons/magout.ogg', 40, TRUE)
			to_chat(usr, span_notice("Vision switch off"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				user.cure_blind("deprivation_helmet_[REF(src)]")
				//to_chat(U, span_purple("Helmet no longer restricts your vision."))
		else
			prevent_vision = TRUE
			conditional_pref_sound(usr, 'sound/weapons/magin.ogg', 40, TRUE)
			to_chat(usr, span_notice("Vision switch on"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				user.become_blind("deprivation_helmet_[REF(src)]")
				to_chat(usr, span_purple("The helmet is blocking your vision! You can't make out anything on the other side..."))

// Create radial menu
/obj/item/clothing/head/deprivation_helmet/proc/populate_helmet_designs()
	helmet_designs = list(
		"pink" = image(icon = src.icon, icon_state = "dephelmet_pink"),
		"teal" = image(icon = src.icon, icon_state = "dephelmet_teal"),
		"pinkn" = image(icon = src.icon, icon_state = "dephelmet_pinkn"),
		"tealn" = image(icon = src.icon, icon_state = "dephelmet_tealn"))

// To change model
/obj/item/clothing/head/deprivation_helmet/click_alt(mob/user)
	if(color_changed == FALSE)
		var/choice = show_radial_menu(user, src, helmet_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_helmet_color = choice
		update_icon()
		update_mob_action_buttonss()
		color_changed = TRUE
		return CLICK_ACTION_SUCCESS
	else
		return CLICK_ACTION_BLOCKING

/obj/item/clothing/head/deprivation_helmet/proc/update_mob_action_buttonss()
	var/datum/action/item_action/action_button

	for(action_button in src.actions)
		if(istype(action_button, /datum/action/item_action/toggle_vision))
			action_button.button_icon_state = "[current_helmet_color]_blind"
			action_button.button_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
		if(istype(action_button, /datum/action/item_action/toggle_hearing))
			action_button.button_icon_state = "[current_helmet_color]_deaf"
			action_button.button_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
		if(istype(action_button, /datum/action/item_action/toggle_speech))
			action_button.button_icon_state = "[current_helmet_color]_mute"
			action_button.button_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	update_icon()

// To check if we can change helmet's model
/obj/item/clothing/head/deprivation_helmet/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/head/deprivation_helmet/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	update_mob_action_buttonss()
	if(!length(helmet_designs))
		populate_helmet_designs()

// Updating both and icon in hands and icon worn
/obj/item/clothing/head/deprivation_helmet/update_icon_state()
	.=..()
	icon_state = "[base_icon_state]_[current_helmet_color]"
	inhand_icon_state = "[base_icon_state]_[current_helmet_color]"

// Here goes code that applies stuff on the wearer
/obj/item/clothing/head/deprivation_helmet/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_HEAD))
		return
	if(muzzle == TRUE)
		ADD_TRAIT(user, TRAIT_MUTE, CLOTHING_TRAIT)
		to_chat(usr, span_purple("Something is gagging your mouth! You can barely make a sound..."))
	if(earmuffs == TRUE)
		ADD_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
		to_chat(usr, span_purple("You can barely hear anything! Your other senses have become more apparent..."))
	if(prevent_vision == TRUE)
		user.become_blind("deprivation_helmet_[REF(src)]")
		to_chat(usr, span_purple("The helmet is blocking your vision! You can't make out anything on the other side..."))


// Here goes code that heals the wearer after unequipping helmet
/obj/item/clothing/head/deprivation_helmet/dropped(mob/living/carbon/human/user)
	. = ..()
	if(muzzle == TRUE)
		REMOVE_TRAIT(user, TRAIT_MUTE, CLOTHING_TRAIT)
	if(earmuffs == TRUE)
		earmuffs = FALSE
		REMOVE_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
		earmuffs = TRUE
	if(prevent_vision == TRUE)
		user.cure_blind("deprivation_helmet_[REF(src)]")

	// Some stuff for unequip messages
	if(src == user.head)
		if(muzzle == TRUE)
			to_chat(user, span_purple("Your mouth is free. You breathe out with relief."))
		if(earmuffs == TRUE)
			to_chat(user, span_purple("Finally you can hear the world around you once more."))
		if(prevent_vision == TRUE)
			to_chat(user, span_purple("The helmet no longer restricts your vision."))
