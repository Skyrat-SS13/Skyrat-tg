#define SUBTLE_DEFAULT_DISTANCE 1
#define SUBTLE_SAME_TILE_DISTANCE 0

#define SUBTLE_ONE_TILE_TEXT "1-Tile Range"
#define SUBTLE_SAME_TILE_TEXT "Same Tile"

/*
*	SUBTLE 2: NO GHOST BOOGALOO
*/

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
	var/target
	if(SSdbcore.IsConnected() && is_banned_from(user, "emote"))
		to_chat(user, span_warning("You cannot send subtle emotes (banned)."))
		return FALSE
	else if(user.client?.prefs.muted & MUTE_IC)
		to_chat(user, span_warning("You cannot send IC messages (muted)."))
		return FALSE
	else if(!subtle_emote)
		subtle_emote = tgui_input_text(user, "Choose an emote to display.", "subtle" , null, MAX_MESSAGE_LEN, TRUE)
		if(!subtle_emote)
			return FALSE

		var/list/in_view = get_hearers_in_view(1, user)

		var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
		if(hologram)
			in_view |= get_hearers_in_view(1, hologram)

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
		subtle_message = subtle_emote
	else
		target = SUBTLE_DEFAULT_DISTANCE
		subtle_message = subtle_emote
		if(type_override)
			emote_type = type_override

	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE

	user.log_message(subtle_message, LOG_SUBTLE)

	var/space = should_have_space_before_emote(html_decode(subtle_emote)[1]) ? " " : ""

	subtle_message = span_emote("<b>[user]</b>[space]<i>[user.say_emphasis(subtle_message)]</i>")

	if(istype(target, /mob))
		var/mob/target_mob = target
		user.show_message(subtle_message, alt_msg = subtle_message)
		var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
		if((get_dist(user.loc, target_mob.loc) <= SUBTLE_DEFAULT_DISTANCE) || (hologram && get_dist(hologram.loc, target_mob.loc) <= SUBTLE_DEFAULT_DISTANCE))
			target_mob.show_message(subtle_message, alt_msg = subtle_message)
		else
			to_chat(user, span_warning("Your emote was unable to be sent to your target: Too far away."))

	else if(istype(target, /obj/effect/overlay/holo_pad_hologram))
		var/obj/effect/overlay/holo_pad_hologram/hologram = target
		if(hologram.Impersonation?.client)
			hologram.Impersonation.show_message(subtle_message, alt_msg = subtle_message)
	else
		var/list/hearers = get_hearers_in_view(target, user)
		if(HAS_TRAIT(user, TRAIT_NO_GHOST_MESSAGES))
			hearers -= GLOB.dead_mob_list

		var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
		if(hologram)
			hearers |= get_hearers_in_view(target, hologram)

		for(var/obj/effect/overlay/holo_pad_hologram/holo in hearers)
			if(holo?.Impersonation?.client)
				hearers |= holo.Impersonation

		for(var/mob/reciever in hearers)
			reciever.show_message(subtle_message, alt_msg = subtle_message)

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

#undef SUBTLE_DEFAULT_DISTANCE
#undef SUBTLE_SAME_TILE_DISTANCE

#undef SUBTLE_ONE_TILE_TEXT
#undef SUBTLE_SAME_TILE_TEXT
