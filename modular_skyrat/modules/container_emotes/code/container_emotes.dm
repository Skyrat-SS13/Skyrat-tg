/mob/living/verb/container_emote()
	set name = "Emote Using Vehicle/Container"
	set category = "IC"

	if (isturf(src.loc))
		to_chat(src, span_danger("You are not within anything!"))
		return
	if (loc && (!src.IsUnconscious()))
		usr.emote("exme")

/datum/emote/container_emote
	key = "exme"
	key_third_person = "exme"
	message = null

/datum/emote/container_emote/run_emote(mob/living/user, params, type_override = null, intentional = TRUE)
	var/container_message
	var/container_emote = params
	if(QDELETED(user))
		return FALSE
	if(is_banned_from(user, "emote"))
		to_chat(user, "You cannot send emotes (banned).")
		return FALSE
	else if(user.client?.prefs?.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if (isturf(user.loc))
		to_chat(user, "You are not within anything!")
		return FALSE
	else if(!params)
		container_emote = stripped_multiline_input(user, "Choose an emote to display.", "Container Emote" , null, MAX_MESSAGE_LEN)
		if(!container_emote)
			return FALSE
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
		container_message = params
		if(type_override)
			emote_type = type_override
		else
			emote_type = EMOTE_VISIBLE
	. = TRUE
	if(!can_run_emote(user))
		return FALSE

	user.log_message(container_message, LOG_EMOTE)

	var/space = should_have_space_before_emote(html_decode(container_emote)[1]) ? " " : ""

	container_message = ("[user.say_emphasis(container_message)]")

	if (isturf(user.loc) || (!user.loc) || user.IsUnconscious()) //one last sanity check
		return FALSE

	if(emote_type == EMOTE_AUDIBLE)
		user.loc.audible_message(message = container_message, self_message = container_message, audible_message_flags = EMOTE_MESSAGE, separation = space)
	else if (emote_type == EMOTE_VISIBLE)
		user.loc.visible_message(message = container_message, self_message = container_message, visible_message_flags = EMOTE_MESSAGE, separation = space)








