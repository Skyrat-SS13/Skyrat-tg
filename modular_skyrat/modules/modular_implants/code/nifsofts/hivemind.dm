///A list containing users of the Hivemind NIFSoft
GLOBAL_LIST_EMPTY(hivemind_users)

/obj/item/disk/nifsoft_uploader/hivemind
	loaded_nifsoft = /datum/nifsoft/hivemind

/datum/nifsoft/hivemind
	name = "Hivemind Chat"
	program_desc = "Hivemind is a program developed as a more reliable simulacrum of the mysterious means of communication that some varieties of slime share. It's built on a specific configuration of the NIF capable of generating a localized subspace network; the content the user's very thoughts, serving as a high-tech means of telepathic communication between NIF users."
	activation_cost = 10
	active_mode = TRUE
	active_cost = 1
	///The network that the user is currently hosting
	var/datum/component/mind_linker/nif/user_network
	///What networks are the user connected to?
	var/list/datum/component/mind_linker/nif/network_list
	///What network is the user sending messages to? This is saved from the keyboard so the user doesn't have to change the channel every time.
	var/datum/component/mind_linker/nif/sending_network
	///The physical keyboard item being used to send messages
	var/obj/item/hivemind_keyboard/linked_keyboard

/datum/nifsoft/hivemind/New()
	. = ..()

	user_network = linked_mob.AddComponent(/datum/component/mind_linker/nif, \
		network_name = "Hivemind Link", \
		linker_action_path = /datum/action/innate/hivemind_config, \
	)

	sending_network = user_network
	GLOB.hivemind_users += linked_mob

/datum/nifsoft/hivemind/Destroy()
	if(linked_mob in GLOB.hivemind_users)
		GLOB.hivemind_users -= linked_mob

	qdel(user_network)

	//add in a function that scans the mind_links in the network list and remove the user from each one of them.
	. = ..()

/datum/nifsoft/hivemind/activate()
	. = ..()
	if(active)
		linked_keyboard = new
		linked_keyboard.connected_network = sending_network
		linked_mob.put_in_hands(linked_keyboard)

		return

	qdel(linked_keyboard)
	linked_keyboard = null

/datum/action/innate/hivemind_config
	name = "Hivemind Configuration Settings"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'

/datum/action/innate/hivemind_config/Activate()
	. = ..()
	var/datum/component/mind_linker/nif/link = target

	var/choice = tgui_input_list(owner, "Chose your option", "Hivemind Configuration Menu", list("Link a user", "Remove a user", "Leave a Hivemind"))
	if(!choice)
		return

	switch(choice)
		if("Link a user")
			link.invite_user()

		if("Remove a user")
			link.remove_user()

		if("Leave a Hivemind")
			return

/datum/component/mind_linker
	///Is does the component give an action to speak? By default, yes
	var/speech_action = TRUE

/datum/component/mind_linker/nif
	speech_action = FALSE

///Lets the user add someone to their Hivemind through a choice menu that shows everyone that has the Hivemind NIFSoft.
/datum/component/mind_linker/nif/proc/invite_user()
	var/list/hivemind_users = GLOB.hivemind_users
	var/mob/living/carbon/human/owner = parent

	//This way people already linked don't show up in the selection menu
	for(var/mob/living/user as anything in linked_mobs)
		if(user in hivemind_users)
			hivemind_users -= user

	hivemind_users -= owner

	var/mob/living/carbon/human/person_to_add = tgui_input_list(owner, "Chose a person to invite to your Hivemind", "Invite User", hivemind_users)
	if(!person_to_add)
		return

/*
	if(tgui_alert(person_to_add, "[owner] wishes to add you to their Hivemind, do you accept", "Incomming Hivemind Invite", list("Accept", "Reject")) != "Accept")
		to_chat(owner, span_warning("[person_to_add] denied the request to join your Hivemind"))
		return
*/

	linked_mobs += person_to_add

	var/datum/nifsoft/hivemind/target_hivemind
	var/list/nifsoft_list = person_to_add?.installed_nif?.loaded_nifsofts
	var/nifsoft_to_find = /datum/nifsoft/hivemind

	for(var/datum/nifsoft/nifsoft as anything in nifsoft_list)
		if(nifsoft.type == nifsoft_to_find)
			target_hivemind = nifsoft

	if(!target_hivemind)
		return

	target_hivemind.network_list += src
	to_chat(person_to_add, span_abductor("You have now been added to [owner]'s Hivemind"))
	to_chat(owner, span_abductor("[person_to_add] has now been added to your Hivemind"))

///Removes a user from the list of connected people within a hivemind
/datum/component/mind_linker/nif/proc/remove_user()
	var/mob/living/carbon/human/owner = parent
	var/mob/living/carbon/human/person_to_remove = tgui_input_list(owner, "Chose a person to remove from your Hivemind", "Remove User", linked_mobs)

	if(!person_to_remove)
		return

	var/datum/nifsoft/hivemind/target_hivemind
	var/list/nifsoft_list = person_to_remove?.installed_nif?.loaded_nifsofts
	var/nifsoft_to_find = /datum/nifsoft/hivemind

	for(var/datum/nifsoft/nifsoft as anything in nifsoft_list)
		if(nifsoft.type == nifsoft_to_find)
			target_hivemind = nifsoft

	target_hivemind.network_list -= src
	to_chat(person_to_remove, span_abductor("You have now been removed from [owner]'s Hivemind"))
	to_chat(owner, span_abductor("[person_to_remove] has now been removed from your Hivemind"))

/obj/item/hivemind_keyboard
	name = "Hivemind Controller"
	desc = "A holographic gesture controller, hooked to hand and finger signals of the user's own choice. This is paired with the Hivemind program itself, used as a means of filtering out unwanted thoughts from being added to the network, ensuring that only intentional thoughts of communication can go through."
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-purple"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	///What Hivemind are messages being sent to?
	var/datum/component/mind_linker/nif/connected_network

/obj/item/hivemind_keyboard/attack_self(mob/user, modifiers)
	. = ..()
	send_message(user)

/obj/item/hivemind_keyboard/proc/send_message(mob/living/carbon/human/user)

	var/mob/living/carbon/human/network_owner = connected_network.parent
	var/message = sanitize(tgui_input_text(user, "Enter a message to transmit.", "[connected_network.network_name] Telepathy"))
	if(!message || QDELETED(src) || QDELETED(user) || user.stat == DEAD)
		return

	if(QDELETED(connected_network))
		to_chat(user, span_warning("The link seems to have been severed."))
		return

	var/formatted_message = "<i><font color=[connected_network.chat_color]>\[[user.real_name]'s [connected_network.network_name]\] <b>[user]:</b> [message]</font></i>"
	log_directed_talk(user, network_owner, message, LOG_SAY, "mind link ([connected_network.network_name])")

	var/list/all_who_can_hear = assoc_to_keys(connected_network.linked_mobs) +	network_owner

	for(var/mob/living/recipient as anything in all_who_can_hear)
		to_chat(recipient, formatted_message)

	for(var/mob/recipient as anything in GLOB.dead_mob_list)
		to_chat(recipient, "[FOLLOW_LINK(recipient, user)] [formatted_message]")

