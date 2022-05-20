/*
//seems like it kinda SPACE helmet. So probably abusable, but not really.
//If you want to make it less abusable and remove from helmet/space to just /helmet/ - please, add code that removes hair on use. Because we weren't able to do that.

/obj/item/clothing/head/helmet/space/deprivation_helmet
	name = "deprivation helmet"
	desc = "Сompletely cuts off the wearer from the outside world."
	icon_state = "dephelmet"
	inhand_icon_state = "dephelmet"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_hats.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_hats.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 25, FIRE = 20, ACID = 15)
	clothing_flags = SNUG_FIT
	var/color_changed = FALSE
	//these three vars needed to turn deprivation stuff on or off
	var/muzzle = FALSE
	var/earmuffs = FALSE
	var/prevent_vision = FALSE
	//
	var/current_helmet_color = "pink"
	var/static/list/helmet_designs
	actions_types = list(/datum/action/item_action/toggle_vision,
						 /datum/action/item_action/toggle_hearing,
						 /datum/action/item_action/toggle_speech)
	//Var for save sounds status when Helmet is equipped
	var/ambience_sound_state = null
	var/instruments_sound_state = null
	var/combatmode_sound_state = null
	var/midis_sound_state = null
	var/announcement_sound_state = null
	var/ship_ambience_sound_state = null

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
	var/obj/item/clothing/head/helmet/space/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("vision")

//Hearing switcher
/datum/action/item_action/toggle_hearing/Trigger(trigger_flags)
	var/obj/item/clothing/head/helmet/space/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("hearing")

//Speech switcher
/datum/action/item_action/toggle_speech/Trigger(trigger_flags)
	var/obj/item/clothing/head/helmet/space/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("speech")

//Helmet switcher
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/SwitchHelmet(button)
	var/user_client = button
	if(user_client == "speech")
		if(muzzle == TRUE)
			muzzle = FALSE
			playsound(usr, 'sound/weapons/magout.ogg', 40, TRUE, ignore_walls = FALSE)
			to_chat(usr, span_notice("Speech switch off"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				REMOVE_TRAIT(usr, TRAIT_MUTE, CLOTHING_TRAIT)
				//to_chat(U, span_purple("Your mouth is free. you breathe out with relief."))
		else
			muzzle = TRUE
			playsound(usr, 'sound/weapons/magin.ogg', 40, TRUE, ignore_walls = FALSE)
			to_chat(usr, span_notice("Speech switch on"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				ADD_TRAIT(usr, TRAIT_MUTE, CLOTHING_TRAIT)
				to_chat(usr, span_purple("Something is gagging your mouth! You can barely make a sound..."))
	if(user_client == "hearing")
		if(earmuffs == TRUE)
			earmuffs = FALSE
			playsound(usr, 'sound/weapons/magout.ogg', 40, TRUE, ignore_walls = FALSE)
			to_chat(usr, span_notice("Hearing switch off"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				REMOVE_TRAIT(usr, TRAIT_DEAF, CLOTHING_TRAIT)
				Toggle_Sounds()
				//to_chat(U, span_purple("Finally you can hear the world around again."))
		else
			earmuffs = TRUE
			playsound(usr, 'sound/weapons/magin.ogg', 40, TRUE, ignore_walls = FALSE)
			to_chat(usr, span_notice("Hearing switch on"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				ADD_TRAIT(usr, TRAIT_DEAF, CLOTHING_TRAIT)
				Toggle_Sounds()
				stop_client_sounds()
				to_chat(usr, span_purple("You can barely hear anything! Your other senses have become more apparent..."))
	if(user_client == "vision")
		var/mob/living/carbon/human/user = usr
		if(prevent_vision == TRUE)
			prevent_vision = FALSE
			playsound(usr, 'sound/weapons/magout.ogg', 40, TRUE, ignore_walls = FALSE)
			to_chat(usr, span_notice("Vision switch off"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				user.cure_blind("deprivation_helmet_[REF(src)]")
				//to_chat(U, span_purple("Helmet no longer restricts your vision."))
		else
			prevent_vision = TRUE
			playsound(usr, 'sound/weapons/magin.ogg', 40, TRUE, ignore_walls = FALSE)
			to_chat(usr, span_notice("Vision switch on"))
			if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
				user.become_blind("deprivation_helmet_[REF(src)]")
				to_chat(usr, span_purple("The helmet is blocking your vision! You can't make out anything on the other side..."))

// Client sound switchers for more silense! And check current state of parameters
// Switcher agregator function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Sounds()
	var/user_client = usr.client
	if(earmuffs == FALSE)
		if(ambience_sound_state	!= 0)
			var/soundscape_check = Toggle_Soundscape_Get_checked(user_client)
			if(soundscape_check == 0)
				Toggle_Soundscape()
		if(instruments_sound_state != 0)
			var/instruments_check = Toggle_Instruments_Get_checked(user_client)
			if(instruments_check == 0)
				Toggle_Instruments()
		if(combatmode_sound_state != 0)
			var/combat_mode_sound_check = Toggle_Combatmode_Sound_Get_checked(user_client)
			if(combat_mode_sound_check == 0)
				Toggle_Combatmode_Sound()
		if(midis_sound_state != 0)
			var/midis_check = Toggle_Midis_Get_checked(user_client)
			if(midis_check == 0)
				Toggle_Midis()
		if(announcement_sound_state	!= 0)
			var/announcement_sound_check = Toggle_Announcement_Sound_Get_checked(user_client)
			if(announcement_sound_check == 0)
				Toggle_Announcement_Sound()
		if(ship_ambience_sound_state != 0)
			var/ambience_check = Toggle_Ship_Ambience_Get_Checked(user_client)
			if(ambience_check == 0)
				Toggle_Ship_Ambience()
	else
		var/soundscape_check = Toggle_Soundscape_Get_checked(user_client)
		if(soundscape_check != 0)
			Toggle_Soundscape()
		var/instruments_check = Toggle_Instruments_Get_checked(user_client)
		if(instruments_check != 0)
			Toggle_Instruments()
		var/combat_mode_sound_check = Toggle_Combatmode_Sound_Get_checked(user_client)
		if(combat_mode_sound_check != 0)
			Toggle_Combatmode_Sound()
		var/midis_check = Toggle_Midis_Get_checked(user_client)
		if(midis_check != 0)
			Toggle_Midis()
		var/announcement_sound_check = Toggle_Announcement_Sound_Get_checked(user_client)
		if(announcement_sound_check != 0)
			Toggle_Announcement_Sound()
		var/ambience_check = Toggle_Ship_Ambience_Get_Checked(user_client)
		if(ambience_check != 0)
			Toggle_Ship_Ambience()

//Ambience sound switch function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Soundscape()
	usr.client.prefs.toggles ^= SOUND_AMBIENCE
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_AMBIENCE)
		//to_chat(usr, "You will now hear ambient sounds.")
	else
		//to_chat(usr, "You will no longer hear ambient sounds.")
		usr.stop_sound_channel(CHANNEL_AMBIENCE)
		usr.stop_sound_channel(CHANNEL_BUZZ)
	usr.client.update_ambience_pref()

//Ambience sound check status function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Soundscape_Get_checked(client/user_client)
	return user_client.prefs.toggles & SOUND_AMBIENCE

//Instuments sound switch function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Instruments()
	usr.client.prefs.toggles ^= SOUND_INSTRUMENTS
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_INSTRUMENTS)
		//to_chat(usr, "You will now hear people playing musical instruments.")
	else
		//to_chat(usr, "You will no longer hear musical instruments.")

//Instruments sound check status
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Instruments_Get_checked(client/user_client)
	return user_client.prefs.toggles & SOUND_INSTRUMENTS

//Combat sound switch function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Combatmode_Sound()
	usr.client.prefs.toggles ^= SOUND_COMBATMODE
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_COMBATMODE)
		//to_chat(usr, "You will now hear a sound when combat mode is turned on.")
	else
		//to_chat(usr, "You will no longer hear a sound when combat mode is turned on.")

//Combat sound check status function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Combatmode_Sound_Get_checked(client/user_client)
	return user_client.prefs.toggles & SOUND_COMBATMODE

//Midis sound switch function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Midis()
	usr.client.prefs.toggles ^= SOUND_MIDI
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.toggles & SOUND_MIDI)
		//to_chat(usr, "You will now hear any sounds uploaded by admins.")
	else
		//to_chat(usr, "You will no longer hear sounds uploaded by admins")
		usr.stop_sound_channel(CHANNEL_ADMIN)
		var/client/user_client = usr.client
		user_client?.tgui_panel?.stop_music()

//Midis sound check status function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Midis_Get_checked(client/user_client)
	return user_client.prefs.toggles & SOUND_MIDI
//Anounce sound switch function

/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Announcement_Sound()
	set name = "Hear/Silence Announcements"
	set category = "Preferences"
	set desc = "Hear Announcement Sound"
	usr.client.prefs.toggles ^= SOUND_ANNOUNCEMENTS
	//to_chat(usr, "You will now [(usr.client.prefs.toggles & SOUND_ANNOUNCEMENTS) ? "hear announcement sounds" : "no longer hear announcements"].")
	usr.client.prefs.save_preferences()

//Anounce sound check status function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Announcement_Sound_Get_checked(client/user_client)
	return user_client.prefs.toggles & SOUND_ANNOUNCEMENTS

//Stop sound function for immediatlely silence
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/stop_client_sounds()
	SEND_SOUND(usr, sound(null))
	var/client/user_client = usr.client
	user_client?.tgui_panel?.stop_music()
//Ship ambience switch function

/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Ship_Ambience()
	set name = "Hear/Silence Ship Ambience"
	set category = "Preferences"
	set desc = "Hear Ship Ambience Roar"
	usr.client.prefs.toggles ^= SOUND_SHIP_AMBIENCE
	usr.client.prefs.save_preferences()

	// STUFF THAT IS "//" NOT REALLY USEFUL
	if(usr.client.prefs.toggles & SOUND_SHIP_AMBIENCE)
		//to_chat(usr, "You will now hear ship ambience.")
	else
		//to_chat(usr, "You will no longer hear ship ambience.")
		usr.stop_sound_channel(CHANNEL_BUZZ)

// Ship ambience check status function
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/Toggle_Ship_Ambience_Get_Checked(client/user_client)
	return user_client.prefs.toggles & SOUND_SHIP_AMBIENCE

// Create radial menu
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/populate_helmet_designs()
	helmet_designs = list(
		"pink" = image(icon = src.icon, icon_state = "dephelmet_pink"),
		"teal" = image(icon = src.icon, icon_state = "dephelmet_teal"),
		"pinkn" = image(icon = src.icon, icon_state = "dephelmet_pinkn"),
		"tealn" = image(icon = src.icon, icon_state = "dephelmet_tealn"))

// To change model
/obj/item/clothing/head/helmet/space/deprivation_helmet/AltClick(mob/user)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user, src, helmet_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_helmet_color = choice
		update_icon()
		update_action_buttons_icons()
		color_changed = TRUE
	else
		return

/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/update_action_buttons_icons()
	var/datum/action/item_action/action_button

	for(action_button in src.actions)
		if(istype(action_button, /datum/action/item_action/toggle_vision))
			action_button.button_icon_state = "[current_helmet_color]_blind"
			action_button.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
		if(istype(action_button, /datum/action/item_action/toggle_hearing))
			action_button.button_icon_state = "[current_helmet_color]_deaf"
			action_button.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
		if(istype(action_button, /datum/action/item_action/toggle_speech))
			action_button.button_icon_state = "[current_helmet_color]_mute"
			action_button.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	update_icon()

// To check if we can change helmet's model
/obj/item/clothing/head/helmet/space/deprivation_helmet/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/head/helmet/space/deprivation_helmet/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	update_action_buttons_icons()
	if(!length(helmet_designs))
		populate_helmet_designs()

// Updating both and icon in hands and icon worn
/obj/item/clothing/head/helmet/space/deprivation_helmet/update_icon_state()
	.=..()
	icon_state = "[initial(icon_state)]_[current_helmet_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_helmet_color]"

// Here goes code that applies stuff on the wearer
/obj/item/clothing/head/helmet/space/deprivation_helmet/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_HEAD)
		return
	//Save current sound states
	var/mob_client = usr.client
	ambience_sound_state = Toggle_Soundscape_Get_checked(mob_client)
	instruments_sound_state = Toggle_Instruments_Get_checked(mob_client)
	combatmode_sound_state = Toggle_Combatmode_Sound_Get_checked(mob_client)
	midis_sound_state = Toggle_Midis_Get_checked(mob_client)
	announcement_sound_state = Toggle_Announcement_Sound_Get_checked(mob_client)
	ship_ambience_sound_state = Toggle_Ship_Ambience_Get_Checked(mob_client)
	if(muzzle == TRUE)
		ADD_TRAIT(user, TRAIT_MUTE, CLOTHING_TRAIT)
		to_chat(usr, span_purple("Something is gagging your mouth! You can barely make a sound..."))
	if(earmuffs == TRUE)
		ADD_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
		Toggle_Sounds()
		stop_client_sounds()
		to_chat(usr, span_purple("You can barely hear anything! Your other senses have become more apparent..."))
	if(prevent_vision == TRUE)
		user.become_blind("deprivation_helmet_[REF(src)]")
		to_chat(usr, span_purple("The helmet is blocking your vision! You can't make out anything on the other side..."))


// Here goes code that heals the wearer after unequipping helmet
/obj/item/clothing/head/helmet/space/deprivation_helmet/dropped(mob/living/carbon/human/user)
	. = ..()
	if(muzzle == TRUE)
		REMOVE_TRAIT(user, TRAIT_MUTE, CLOTHING_TRAIT)
	if(earmuffs == TRUE)
		earmuffs = FALSE
		REMOVE_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
		Toggle_Sounds()
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

	// Let's drop sound states
	ambience_sound_state = null
	instruments_sound_state = null
	combatmode_sound_state = null
	midis_sound_state = null
	announcement_sound_state = null
	ship_ambience_sound_state = null
*/
