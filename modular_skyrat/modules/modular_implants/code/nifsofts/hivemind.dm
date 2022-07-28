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

/datum/nifsoft/hivemind/New()
	. = ..()

	user_network = linked_mob.AddComponent(/datum/component/mind_linker/nif, \
		network_name = "Hivemind Link", \
		linker_action_path = /datum/action/innate/hivemind_config, \
	)

/datum/nifsoft/hivemind/activate()
	. = ..()
	if(active)
		user_network.nifsoft_active = TRUE
		return

	user_network.nifsoft_active = FALSE

/datum/action/innate/hivemind_config
	name = "Hivemind Configuration Settings"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'

/datum/component/mind_linker
	///Is does the component give an action to speak? By default, yes
	var/speech_action = TRUE

/datum/component/mind_linker/nif
	///Is the NIFSoft active? If not, no messages are able to get through
	var/nifsoft_active = FALSE
	speech_action = FALSE

/obj/item/hivemind_keyboard
	name = "Hivemind Controller"
	desc = "A holographic gesture controller, hooked to hand and finger signals of the user's own choice. This is paired with the Hivemind program itself, used as a means of filtering out unwanted thoughts from being added to the network, ensuring that only intentional thoughts of communication can go through."
