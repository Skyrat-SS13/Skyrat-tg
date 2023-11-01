/mob/living/soulcatcher_soul
	/// Is the soul able to leave the soulcatcher?
	var/able_to_leave = TRUE
	/// Did the soul live within the round? This is checked if we want to transfer the soul to another body.
	var/round_participant = FALSE
	/// Does the body need scanned?
	var/body_scan_needed = FALSE
	/// Assuming we died inside of the round? What is our previous body?
	var/datum/weakref/previous_body

/// Checks if the mob wants to leave the soulcatcher. If they do and are able to leave, they are booted out.
/mob/living/soulcatcher_soul/verb/leave_soulcatcher()
	set name = "Leave Soulcatcher"
	set category = "IC"

	if(!able_to_leave)
		to_chat(src, span_warning("You are unable to leave the soulcatcher."))
		return FALSE

	if(tgui_alert(src, "Are you sure you wish to leave the soulcatcher? IF you had a body, this will return you to your body", "Soulcatcher", list("Yes", "No")) != "Yes")
		return FALSE

	if(tgui_alert(src, "Are you really sure about this?", "Soulcatcher", list("Yes", "No")) != "Yes")
		return FALSE

	return_to_body()
	qdel(src)

/mob/living/soulcatcher_soul/ghost()
	. = ..()
	return_to_body()
	qdel(src)

/*
/mob/living/soulcatcher_soul/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof, message_range, datum/saymode/saymode)
	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message || message == "")
		return

	if((!able_to_communicate())
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

	if((!able_to_communicate(TRUE))
		to_chat(src, span_warning("You are unable to emote!"))
		return FALSE

	var/datum/soulcatcher_room/room = current_room.resolve()
	if(!room)
		return FALSE

	room.send_message(message, src, TRUE)
	return TRUE

*/

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

/// Assuming we have a previous body a present mind on our soul, we are going to transfer the mind back to the old body.
/mob/living/soulcatcher_soul/proc/return_to_body()
	if(!previous_body || !mind)
		return FALSE

	var/mob/target_body = previous_body.resolve()
	if(!target_body)
		return FALSE

	mind.transfer_to(target_body)
	SEND_SIGNAL(target_body, COMSIG_SOULCATCHER_CHECK_SOUL, FALSE)

	if(target_body.stat != DEAD)
		target_body.grab_ghost(TRUE)

/mob/living/soulcatcher_soul/Destroy()
	log_message("[key_name(src)] has exited a soulcatcher.", LOG_GAME)
	var/datum/component/soulcatcher_user/soul_component = GetComponent(/datum/component/soulcatcher_user)
	if(soul_component && soul_component.current_room)
		var/datum/soulcatcher_room/room = soul_component.current_room.resolve()
		if(room)
			room.current_souls -= src

		soul_component.current_room = null

	return ..()

/datum/emote/living
	mob_type_blacklist_typecache = list(/mob/living/brain, /mob/living/soulcatcher_soul)

/datum/action/innate/leave_soulcatcher
	name = "Leave Soulcatcher"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "soulcatcher_exit"

/datum/action/innate/leave_soulcatcher/Activate()
	. = ..()
	var/mob/living/soulcatcher_soul/parent_soul = owner
	if(!parent_soul)
		return FALSE

	parent_soul.leave_soulcatcher()

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
