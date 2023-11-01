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
	var/mob/living/soulcatcher_soul/parent_soul = parent
	if(!istype(parent_soul))
		return COMPONENT_INCOMPATIBLE

	if(hud_action_given)
		soulcatcher_action = new
		soulcatcher_action.Grant(parent_soul)
		soulcatcher_action.soulcatcher_user_component = WEAKREF(src)

	if(leave_action_given)
		leave_action = new
		leave_action.Grant(parent_soul)

	if(!outside_sight)
		parent_soul.become_blind(NO_EYES)

	if(!outside_hearing)
		ADD_TRAIT(parent_soul, TRAIT_DEAF, INNATE_TRAIT)

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
	if(!new_name || !istype(parent_mob))
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

	if((emote && !able_to_emote) || (!emote && able_to_speak))
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
