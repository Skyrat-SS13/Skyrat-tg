/// The component given to carrier inhabitants
/datum/component/carrier_user
	/// What is the name of our mob?
	var/name
	/// What does our mob look like?
	var/desc = "It's a mob."
	/// What are the ooc notes for the mob?
	var/ooc_notes = ""

	/// What is the weakref of the carrier room are we currently in?
	var/datum/weakref/current_room

	/// Is the mob able to see things in the outside world?
	var/outside_sight = TRUE
	/// Is the mob able to hear things from the outside world?
	var/outside_hearing = TRUE
	/// Is the mob able to "see" things from inside of the carrier?
	var/internal_sight = TRUE
	/// Is the mob able to "hear" things from inside of the carrier?
	var/internal_hearing = TRUE
	/// Is the mob able to emote inside the carrier room?
	var/able_to_emote = TRUE
	/// Is the mob able to speak inside the carrier room?
	var/able_to_speak = TRUE
	/// Is the mob able to change their own name?
	var/able_to_rename = TRUE
	/// Is the mob able to speak as the object it is inside?
	var/able_to_speak_as_container = TRUE
	/// Is the mob able to emote as the object it is inside?
	var/able_to_emote_as_container = TRUE
	/// Are emote's and Say's done through the container the mob is in?
	var/communicating_externally = FALSE

	/// Is the action to control the HUD given to the mob?
	var/hud_action_given = TRUE
	/// The coresponding action used to pull up the HUD
	var/datum/action/innate/carrier_user/carrier_action
	/// Is the action to leave given to the mob?
	var/leave_action_given = TRUE
	/// The coresponding action used to leave the carrier
	var/datum/action/innate/leave_carrier/leave_action

/datum/component/carrier_user/New()
	. = ..()
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return COMPONENT_INCOMPATIBLE

	if(hud_action_given)
		carrier_action = new
		carrier_action.Grant(parent_mob)
		carrier_action.carrier_user_component = WEAKREF(src)

	if(leave_action_given)
		leave_action = new
		leave_action.Grant(parent_mob)

	if(!outside_sight)
		outside_sight = TRUE
		toggle_sense(sense_to_toggle = "outside_sight")

	if(!outside_hearing)
		outside_hearing = TRUE
		toggle_sense(sense_to_toggle = "outside_hearing")

	refresh_mob_appearance()

	return TRUE

/datum/component/carrier_user/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CARRIER_MOB_TOGGLE_SENSE, PROC_REF(toggle_sense))
	RegisterSignal(parent, COMSIG_CARRIER_MOB_RENAME, PROC_REF(change_name))
	RegisterSignal(parent, COMSIG_CARRIER_MOB_RESET_NAME, PROC_REF(reset_name))
	RegisterSignal(parent, COMSIG_CARRIER_MOB_CHANGE_ROOM, PROC_REF(set_room))
	RegisterSignal(parent, COMSIG_CARRIER_MOB_CHECK_INTERNAL_SENSES, PROC_REF(check_internal_senses))
	RegisterSignal(parent, COMSIG_CARRIER_MOB_REFRESH_APPEARANCE, PROC_REF(refresh_mob_appearance))

/// Configures the settings of the carrier user to be in accordance with the parent mob
/datum/component/carrier_user/proc/refresh_mob_appearance(datum/source)
	SIGNAL_HANDLER

	var/mob/living/parent_mob = parent
	if(!istype(parent_mob) || !istype(parent_mob.mind))
		return FALSE

	name = parent_mob.mind.name

	var/datum/preferences/preferences = parent_mob?.client?.prefs
	if(!preferences)
		return FALSE

	ooc_notes = preferences.read_preference(/datum/preference/text/ooc_notes)
	desc = preferences.read_preference(/datum/preference/text/flavor_text)

/// What do we want to do when a mob tries to say something into the carrier?
/datum/component/carrier_user/proc/say(message_to_say)
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return FALSE

	if(!can_communicate())
		to_chat(parent, span_warning("You are unable to speak!"))
		return FALSE

	if(!message_to_say)
		return FALSE

	var/datum/carrier_room/room = current_room.resolve()
	if(!room) // uhoh.
		current_room = null
		return FALSE

	room.send_message(message_to_say, name, parent_mob, FALSE)
	return TRUE

/// What do we want to do when a mob tries to do a `me` emote?
/datum/component/carrier_user/proc/me_verb(message_to_say)
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return FALSE

	if(!can_communicate(TRUE))
		to_chat(parent, span_warning("You are unable to speak!"))
		return FALSE

	if(!message_to_say)
		return FALSE

	var/datum/carrier_room/room = current_room.resolve()
	if(!room) // uhoh.
		current_room = null
		return FALSE

	room.send_message(message_to_say, name, parent_mob, TRUE)
	return TRUE

