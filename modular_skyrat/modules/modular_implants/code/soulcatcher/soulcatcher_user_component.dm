/// The component given to soulcatcher inhabitants
/datum/component/soulcatcher_user
	/// What is the name of our soul?
	var/name
	/// What does our soul look like?
	var/desc = "It's a soul."
	/// What are the ooc notes for the soul?
	var/ooc_notes = ""

	/// What is the weakref of the soulcatcher room are we currently in?
	var/datum/weakref/current_room

	/// Is the soul able to see things in the outside world?
	var/outside_sight = TRUE
	/// Is the soul able to hear things from the outside world?
	var/outside_hearing = TRUE
	/// Is the soul able to "see" things from inside of the soulcatcher?
	var/internal_sight = TRUE
	/// Is the soul able to "hear" things from inside of the soulcatcher?
	var/internal_hearing = TRUE
	/// Is the soul able to emote inside the soulcatcher room?
	var/able_to_emote = TRUE
	/// Is the soul able to speak inside the soulcatcher room?
	var/able_to_speak = TRUE
	/// Is the soul able to change their own name?
	var/able_to_rename = TRUE
	/// Is the soul able to speak as the object it is inside?
	var/able_to_speak_as_container = TRUE
	/// Is the soul able to emote as the object it is inside?
	var/able_to_emote_as_container = TRUE
	/// Are emote's and Say's done through the container the mob is in?
	var/communicating_externally = FALSE

	/// Is the action to control the HUD given to the mob?
	var/hud_action_given = TRUE
	/// The coresponding action used to pull up the HUD
	var/datum/action/innate/soulcatcher_user/soulcatcher_action
	/// Is the action to leave given to the mob?
	var/leave_action_given = TRUE
	/// The coresponding action used to leave the soulcatcher
	var/datum/action/innate/leave_soulcatcher/leave_action

/datum/component/soulcatcher_user/New()
	. = ..()
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return COMPONENT_INCOMPATIBLE

	if(hud_action_given)
		soulcatcher_action = new
		soulcatcher_action.Grant(parent_mob)
		soulcatcher_action.soulcatcher_user_component = WEAKREF(src)

	if(leave_action_given)
		leave_action = new
		leave_action.Grant(parent_mob)

	if(!outside_sight)
		outside_sight = TRUE
		toggle_sense(sense_to_toggle = "outside_sight")

	if(!outside_hearing)
		outside_hearing = TRUE
		toggle_sense(sense_to_toggle = "outside_hearing")

	set_up()

	RegisterSignal(parent, COMSIG_SOULCATCHER_TOGGLE_SENSE, PROC_REF(toggle_sense))
	RegisterSignal(parent, COMSIG_SOULCATCHER_SOUL_RENAME, PROC_REF(change_name))
	RegisterSignal(parent, COMSIG_SOULCATCHER_SOUL_RESET_NAME, PROC_REF(reset_name))
	RegisterSignal(parent, COMSIG_SOULCATCHER_SOUL_CHANGE_ROOM, PROC_REF(set_room))
	RegisterSignal(parent, COMSIG_SOULCATCHER_SOUL_CHECK_INTERNAL_SENSES, PROC_REF(check_internal_senses))

	return TRUE

/// Configures the settings of the soulcatcher user to be in accordance with the parent mob
/datum/component/soulcatcher_user/proc/set_up()
	var/mob/living/parent_mob = parent
	if(!parent_mob?.mind || !istype(parent_mob.mind))
		return FALSE

	var/datum/preferences/preferences = parent_mob.client?.prefs
	if(!preferences)
		return FALSE

	name = parent_mob.mind.name
	ooc_notes = preferences.read_preference(/datum/preference/text/ooc_notes)
	desc = preferences.read_preference(/datum/preference/text/flavor_text)

/// What do we want to do when a mob tries to say something into the soulcatcher?
/datum/component/soulcatcher_user/proc/say(message_to_say)
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return FALSE

	if(!can_communicate())
		to_chat(parent, span_warning("You are unable to speak!"))
		return FALSE

	if(!message_to_say)
		return FALSE

	var/datum/soulcatcher_room/room = current_room.resolve()
	if(!room) // uhoh.
		return FALSE

	room.send_message(message_to_say, name, parent_mob, FALSE)
	return TRUE

