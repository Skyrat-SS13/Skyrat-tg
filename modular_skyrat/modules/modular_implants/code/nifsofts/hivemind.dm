///A list containing users of the Hivemind NIFSoft
GLOBAL_LIST_EMPTY(hivemind_users)

/obj/item/disk/nifsoft_uploader/hivemind
	name = "Hivemind"
	loaded_nifsoft = /datum/nifsoft/hivemind

/datum/nifsoft/hivemind
	name = "Hivemind"
	program_desc = "Hivemind is a program developed as a more reliable simulacrum of the mysterious means of communication that some varieties of slime share. It's built on a specific configuration of the NIF capable of generating a localized subspace network; the content the user's very thoughts, serving as a high-tech means of telepathic communication between NIF users."
	activation_cost = 10
	active_mode = TRUE
	active_cost = 0.2
	purchase_price = 350
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = "users"

	///The network that the user is currently hosting
	var/datum/component/mind_linker/active_linking/nif/user_network
	///What networks are the user connected to?
	var/list/network_list = list()
	///What network is the user sending messages to? This is saved from the keyboard so the user doesn't have to change the channel every time.
	var/datum/component/mind_linker/active_linking/nif/active_network
	///The physical keyboard item being used to send messages
	var/obj/item/hivemind_keyboard/linked_keyboard
	///What action is being used to summon the Keyboard?
	var/datum/action/innate/hivemind_keyboard/keyboard_action

/datum/nifsoft/hivemind/New()
	. = ..()

	user_network = linked_mob.AddComponent(/datum/component/mind_linker/active_linking/nif, \
		network_name = "Hivemind Link", \
		linker_action_path = /datum/action/innate/hivemind_config, \
	)

	keyboard_action = new(linked_mob)
	keyboard_action.Grant(linked_mob)

	active_network = user_network
	network_list += user_network
	GLOB.hivemind_users += linked_mob

/datum/nifsoft/hivemind/Destroy()
	if(linked_mob in GLOB.hivemind_users)
		GLOB.hivemind_users -= linked_mob

	if(keyboard_action)
		keyboard_action.Remove()
		QDEL_NULL(keyboard_action)

	if(linked_keyboard)
		qdel(linked_keyboard)

	linked_keyboard = null

	for(var/datum/component/mind_linker/active_linking/nif/hivemind as anything in network_list)
		hivemind.linked_mobs -= linked_mob
		var/mob/living/hivemind_owner = hivemind.parent

		to_chat(hivemind_owner, span_abductor("[linked_mob] has left your Hivemind."))
		to_chat(linked_mob, span_abductor("You have left [hivemind_owner]'s Hivemind."))

	qdel(user_network)
	return ..()

/datum/nifsoft/hivemind/activate()
	. = ..()
	if(!active)
		if(linked_keyboard)
			qdel(linked_keyboard)
			linked_keyboard = null

		return TRUE

	linked_keyboard = new
	linked_keyboard.connected_network = active_network
	linked_mob.put_in_hands(linked_keyboard)
	linked_keyboard.source_user = linked_mob

	linked_mob.visible_message(span_notice("The [linked_keyboard] materializes in [linked_mob]'s hands."), span_notice("The [linked_keyboard] appears in your hands."))
	return TRUE

/datum/action/innate/hivemind_config
	name = "Hivemind Configuration Settings"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "phone_settings"

/datum/action/innate/hivemind_config/Activate()
	. = ..()
	var/datum/component/mind_linker/active_linking/nif/link = target

	var/choice = tgui_input_list(owner, "Chose your option", "Hivemind Configuration Menu", list("Link a user","Remove a user","Change Hivemind color","Change active Hivemind","Leave a Hivemind", "Toggle invites"))
	if(!choice)
		return

	switch(choice)
		if("Link a user")
			link.invite_user()

		if("Remove a user")
			link.remove_user()

		if("Leave a Hivemind")
			leave_hivemind()

		if("Change active Hivemind")
			change_hivemind()

		if("Change Hivemind color")
			link.change_chat_color()

		if("Toggle invites")
			toggle_invites()

