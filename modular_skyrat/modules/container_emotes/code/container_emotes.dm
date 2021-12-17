/mob/living/verb/container_emote()
	set name = "Emote Using Vehicle/Container"
	set category = "IC"

	if (isturf(src.loc))
		to_chat(src, span_danger("You are not within anything!"))
		return
	if (loc != null && (!src.IsUnconscious()))
		usr.emote("container_emote")

/datum/emote/container_emote
	key = "container_emote"
	key_third_person = "container_emote"
	message = null

/datum/emote/container_emote/run_emote(mob/user, params, type_override = null)
	var/container_message
	var/container_emote = params
	if(is_banned_from(user, "emote"))
		to_chat(user, "You cannot send emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(QDELETED(user))
		return FALSE
	else if (isturf(user.loc))
		return FALSE
	else if(!params)
		container_emote = stripped_multiline_input(user, "Choose an emote to display.", "Container" , null, MAX_MESSAGE_LEN)
		if(container_emote)
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			container_message = container_emote
		else
			return FALSE
	else
		container_message = params
		if(type_override)
			emote_type = type_override
	. = TRUE
	if(!can_run_emote(user))
		return FALSE

	user.log_message(container_message, LOG_EMOTE)

	var/space = should_have_space_before_emote(html_decode(container_emote)[1]) ? " " : ""

	container_message = span_infoplain("<b>[user.loc]</b>[space][user.say_emphasis(container_message)]")

	if (isturf(user.loc)) //one last sanity check
		return FALSE

	if(emote_type == EMOTE_AUDIBLE)
		user.loc.audible_message(message = container_message, self_message = container_message)
	else if (emote_type == EMOTE_VISIBLE)
		user.loc.visible_message(message = container_message, self_message = container_message)

	//user.create_chat_message(src, raw_message = container_message)








