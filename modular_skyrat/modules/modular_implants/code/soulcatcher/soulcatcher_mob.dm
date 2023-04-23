/mob/living/soulcatcher_soul
	/// What does our soul look like?
	var/soul_desc = "It's a soul."
	/// What are the ooc notes for the soul?
	var/ooc_notes = ""

	/// Assuming we died inside of the round? What is our previous body?
	var/datum/weakref/previous_body
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

	/// Is the soul able to leave the soulcatcher?
	var/able_to_leave = TRUE
	/// Did the soul live within the round? This is checked if we want to transfer the soul to another body.
	var/round_participant = FALSE
	/// Does the body need scanned?
	var/body_scan_needed = FALSE

/mob/living/soulcatcher_soul/Initialize(mapload)
	. = ..()
	if(!outside_sight)
		become_blind(NO_EYES)

	if(!outside_hearing)
		ADD_TRAIT(src, TRAIT_DEAF, INNATE_TRAIT)

/// Toggles whether or not the soul inside the soulcatcher can see the outside world. Returns the state of the `outside_sight` variable.
/mob/living/soulcatcher_soul/proc/toggle_sight()
	outside_sight = !outside_sight
	if(outside_sight)
		cure_blind(NO_EYES)
	else
		become_blind(NO_EYES)

	return outside_sight

/// Toggles whether or not the soul inside the soulcatcher can see the outside world. Returns the state of the `outside_hearing` variable.
/mob/living/soulcatcher_soul/proc/toggle_hearing()
	outside_hearing = !outside_hearing
	if(outside_hearing)
		REMOVE_TRAIT(src, TRAIT_DEAF, INNATE_TRAIT)
	else
		ADD_TRAIT(src, TRAIT_DEAF, INNATE_TRAIT)

	return outside_hearing

/// Attemp to leave the soulcatcher.
/mob/living/soulcatcher_soul/verb/leave_soulcatcher()
	set name = "Leave Soulcatcher"
	set category = "IC"

	if(!able_to_leave)
		to_chat(src, span_warning("You are unable to leave the soulcatcher."))
		return FALSE

	if(tgui_alert(src, "Are you sure you wish to leave the soulcatcher?", "Soulcatcher", list("Yes", "No")) != "Yes")
		return FALSE

	qdel(src)

/mob/living/soulcatcher_soul/ghost()
	. = ..()
	qdel(src)

/mob/living/soulcatcher_soul/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof, message_range, datum/saymode/saymode)
	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message || message == "")
		return

	if(!able_to_speak)
		to_chat(src, span_warning("You are unable to speak!"))
		return FALSE

	var/datum/soulcatcher_room/room = current_room.resolve()
	if(!room)
		return FALSE

	room.send_message(message, src, FALSE)
	return TRUE

/mob/living/soulcatcher_soul/me_verb(message as text)
	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message)
		return FALSE

	if(!able_to_emote)
		to_chat(src, span_warning("You are unable to speak!"))
		return FALSE

	var/datum/soulcatcher_room/room = current_room.resolve()
	if(!room)
		return FALSE

	room.send_message(message, src, TRUE)
	return TRUE

/mob/living/soulcatcher_soul/subtle()
	set hidden = TRUE
	return FALSE

/mob/living/soulcatcher_soul/subtler()
	set hidden = TRUE
	return FALSE

/mob/living/soulcatcher_soul/whisper_verb()
	set hidden = TRUE
	return FALSE

/mob/living/soulcatcher_soul/container_emote()
	set hidden = TRUE
	return FALSE

/mob/living/soulcatcher_soul/resist()
	set hidden = TRUE
	return FALSE

/mob/living/soulcatcher_soul/Destroy()
	if(current_room)
		var/datum/soulcatcher_room/room = current_room.resolve()
		log_admin("[src] left the following soulcatcher room: [room].")
		room.current_souls -= src

	if(previous_body && mind)
		var/mob/target_body = previous_body.resolve()
		mind.transfer_to(target_body)
		var/datum/component/previous_body/body_component = target_body.GetComponent(/datum/component/previous_body) //Is the soul currently within a soulcatcher?
		if(body_component)
			body_component.restore_mind = FALSE
			qdel(body_component)

		if(target_body.stat != DEAD)
			target_body.grab_ghost(TRUE)

	return ..()