/// Modifies the sense of the parent mob based on the variable `sense_to_toggle`. Returns the state of the modified variable
/datum/component/carrier_user/proc/toggle_sense(datum/source, sense_to_toggle)
	SIGNAL_HANDLER
	var/status = FALSE
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return FALSE

	switch(sense_to_toggle)
		if("external_hearing")
			outside_hearing = !outside_hearing
			if(outside_hearing)
				REMOVE_TRAIT(parent_mob, TRAIT_DEAF, TRAIT_CARRIER)
			else
				ADD_TRAIT(parent_mob, TRAIT_DEAF, TRAIT_CARRIER)

			status = outside_hearing

		if("external_sight")
			outside_sight = !outside_sight
			if(outside_sight)
				parent_mob.cure_blind(TRAIT_CARRIER)
			else
				parent_mob.become_blind(TRAIT_CARRIER)

			status = outside_sight

		if("hearing")
			internal_hearing = !internal_hearing
			status = internal_hearing

		if("sight")
			internal_sight = !internal_sight
			status = internal_sight

		if("able_to_emote")
			able_to_emote = !able_to_emote
			status = able_to_emote

		if("able_to_speak")
			able_to_speak = !able_to_speak
			status = able_to_speak

		if("able_to_rename")
			able_to_rename = !able_to_rename
			status = able_to_rename

		if("able_to_emote_as_container")
			able_to_emote_as_container = !able_to_emote_as_container
			status = able_to_emote_as_container

		if("able_to_speak_as_container")
			able_to_speak_as_container = !able_to_speak_as_container
			status = able_to_speak_as_container

	return status

/// Changes the name show on the component based off `new_name`. Returns `TRUE` if the name has been changed, otherwise returns `FALSE`.
/datum/component/carrier_user/proc/change_name(datum/source, new_name)
	SIGNAL_HANDLER
	var/mob/living/parent_mob = parent
	if(!new_name || !istype(parent_mob) || !able_to_rename)
		return FALSE

	var/mob/living/soulcatcher_soul/soul_mob = parent
	if(istype(soul_mob) && (soul_mob.round_participant && soul_mob.body_scan_needed))
		return FALSE

	name = new_name
	return TRUE

/// Attempts to reset the mob's name to it's name in prefs. Returns `TRUE` if the name is reset, otherwise returns `FALSE`.
/datum/component/carrier_user/proc/reset_name(datum/source)
	SIGNAL_HANDLER
	var/mob/living/parent_mob = parent
	if(!parent_mob?.mind?.name || !change_name(new_name = parent_mob.mind.name))
		return FALSE

	return TRUE

/// Is the carrier mob able to communicate? Returns `TRUE` if they can, otherwise returns `FALSE`
/datum/component/carrier_user/proc/can_communicate(emote = FALSE)
	if(communicating_externally)
		if((emote && !able_to_emote_as_container) || (!emote && !able_to_speak_as_container))
			return FALSE

	if((emote && !able_to_emote) || (!emote && !able_to_speak))
		return FALSE

	return TRUE

//// Is the carrier mob able to witness a message? `Emote` determines if the message is an emote or not.
/datum/component/carrier_user/proc/check_internal_senses(datum/source, emote = FALSE)
	SIGNAL_HANDLER
	if(emote)
		return internal_sight

	return internal_hearing

/// Sets the current room of the carrier component based off of `room_to_set`
/datum/component/carrier_user/proc/set_room(datum/source, datum/carrier_room/room_to_set)
	SIGNAL_HANDLER
	if(!istype(room_to_set))
		return FALSE

	current_room = room_to_set

/datum/component/carrier_user/Destroy(force, silent)
	if(!outside_hearing)
		toggle_sense("external_hearing")

	if(!outside_sight)
		toggle_sense("external_sight")

	if(carrier_action)
		QDEL_NULL(carrier_action)

	if(leave_action)
		QDEL_NULL(leave_action)

	return ..()

/datum/component/carrier_user/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_CARRIER_MOB_TOGGLE_SENSE,
		COMSIG_CARRIER_MOB_RENAME,
		COMSIG_CARRIER_MOB_RESET_NAME,
		COMSIG_CARRIER_MOB_CHANGE_ROOM,
		COMSIG_CARRIER_MOB_CHECK_INTERNAL_SENSES,
		COMSIG_CARRIER_MOB_REFRESH_APPEARANCE,
	))

/datum/action/innate/carrier_user
	name = "carrier"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "soulcatcher"
	/// What carrier user component are we bringing up the menu for?
	var/datum/weakref/carrier_user_component

/datum/action/innate/carrier_user/Activate()
	. = ..()
	var/datum/component/carrier_user/user_component = carrier_user_component.resolve()
	if(!user_component)
		carrier_user_component = null
		return FALSE

	user_component.ui_interact(owner)
