/client/verb/mentorhelp(msg as text)
	set category = "Mentor"
	set name = "Mentorhelp"

	//clean the input msg
	if(!msg)
		return

	//remove out mentorhelp verb temporarily to prevent spamming of mentors.
	remove_verb(src, /client/verb/mentorhelp)
	spawn(30 SECONDS) // Gotta love BYOND, god this is disgusting
		add_verb(src, /client/verb/mentorhelp)	// 30 second cool-down for mentorhelp

	msg = sanitize(copytext_char(msg, 1, MAX_MESSAGE_LEN))
	if(!msg || !mob)
		return

	var/show_char = CONFIG_GET(flag/mentors_mobname_only)
	var/mentor_msg = span_mentor("<b>MENTORHELP:</b> <b>[key_name_mentor(src, TRUE, FALSE, TRUE, show_char)]</b>: [msg]")
	log_mentor("MENTORHELP: [key_name_mentor(src, FALSE, FALSE, FALSE, FALSE)]: [msg]")

	for(var/mentor in GLOB.mentors)
		var/client/mentor_client = mentor
		if(mentor_client)
			SEND_SOUND(mentor_client, 'sound/items/bikehorn.ogg')
			to_chat(mentor_client, mentor_msg)

	to_chat(src, span_mentor("PM to-<b>Mentors</b>: [msg]"))
	return

/proc/get_mentor_counts()
	. = list("total" = 0, "afk" = 0, "present" = 0)
	for(var/mentor in GLOB.mentors)
		var/client/mentor_client = mentor
		.["total"]++
		if(mentor_client.is_afk())
			.["afk"]++
		else
			.["present"]++

/proc/key_name_mentor(whom, include_link = null, include_name = FALSE, include_follow = FALSE, char_name_only = FALSE)
	var/mob/target_mob
	var/client/target_client
	var/key
	var/ckey

	if(!whom)
		return "*null*"
	if(istype(whom, /client))
		target_client = whom
		target_mob = target_client?.mob
		key = target_client?.key
		ckey = target_client?.ckey
	else if(ismob(whom))
		target_mob = whom
		target_client = target_mob.client
		key = target_mob.key
		ckey = target_mob.ckey
	else if(istext(whom))
		key = whom
		ckey = ckey(whom)
		target_client = GLOB.directory[ckey]
		if(target_client)
			target_mob = target_client?.mob
	else
		return "*invalid*"

	. = ""

	if(!ckey)
		include_link = FALSE

	if(key)
		if(include_link)
			if(CONFIG_GET(flag/mentors_mobname_only))
				. += "<a href='?_src_=mentor;mentor_msg=[REF(target_mob)];[MentorHrefToken(TRUE)]'>"
			else
				. += "<a href='?_src_=mentor;mentor_msg=[ckey];[MentorHrefToken(TRUE)]'>"

		if(target_client && target_client?.holder && target_client?.holder.fakekey)
			. += "Administrator"
		else if (char_name_only && CONFIG_GET(flag/mentors_mobname_only))
			if(istype(target_client?.mob,/mob/dead/new_player) || istype(target_client?.mob, /mob/dead/observer)) //If they're in the lobby or observing, display their ckey
				. += key
			else if(target_client && target_client?.mob) //If they're playing/in the round, only show the mob name
				. += target_client?.mob.name
			else //If for some reason neither of those are applicable and they're mentorhelping, show ckey
				. += key
		else
			. += key
		if(!target_client)
			. += "\[DC\]"

		if(include_link)
			. += "</a>"
	else
		. += "*no key*"

	if(include_follow)
		. += " (<a href='?_src_=mentor;mentor_follow=[REF(target_mob)];[MentorHrefToken(TRUE)]'>F</a>)"

	return .