/datum/action/innate/hivemind_config/proc/change_hivemind()
	var/mob/living/carbon/human/user = owner
	var/datum/nifsoft/hivemind/hivemind = user.find_nifsoft(/datum/nifsoft/hivemind)

	var/datum/component/mind_linker/active_linking/nif/new_active_hivemind = tgui_input_list(user, "Choose a Hivemind to set as active.", "Switch Hivemind", hivemind.network_list)
	if(!new_active_hivemind)
		return FALSE

	hivemind.active_network = new_active_hivemind
	to_chat(user, span_abductor("You are now sending messages to [new_active_hivemind.name]."))

	if(hivemind.active)
		hivemind.activate()
		hivemind.activate()

/datum/action/innate/hivemind_config/proc/leave_hivemind()
	var/mob/living/carbon/human/user = owner
	var/datum/nifsoft/hivemind/hivemind = user.find_nifsoft(/datum/nifsoft/hivemind)

	var/list/network_list = hivemind.network_list
	network_list -= hivemind.user_network

	var/datum/component/mind_linker/active_linking/nif/hivemind_to_leave = tgui_input_list(user, "Choose a Hivemind to disconnect from.", "Remove Hivemind", network_list)
	if(!hivemind_to_leave)
		return FALSE

	to_chat(hivemind_to_leave.parent, span_abductor("[user] has been removed from your Hivemind."))
	to_chat(user, span_abductor("You have left [hivemind_to_leave.parent]'s Hivemind."))

	hivemind.network_list -= hivemind_to_leave
	hivemind_to_leave.linked_mobs -= user


/datum/action/innate/hivemind_config/proc/toggle_invites()
	var/mob/living/carbon/human/user = owner
	if(user in GLOB.hivemind_users)
		GLOB.hivemind_users -= user
		to_chat(user, span_abductor("You are now unable to receive invites."))
		return

	GLOB.hivemind_users += user
	to_chat(user, span_abductor("You are now able to receive invites."))

/datum/action/innate/hivemind_keyboard
	name = "Hivemind Keyboard"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "phone"

/datum/action/innate/hivemind_keyboard/Activate()
	. = ..()
	var/mob/living/carbon/human/user = owner
	var/datum/nifsoft/hivemind/hivemind_nifsoft = user.find_nifsoft(/datum/nifsoft/hivemind)

	if(!hivemind_nifsoft)
		return FALSE

	hivemind_nifsoft.activate()

/datum/component/mind_linker
	///Is does the component give an action to speak? By default, yes
	var/speech_action = TRUE
	///Does the component check to see if the person being linked has a mindshield or anti-magic?
	var/linking_protection = TRUE

/datum/component/mind_linker/active_linking/nif
	speech_action = FALSE
	linking_protection = FALSE

	///What is the name of the hivemind? This is mostly here for the TGUI selection menus.
	var/name = ""

/datum/component/mind_linker/active_linking/nif/New()
	. = ..()

	var/mob/living/owner = parent
	name = owner.name + "'s " + network_name

///Lets the user add someone to their Hivemind through a choice menu that shows everyone that has the Hivemind NIFSoft.
/datum/component/mind_linker/active_linking/nif/proc/invite_user()
	var/list/hivemind_users = GLOB.hivemind_users.Copy()
	var/mob/living/carbon/human/owner = parent

	//This way people already linked don't show up in the selection menu
	for(var/mob/living/user as anything in linked_mobs)
		if(user in hivemind_users)
			hivemind_users -= user

	hivemind_users -= owner

	var/mob/living/carbon/human/person_to_add = tgui_input_list(owner, "Choose a person to invite to your Hivemind.", "Invite User", hivemind_users)
	if(!person_to_add)
		return

	if(tgui_alert(person_to_add, "[owner] wishes to add you to their Hivemind, do you accept?", "Incoming Hivemind Invite", list("Accept", "Reject")) != "Accept")
		to_chat(owner, span_warning("[person_to_add] denied the request to join your Hivemind."))
		return

	linked_mobs += person_to_add

	var/datum/nifsoft/hivemind/target_hivemind = person_to_add.find_nifsoft(/datum/nifsoft/hivemind)

	if(!target_hivemind)
		return FALSE

	target_hivemind.network_list += src
	to_chat(person_to_add, span_abductor("You have now been added to [owner]'s Hivemind"))
	to_chat(owner, span_abductor("[person_to_add] has now been added to your Hivemind"))

