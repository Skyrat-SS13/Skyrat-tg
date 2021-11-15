/datum/emote/living/subtle
	key = "subtle"
	key_third_person = "subtle"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/subtle/proc/check_invalid(mob/user, input)
	/* TO DO
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
		return TRUE
	*/
	return FALSE

/datum/emote/living/subtle/run_emote(mob/user, params, type_override = null)
	var/subtle_message
	if(is_banned_from(user, "emote"))
		to_chat(user, "You cannot send subtle emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		var/subtle_emote = stripped_multiline_input(user, "Choose an emote to display.", "Subtle", null, MAX_MESSAGE_LEN)
		if(subtle_emote && !check_invalid(user, subtle_emote))
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			subtle_message = subtle_emote
		else
			return FALSE
	else
		subtle_message = params
		if(type_override)
			emote_type = type_override
	. = TRUE
	if(!can_run_emote(user))
		return FALSE

	var/prefix_log_message = "(SUBTLE) [subtle_message]"
	user.log_message(prefix_log_message, LOG_EMOTE)
	subtle_message = "<span class='emote'><b>[user]</b> " + "<i>[user.say_emphasis(subtle_message)]</i></span>"

	for(var/mob/M in GLOB.dead_mob_list)
		if(!M.client || isnewplayer(M))
			continue
		var/T = get_turf(src)
		if(M.stat == DEAD && M.client && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(T, null)))
			M.show_message(subtle_message)

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message(message=subtle_message,hearing_distance=1)
	else
		user.visible_message(message=subtle_message,self_message=subtle_message,vision_distance=1)


///////////////// SUBTLE 2: NO GHOST BOOGALOO

/datum/emote/living/subtler
	key = "subtler"
	key_third_person = "subtler"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)


/datum/emote/living/subtler/proc/check_invalid(mob/user, input)
	/* TO DO
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
		return TRUE
	*/
	return FALSE

/datum/emote/living/subtler/run_emote(mob/user, params, type_override = null)
	var/subtler_message
	if(is_banned_from(user, "emote"))
		to_chat(user, "You cannot send subtle emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		var/subtle_emote = stripped_multiline_input(user, "Choose an emote to display.", "Subtler" , null, MAX_MESSAGE_LEN)
		if(subtle_emote && !check_invalid(user, subtle_emote))
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			subtler_message = subtle_emote
		else
			return FALSE
	else
		subtler_message = params
		if(type_override)
			emote_type = type_override
	. = TRUE
	if(!can_run_emote(user))
		return FALSE

	user.log_message(subtler_message, LOG_SUBTLER)
	subtler_message = "<span class='emote'><b>[user]</b> " + "<i>[user.say_emphasis(subtler_message)]</i></span>"

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message_subtler(message=subtler_message,hearing_distance=1, ignored_mobs = GLOB.dead_mob_list)
	else
		user.visible_message(message=subtler_message,self_message=subtler_message,vision_distance=1, ignored_mobs = GLOB.dead_mob_list)

///////////////// VERB CODE
/mob/living/proc/subtle_keybind()
	var/message = input(src, "", "subtle") as text|null
	if(!length(message))
		return
	return subtle(message)

/mob/living/verb/subtle()
	set name = "Subtle"
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	usr.emote("subtle")

///////////////// VERB CODE 2
/mob/living/verb/subtler()
	set name = "Subtler Anti-Ghost"
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	usr.emote("subtler")

//This is bad code.
/atom/proc/audible_message_subtler(message, deaf_message, hearing_distance = DEFAULT_MESSAGE_RANGE, list/ignored_mobs, self_message, audible_message_flags = NONE)
	var/list/hearers = get_hearers_in_view(hearing_distance, src)
	if(self_message)
		hearers -= src
	hearers -= ignored_mobs
	var/raw_msg = message
	if(audible_message_flags & EMOTE_MESSAGE)
		message = "<b>[src]</b> [message]"
	for(var/mob/M in hearers)
		if(audible_message_flags & EMOTE_MESSAGE && runechat_prefs_check(M, audible_message_flags) && M.can_hear())
			M.create_chat_message(src, raw_message = raw_msg, runechat_flags = audible_message_flags)
		M.show_message(message, MSG_AUDIBLE, deaf_message, MSG_VISUAL)
