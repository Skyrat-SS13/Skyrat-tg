/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'> Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(!holder)
		if(!GLOB.looc_allowed)
			to_chat(src, "<span class='danger'> LOOC is globally muted</span>")
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, "<span class='boldannounce'><B>Advertising other servers is not allowed.</B></span>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return
		if(prefs.muted & MUTE_LOOC)
			to_chat(src, "<span class='danger'>You cannot use LOOC (muted).</span>")
			return
		if(mob.stat)
			to_chat(src, "<span class='danger'>You cannot use LOOC while unconscious or dead.</span>")  //Skyrat change
			return
		if(istype(mob, /mob/dead))
			to_chat(src, "<span class='danger'>You cannot use LOOC while ghosting.</span>")
			return

	msg = emoji_parse(msg)

	mob.log_talk(msg,LOG_OOC, tag="LOOC")

	var/list/heard = get_hearers_in_view(7, get_top_level_mob(src.mob))

	//SKYRAT EDIT ADDITION BEGIN - AI QoL
	var/aiAlreadyHeardIt = FALSE
	//so the ai can post looc text
	if(istype(src.mob,/mob/living/silicon/ai))
		for(var/mob/camera/ai_eye/AI_eye as anything in GLOB.aiEyes)
			heard = get_hearers_in_view(7, AI_eye)
	//so the ai can see looc text
	for(var/mob/camera/ai_eye/AI_eye as anything in GLOB.aiEyes)
		for(var/mob/creature in heard) //checks if an ai has already heard it
			if(istype(creature,/mob/living/silicon/ai))
				aiAlreadyHeardIt = TRUE
		if(aiAlreadyHeardIt == FALSE) //i dont wanna run an entire fuckin for loop if it turns out the ai can already see the text
			for(var/mob/creature in heard)
				if(creature==AI_eye)
					heard += get_top_level_mob(src.mob)
	//SKYRAT EDIT ADDITION END - AI QoL

	var/list/admin_seen = list()
	for(var/mob/M in heard)
		if(!M.client)
			continue
		var/client/C = M.client
		if (C.holder)
			admin_seen[C] = TRUE
			continue //they are handled after that

		if (isobserver(M))
			continue //Also handled later.

		to_chat(C, "<span class='looc'><span class='prefix'>LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]</span></span>")

	for(var/cli in GLOB.admins)
		var/client/C = cli
		if (admin_seen[C])
			to_chat(C, "<span class='looc'>[ADMIN_FLW(usr)] <span class='prefix'>LOOC:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span></span>")
		else if (C.prefs.skyrat_toggles & CHAT_LOOC_ADMIN)
			to_chat(C, "<span class='rlooc'>[ADMIN_FLW(usr)] <span class='prefix'>(R)LOOC:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span></span>")

/client/proc/toggle_admin_looc_global()
	set name = "See/Hide Global LOOC"
	set category = "Preferences.Admin"
	set desc = "Show Global LOOC"
	if(!holder)
		return
	prefs.skyrat_toggles ^= CHAT_LOOC_ADMIN
	prefs.save_preferences()
	to_chat(usr, "<span class='infoplain'>You will [(prefs.skyrat_toggles & CHAT_LOOC_ADMIN) ? "now" : "no longer"] hear LOOC globally.</span>")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Togle Admin LOOC", "[usr.client.prefs.skyrat_toggles & CHAT_LOOC_ADMIN ? "Enabled" : "Disabled"]"))
