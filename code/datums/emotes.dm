#define EMOTE_VISIBLE 1
#define EMOTE_AUDIBLE 2

/datum/emote
	var/key = "" //What calls the emote
	var/key_third_person = "" //This will also call the emote
	var/message = "" //Message displayed when emote is used
	var/message_mime = "" //Message displayed if the user is a mime
	var/message_alien = "" //Message displayed if the user is a grown alien
	var/message_larva = "" //Message displayed if the user is an alien larva
	var/message_robot = "" //Message displayed if the user is a robot
	var/message_AI = "" //Message displayed if the user is an AI
	var/message_monkey = "" //Message displayed if the user is a monkey
	var/message_simple = "" //Message to display if the user is a simple_animal
	var/message_param = "" //Message to display if a param was given
	var/emote_type = EMOTE_VISIBLE //Whether the emote is visible or audible
	/// Checks if the mob can use its hands before performing the emote.
	var/hands_use_check = FALSE
	var/muzzle_ignore = FALSE //Will only work if the emote is EMOTE_AUDIBLE
	var/list/mob_type_allowed_typecache = /mob //Types that are allowed to use that emote
	var/list/mob_type_blacklist_typecache //Types that are NOT allowed to use that emote
	var/list/mob_type_ignore_stat_typecache
	var/stat_allowed = CONSCIOUS
	var/sound //Sound to play when emote is called
	var/vary = FALSE //used for the honk borg emote
	var/only_forced_audio = FALSE //can only code call this event instead of the player.
	var/cooldown = 0.8 SECONDS
	//SKYRAT EDIT ADDITION BEGIN - EMOTES
	var/sound_volume = 25 //Emote volume
	var/list/allowed_species
	//SKYRAT EDIT ADDITION END

/datum/emote/New()
	if (ispath(mob_type_allowed_typecache))
		switch (mob_type_allowed_typecache)
			if (/mob)
				mob_type_allowed_typecache = GLOB.typecache_mob
			if (/mob/living)
				mob_type_allowed_typecache = GLOB.typecache_living
			else
				mob_type_allowed_typecache = typecacheof(mob_type_allowed_typecache)
	else
		mob_type_allowed_typecache = typecacheof(mob_type_allowed_typecache)
	mob_type_blacklist_typecache = typecacheof(mob_type_blacklist_typecache)
	mob_type_ignore_stat_typecache = typecacheof(mob_type_ignore_stat_typecache)

/datum/emote/proc/run_emote(mob/user, params, type_override, intentional = FALSE)
	. = TRUE
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	var/msg = select_message_type(user, intentional)
	if(params && message_param)
		msg = select_param(user, params)

	msg = replace_pronoun(user, msg)

	if(isliving(user))
		var/mob/living/L = user
		for(var/obj/item/implant/I in L.implants)
			I.trigger(key, L)

	if(!msg)
		return

	user.log_message(msg, LOG_EMOTE)
	var/dchatmsg = "<b>[user]</b> [msg]"

	var/tmp_sound = get_sound(user)
	if(tmp_sound && (!only_forced_audio || !intentional))
		//SKYRAT EDIT CHANGE BEGIN
		//playsound(user, tmp_sound, 50, vary) - SKYRAT EDIT - ORIGINAL
		playsound(user, tmp_sound, sound_volume, vary)
		//SKYRAT EDIT CHANGE END

	for(var/mob/M in GLOB.dead_mob_list)
		if(!M.client || isnewplayer(M))
			continue
		var/T = get_turf(user)
		if(M.stat == DEAD && M.client && user.client && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(T, null)))
			M.show_message("<span class='emote'>[FOLLOW_LINK(M, user)] [dchatmsg]</span>")

	if(emote_type == EMOTE_AUDIBLE)
		//SKYRAT EDIT CHANGE BEGIN
		//user.audible_message(msg, audible_message_flags = EMOTE_MESSAGE) - SKYRAT EDIT - ORIGINAL
		user.audible_message(msg, deaf_message = "<span class='emote'>You see how <b>[user]</b> [msg]</span>", audible_message_flags = EMOTE_MESSAGE)
	else
		//user.visible_message(msg, visible_message_flags = EMOTE_MESSAGE) - SKYRAT EDIT - ORIGINAL
		user.visible_message(msg, blind_message = "<span class='emote'>You hear how <b>[user]</b> [msg]</span>", visible_message_flags = EMOTE_MESSAGE)
		//SKYRAT EDIT CHANGE END

