#define SUBTLE_DEFAULT_DISTANCE 1
#define SUBTLE_SAME_TILE_DISTANCE 0

#define SUBTLE_ONE_TILE_TEXT "1-Tile Range"
#define SUBTLE_SAME_TILE_TEXT "Same Tile"

/datum/emote/living/subtle
	key = "subtle"
	key_third_person = "subtle"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/subtle/run_emote(mob/user, params, type_override = null)
	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE
	var/subtle_message
	var/subtle_emote = params
	if(SSdbcore.IsConnected() && is_banned_from(user, "emote"))
		to_chat(user, "You cannot send subtle emotes (banned).")
		return FALSE
	else if(user.client?.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		subtle_emote = tgui_input_text(user, "Choose an emote to display.", "Subtle", null, MAX_MESSAGE_LEN, TRUE)
		if(!subtle_emote)
			return FALSE
		subtle_message = subtle_emote
	else
		subtle_message = params
		if(type_override)
			emote_type = type_override

	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE

	var/prefix_log_message = "(SUBTLE) [subtle_message]"
	user.log_message(prefix_log_message, LOG_EMOTE)

	var/space = should_have_space_before_emote(html_decode(subtle_emote)[1]) ? " " : ""

	subtle_message = span_emote("<b>[user]</b>[space]<i>[user.say_emphasis(subtle_message)]</i>")

	var/list/viewers = get_hearers_in_view(SUBTLE_DEFAULT_DISTANCE, user)

	var/obj/effect/overlay/holo_pad_hologram/h = GLOB.hologram_impersonators[user]
	if(h)
		viewers |= get_hearers_in_view(SUBTLE_DEFAULT_DISTANCE, h)

	for(var/obj/effect/overlay/holo_pad_hologram/holo in viewers)
		if(holo?.Impersonation?.client)
			viewers |= holo.Impersonation

	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		if((ghost.client?.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(ghost in viewers))
			ghost.show_message(subtle_message)

	for(var/mob/reciever in viewers)
		reciever.show_message(subtle_message, alt_msg = subtle_message)

	return TRUE

/*
*	SUBTLE 2: NO GHOST BOOGALOO
*/

/datum/emote/living/subtler
	key = "subtler"
	key_third_person = "subtler"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/subtler/run_emote(mob/user, params, type_override = null)
	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE
	var/subtler_message
	var/subtler_emote = params
	var/target
	if(SSdbcore.IsConnected() && is_banned_from(user, "emote"))
		to_chat(user, span_warning("You cannot send subtle emotes (banned)."))
		return FALSE
	else if(user.client?.prefs.muted & MUTE_IC)
		to_chat(user, span_warning("You cannot send IC messages (muted)."))
		return FALSE
	else if(!subtler_emote)
		subtler_emote = tgui_input_text(user, "Choose an emote to display.", "Subtler" , null, MAX_MESSAGE_LEN, TRUE)
		if(!subtler_emote)
			return FALSE

		var/list/in_view = get_hearers_in_view(1, user)

		var/obj/effect/overlay/holo_pad_hologram/h = GLOB.hologram_impersonators[user]
		if(h)
			in_view |= get_hearers_in_view(1, h)

		in_view -= GLOB.dead_mob_list
		in_view.Remove(user)

		for(var/mob/camera/ai_eye/ai_eye in in_view)
			in_view.Remove(ai_eye)

		var/list/targets = list(SUBTLE_ONE_TILE_TEXT, SUBTLE_SAME_TILE_TEXT) + in_view
		target = tgui_input_list(user, "Pick a target", "Target Selection", targets)
		if(!target)
			return FALSE

		switch(target)
			if(SUBTLE_ONE_TILE_TEXT)
				target = SUBTLE_DEFAULT_DISTANCE
			if(SUBTLE_SAME_TILE_TEXT)
				target = SUBTLE_SAME_TILE_DISTANCE
		subtler_message = subtler_emote
	else
		target = SUBTLE_DEFAULT_DISTANCE
		subtler_message = subtler_emote
		if(type_override)
			emote_type = type_override

	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE

	user.log_message(subtler_message, LOG_SUBTLER)

	var/space = should_have_space_before_emote(html_decode(subtler_emote)[1]) ? " " : ""

	subtler_message = span_emote("<b>[user]</b>[space]<i>[user.say_emphasis(subtler_message)]</i>")

	if(istype(target, /mob))
		var/mob/M = target
		user.show_message(subtler_message, alt_msg = subtler_message)
		if(get_dist(user.loc, M.loc) <= SUBTLE_DEFAULT_DISTANCE)
			M.show_message(subtler_message, alt_msg = subtler_message)
		else
			to_chat(user, span_warning("Your emote was unable to be sent to your target: Too far away."))
	else if(istype(target, /obj/effect/overlay/holo_pad_hologram))
		var/obj/effect/overlay/holo_pad_hologram/holo = target
		if(holo.Impersonation?.client)
			holo.Impersonation.show_message(subtler_message, alt_msg = subtler_message)
	else
		var/ghostless = get_hearers_in_view(target, user) - GLOB.dead_mob_list

		var/obj/effect/overlay/holo_pad_hologram/h = GLOB.hologram_impersonators[user]
		if(h)
			ghostless |= get_hearers_in_view(target, h)

		for(var/obj/effect/overlay/holo_pad_hologram/holo in ghostless)
			if(holo?.Impersonation?.client)
				ghostless |= holo.Impersonation

		for(var/mob/reciever in ghostless)
			reciever.show_message(subtler_message, alt_msg = subtler_message)

	return TRUE

/*
*	VERB CODE
*/

/mob/living/proc/subtle_keybind()
	var/message = input(src, "", "subtle") as text|null
	if(!length(message))
		return
	return subtle(message)

/mob/living/verb/subtle()
	set name = "Subtle"
	set category = "IC"
	if(GLOB.say_disabled)	// This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	usr.emote("subtle")

/*
*	VERB CODE 2
*/

/mob/living/verb/subtler()
	set name = "Subtler Anti-Ghost"
	set category = "IC"
	if(GLOB.say_disabled)	// This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	usr.emote("subtler")

#undef SUBTLE_DEFAULT_DISTANCE
#undef SUBTLE_SAME_TILE_DISTANCE

#undef SUBTLE_ONE_TILE_TEXT
#undef SUBTLE_SAME_TILE_TEXT