///Removes a user from the list of connected people within a hivemind
/datum/component/mind_linker/active_linking/nif/proc/remove_user()
	var/mob/living/carbon/human/owner = parent
	var/mob/living/carbon/human/person_to_remove = tgui_input_list(owner, "Choose a person to remove from your Hivemind.", "Remove User", linked_mobs)

	if(!person_to_remove)
		return

	var/datum/nifsoft/hivemind/target_hivemind
	target_hivemind = person_to_remove.find_nifsoft(/datum/nifsoft/hivemind)

	if(!target_hivemind)
		return FALSE

	linked_mobs -= person_to_remove
	target_hivemind.network_list -= src
	to_chat(person_to_remove, span_abductor("You have now been removed from [owner]'s Hivemind."))
	to_chat(owner, span_abductor("[person_to_remove] has now been removed from your Hivemind."))

/datum/component/mind_linker/active_linking/nif/proc/change_chat_color()
	var/mob/living/carbon/human/owner = parent
	var/new_chat_color = input(owner, "", "Choose Color", COLOR_ASSEMBLY_GREEN) as color

	if(!new_chat_color)
		return FALSE

	chat_color = new_chat_color

/obj/item/hivemind_keyboard
	name = "Hivemind Interface Device"
	desc = "A holographic gesture controller, hooked to hand and finger signals of the user's own choice. This is paired with the Hivemind program itself, used as a means of filtering out unwanted thoughts from being added to the network, ensuring that only intentional thoughts of communication can go through."
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-purple"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	///What Hivemind are messages being sent to?
	var/datum/component/mind_linker/active_linking/nif/connected_network
	//Who owns the controller?
	var/datum/weakref/source_user

/obj/item/hivemind_keyboard/Destroy(force)
	. = ..()
	connected_network = null

/obj/item/hivemind_keyboard/attack_self(mob/user, modifiers)
	. = ..()
	send_message(user)

/obj/item/hivemind_keyboard/proc/send_message(mob/living/carbon/human/user)
	var/mob/living/carbon/human/kebyoard_owner = source_user
	var/mob/living/carbon/human/network_owner = connected_network.parent
	var/message = tgui_input_text(user, "Enter a message to transmit.", "[connected_network.network_name] Telepathy")
	if(!message || QDELETED(src) || QDELETED(user) || user.stat == DEAD)
		return

	if(QDELETED(connected_network))
		to_chat(user, span_warning("The link seems to have been severed."))
		return

	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/chat)
	var/tag = sheet.icon_tag("nif-phone")
	var/hivemind_icon = ""

	if(tag)
		hivemind_icon = tag

	var/formatted_message = "<i><font color=[connected_network.chat_color]>\ [hivemind_icon][network_owner.real_name]'s [connected_network.network_name]\] <b>[kebyoard_owner]:</b> [message]</font></i>"
	log_directed_talk(user, network_owner, message, LOG_SAY, "mind link ([connected_network.network_name])")

	var/list/all_who_can_hear = assoc_to_keys(connected_network.linked_mobs) + network_owner

	for(var/mob/living/recipient as anything in all_who_can_hear)
		to_chat(recipient, formatted_message)

	for(var/mob/recipient as anything in GLOB.dead_mob_list)
		to_chat(recipient, "[FOLLOW_LINK(recipient, user)] [formatted_message]")