/// What do we want to do when a mob tries to do a `me` emote?
/datum/component/soulcatcher_user/proc/me_verb(message_to_say)
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return FALSE

	if(!can_communicate(TRUE))
		to_chat(parent, span_warning("You are unable to speak!"))
		return FALSE

	if(!message_to_say)
		return FALSE

	var/datum/soulcatcher_room/room = current_room.resolve()
	if(!room) // uhoh.
		return FALSE

	room.send_message(message_to_say, name, parent_mob, TRUE)
	return TRUE

/// Modifies the sense of the parent mob based on the variable `sense_to_toggle`. Returns the state of the modified variable
/datum/component/soulcatcher_user/proc/toggle_sense(datum/source, sense_to_toggle)
	SIGNAL_HANDLER
	var/status = FALSE
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return FALSE

	switch(sense_to_toggle)
		if("external_hearing")
			outside_hearing = !outside_hearing
			if(outside_hearing)
				REMOVE_TRAIT(parent_mob, TRAIT_DEAF, SOULCATCHER_TRAIT)
			else
				ADD_TRAIT(parent_mob, TRAIT_DEAF, SOULCATCHER_TRAIT)

			status = outside_hearing

		if("external_sight")
			outside_sight = !outside_sight
			if(outside_sight)
				parent_mob.cure_blind(SOULCATCHER_TRAIT)
			else
				parent_mob.become_blind(SOULCATCHER_TRAIT)

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
/datum/component/soulcatcher_user/proc/change_name(datum/source, new_name)
	SIGNAL_HANDLER
	var/mob/living/parent_mob = parent
	if(!new_name || !istype(parent_mob) || !able_to_rename)
		return FALSE

	var/mob/living/soulcatcher_soul/parent_soul = parent
	if(istype(parent_soul) && (parent_soul.round_participant && parent_soul.body_scan_needed))
		return FALSE

	name = new_name
	return TRUE

/// Attempts to reset the soul's name to it's name in prefs. Returns `TRUE` if the name is reset, otherwise returns `FALSE`.
/datum/component/soulcatcher_user/proc/reset_name(datum/source)
	SIGNAL_HANDLER
	var/mob/living/parent_mob = parent
	if(!parent_mob?.mind?.name || !change_name(new_name = parent_mob.mind.name))
		return FALSE

	return TRUE

/// Is the soulcatcher soul able to communicate? Returns `TRUE` if they can, otherwise returns `FALSE`
/datum/component/soulcatcher_user/proc/can_communicate(emote = FALSE)
	if(communicating_externally)
		if((emote && !able_to_emote_as_container) || (!emote && !able_to_speak_as_container))
			return FALSE

	if((emote && !able_to_emote) || (!emote && !able_to_speak))
		return FALSE

	return TRUE

//// Is the soulcatcher soul able to witness a message? `Emote` determines if the message is an emote or not.
/datum/component/soulcatcher_user/proc/check_internal_senses(datum/source, emote = FALSE)
	SIGNAL_HANDLER
	if(emote)
		return internal_sight

	return internal_hearing

/// Sets the current room of the soulcatcher component based off of `room_to_set`
/datum/component/soulcatcher_user/proc/set_room(datum/source, datum/soulcatcher_room/room_to_set)
	SIGNAL_HANDLER
	if(!istype(room_to_set))
		return FALSE

	current_room = room_to_set

/datum/component/soulcatcher_user/Destroy(force, silent)
	if(!outside_hearing)
		toggle_sense("external_hearing")

	if(!outside_sight)
		toggle_sense("external_sight")

	if(soulcatcher_action)
		qdel(soulcatcher_action)

	if(leave_action)
		qdel(leave_action)

	UnregisterSignal(parent, COMSIG_SOULCATCHER_TOGGLE_SENSE)
	UnregisterSignal(parent, COMSIG_SOULCATCHER_SOUL_RENAME)
	UnregisterSignal(parent, COMSIG_SOULCATCHER_SOUL_RESET_NAME)
	UnregisterSignal(parent, COMSIG_SOULCATCHER_SOUL_CHANGE_ROOM)
	UnregisterSignal(parent, COMSIG_SOULCATCHER_SOUL_CHECK_INTERNAL_SENSES)

	return ..()

/datum/action/innate/soulcatcher_user
	name = "Soulcatcher"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "soulcatcher"
	/// What soulcatcher user component are we bringing up the menu for?
	var/datum/weakref/soulcatcher_user_component

/datum/action/innate/soulcatcher_user/Activate()
	. = ..()
	var/datum/component/soulcatcher_user/user_component = soulcatcher_user_component.resolve()
	if(!user_component)
		return FALSE

	user_component.ui_interact(owner)
