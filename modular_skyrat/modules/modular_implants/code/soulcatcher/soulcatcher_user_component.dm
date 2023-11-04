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
		parent_mob.become_blind(NO_EYES)

	if(!outside_hearing)
		ADD_TRAIT(parent_mob, TRAIT_DEAF, INNATE_TRAIT)

	set_up()

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

	room.send_message(message_to_say, parent_mob, FALSE)
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

	room.send_message(message_to_say, parent_mob, TRUE)
	return TRUE

/// Toggles whether or not the mob inside the soulcatcher can see the outside world. Returns the state of the `outside_sight` variable.
/datum/component/soulcatcher_user/proc/toggle_external_sight()
	var/mob/living/parent_mob = parent
	outside_sight = !outside_sight
	if(outside_sight)
		parent_mob.cure_blind(NO_EYES)
	else
		parent_mob.become_blind(NO_EYES)

	return outside_sight

/// Toggles whether or not the mob inside the soulcatcher can see the outside world. Returns the state of the `outside_hearing` variable.
/datum/component/soulcatcher_user/proc/toggle_external_hearing()
	var/mob/living/parent_mob = parent
	outside_hearing = !outside_hearing
	if(outside_hearing)
		REMOVE_TRAIT(parent_mob, TRAIT_DEAF, INNATE_TRAIT)
	else
		ADD_TRAIT(parent_mob, TRAIT_DEAF, INNATE_TRAIT)

	return outside_hearing

/// Changes the name show on the component based off `new_name`. Returns `TRUE` if the name has been changed, otherwise returns `FALSE`.
/datum/component/soulcatcher_user/proc/change_name(new_name)
	var/mob/living/parent_mob = parent
	if(!new_name || !istype(parent_mob) || !able_to_rename)
		return FALSE

	var/mob/living/soulcatcher_soul/parent_soul = parent
	if(istype(parent_soul) && (parent_soul.round_participant && parent_soul.body_scan_needed))
		return FALSE

	name = new_name
	return TRUE

/// Attempts to reset the soul's name to it's name in prefs. Returns `TRUE` if the name is reset, otherwise returns `FALSE`.
/datum/component/soulcatcher_user/proc/reset_name()
	var/mob/living/parent_mob = parent
	if(!parent_mob?.mind?.name || !change_name(parent_mob.mind.name))
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

/datum/component/soulcatcher_user/Destroy(force, silent)
	if(!outside_hearing)
		toggle_external_hearing()

	if(!outside_sight)
		toggle_external_sight()

	if(soulcatcher_action)
		qdel(soulcatcher_action)

	if(leave_action)
		qdel(leave_action)

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
