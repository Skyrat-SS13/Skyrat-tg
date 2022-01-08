/mob/living/verb/container_emote()
	set name = "Emote Using Vehicle/Container"
	set category = "IC"

	if (isturf(src.loc))
		to_chat(src, span_danger("You are not within anything!"))
		return
	if (loc && (!src.IsUnconscious())) // If user's location is a turf, if it is not null, and if the user is not unconcious, continue.
		usr.emote("exme")

/datum/emote/container_emote
	key = "exme"
	key_third_person = "exme"
	message = null

/datum/emote/container_emote/run_emote(mob/living/user, params, type_override = null, intentional = TRUE)
	/// The message that will be sent from the container emote.
	var/container_message
	/// What was inputted by the user.
	var/container_emote = params
	if(QDELETED(user))
		return FALSE
	if(is_banned_from(user, "emote"))
		tgui_alert(user, "You cannot send emotes (banned).")
		return FALSE
	else if(user.client?.prefs?.muted & MUTE_IC)
		tgui_alert(user, "You cannot send IC messages (muted).")
		return FALSE
	else if (isturf(user.loc))
		to_chat(user, "You are not within anything!") // If user is banned from chat, emotes, or the user is not within anything (ex. a locker) return.
		return FALSE //im keeping this to_chat because this seems like a really common use case and i dont want to annoy players
	else if(!params) // User didn't put anything after *exme when using the say hotkey, or just used the emote raw? Open a window.
		container_emote = tgui_input_text(user, "What would you like to emote?", "Container Emote" , null, MAX_MESSAGE_LEN, TRUE, TRUE, 0)
		if(!container_emote)
			return FALSE
		var/list/choices = list("Visible","Audible")
		var/type = tgui_input_list(user, "Is this a visible or audible emote?", "Container Emote", choices, 0)
		switch(type)
			if("Visible")
				emote_type = EMOTE_VISIBLE
			if("Audible")
				emote_type = EMOTE_AUDIBLE
			else
				tgui_alert(user, "Unable to use this emote, must be either audible or visible.")
				return
		container_message = container_emote //Ill be honest I dont know why this is a thing but I'm too afraid to remove it.
	else
		container_message = params // Same as above.
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

	// These steps are crucial for runetext to work.
	if(emote_type == EMOTE_AUDIBLE)
		user.loc.audible_message(message = container_message, self_message = container_message, audible_message_flags = EMOTE_MESSAGE, separation = space)
	else if (emote_type == EMOTE_VISIBLE)
		user.loc.visible_message(message = container_message, self_message = container_message, visible_message_flags = EMOTE_MESSAGE, separation = space)
