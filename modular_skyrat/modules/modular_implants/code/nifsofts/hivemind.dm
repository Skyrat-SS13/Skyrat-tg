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

/datum/component/mind_linker
	///Is does the component give an action to speak? By default, yes
	var/speech_action = TRUE

/datum/component/mind_linker/nif
	speech_action = FALSE

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