/// For handling emote cooldown, return true to allow the emote to happen
/datum/emote/proc/check_cooldown(mob/user, intentional)
	if(!intentional)
		return TRUE
	//SKYRAT EDIT CHANGE BEGIN - EMOTES - GLOBAL COOLDOWN
	//if(user.emotes_used && user.emotes_used[src] + cooldown > world.time) - SKYRAT EDIT - ORIGINAL
	if(user.nextsoundemote > world.time)
		var/datum/emote/default_emote = /datum/emote
		if(cooldown > initial(default_emote.cooldown)) // only worry about longer-than-normal emotes
			to_chat(user, "<span class='danger'>You must wait another [DisplayTimeText(user.emotes_used[src] - world.time + cooldown)] before using that emote.</span>")
		return FALSE
	//if(!user.emotes_used)
	//	user.emotes_used = list()
	//user.emotes_used[src] = world.time - SKYRAT EDIT - ORIGINAL
	user.nextsoundemote = world.time + cooldown
	//SKYRAT EDIT CHANGE END
	return TRUE

/datum/emote/proc/get_sound(mob/living/user)
	return sound //by default just return this var.

/datum/emote/proc/replace_pronoun(mob/user, message)
	if(findtext(message, "their"))
		message = replacetext(message, "their", user.p_their())
	if(findtext(message, "them"))
		message = replacetext(message, "them", user.p_them())
	if(findtext(message, "they"))
		message = replacetext(message, "they", user.p_they())
	if(findtext(message, "%s"))
		message = replacetext(message, "%s", user.p_s())
	return message

/datum/emote/proc/select_message_type(mob/user, intentional)
	. = message
	if(!muzzle_ignore && user.is_muzzled() && emote_type == EMOTE_AUDIBLE)
		return "makes a [pick("strong ", "weak ", "")]noise."
	if(user.mind && user.mind.miming && message_mime)
		. = message_mime
	if(isalienadult(user) && message_alien)
		. = message_alien
	else if(islarva(user) && message_larva)
		. = message_larva
	else if(iscyborg(user) && message_robot)
		. = message_robot
	else if(isAI(user) && message_AI)
		. = message_AI
	else if(ismonkey(user) && message_monkey)
		. = message_monkey
	else if(isanimal(user) && message_simple)
		. = message_simple

/datum/emote/proc/select_param(mob/user, params)
	return replacetext(message_param, "%t", params)

/datum/emote/proc/can_run_emote(mob/user, status_check = TRUE, intentional = FALSE)
	. = TRUE
	if(!is_type_in_typecache(user, mob_type_allowed_typecache))
		return FALSE
	if(is_type_in_typecache(user, mob_type_blacklist_typecache))
		return FALSE
	if(status_check && !is_type_in_typecache(user, mob_type_ignore_stat_typecache))
		if(user.stat > stat_allowed)
			if(!intentional)
				return FALSE
			switch(user.stat)
				if(SOFT_CRIT)
					to_chat(user, "<span class='warning'>You cannot [key] while in a critical condition!</span>")
				if(UNCONSCIOUS, HARD_CRIT)
					to_chat(user, "<span class='warning'>You cannot [key] while unconscious!</span>")
				if(DEAD)
					to_chat(user, "<span class='warning'>You cannot [key] while dead!</span>")
			return FALSE
		if(hands_use_check && HAS_TRAIT(user, TRAIT_HANDS_BLOCKED))
			if(!intentional)
				return FALSE
			to_chat(user, "<span class='warning'>You cannot use your hands to [key] right now!</span>")
			return FALSE

	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_EMOTEMUTE))
			return FALSE
	//SKYRAT EDIT BEGIN
	if(allowed_species)
		var/check = FALSE
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.dna.species.type in allowed_species)
				check = TRUE
		return check
	//SKYRAT EDIT END

/**
* Allows the intrepid coder to send a basic emote
* Takes text as input, sends it out to those who need to know after some light parsing
* If you need something more complex, make it into a datum emote
* Arguments:
* * text - The text to send out
*/
/mob/proc/manual_emote(text) //Just override the song and dance
	. = TRUE
	if(findtext(text, "their"))
		text = replacetext(text, "their", p_their())
	if(findtext(text, "them"))
		text = replacetext(text, "them", p_them())
	if(findtext(text, "%s"))
		text = replacetext(text, "%s", p_s())

	if(stat != CONSCIOUS)
		return

	if(!text)
		CRASH("Someone passed nothing to manual_emote(), fix it")

	log_message(text, LOG_EMOTE)

	var/ghost_text = "<b>[src]</b> " + text //Sin I know

	for(var/mob/M in GLOB.dead_mob_list)
		if(!M.client || isnewplayer(M))
			continue
		var/T = get_turf(src)
		if(M.stat == DEAD && M.client && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(T, null)))
			M.show_message("[FOLLOW_LINK(M, src)] [ghost_text]")

	visible_message(text, visible_message_flags = EMOTE_MESSAGE)
