GLOBAL_VAR_INIT(AOOC_COLOR, "#de3c8c")
GLOBAL_VAR_INIT(aooc_allowed, TRUE)	// used with admin verbs to disable aooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_aooc_name)

#define AOOC_LISTEN_PLAYER 1
#define AOOC_LISTEN_ADMIN 2

/client/verb/aooc(msg as text)
	set name = "AOOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return

	if(!holder)
		if(!mob.mind || !length(mob.mind.antag_datums))
			to_chat(src, "<span class='danger'>You're not an antagonist!</span>")
			return
		if(!GLOB.aooc_allowed)
			to_chat(src, "<span class='danger'>AOOC is globally muted.</span>")
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, "<span class='danger'>You cannot use OOC (muted).</span>")
			return
	if(is_banned_from(ckey, "OOC"))
		to_chat(src, "<span class='danger'>You have been banned from OOC.</span>")
		return
	if(QDELETED(src))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	var/raw_msg = msg

	if(!msg)
		return

	msg = emoji_parse(msg)

	if(!(prefs.chat_toggles & CHAT_OOC))
		to_chat(src, "<span class='danger'>You have OOC muted.</span>")
		return

	mob.log_talk(raw_msg, LOG_OOC, tag="AOOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_aooc_name[key])
			GLOB.ckey_to_aooc_name[key] = "Operator [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_aooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/mind in get_antag_minds(/datum/antagonist))
		var/datum/mind/M = mind
		if(!M.current || !M.current.client || isnewplayer(M.current))
			continue
		listeners[M.current.client] = AOOC_LISTEN_PLAYER

	for(var/m in GLOB.player_list)
		var/mob/M = m
		//Admins with muted OOC do not get to listen to AOOC, but normal players do, as it could be admins talking important stuff to them
		if(M.client && M.client.holder && !M.client.holder.deadmined && M.client.prefs.chat_toggles & CHAT_OOC)
			listeners[M.client] = AOOC_LISTEN_ADMIN

	for(var/c in listeners)
		var/client/C = c
		var/mode = listeners[c]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && C.prefs?.read_preference(/datum/preference/color/ooc_color)) ? C.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.AOOC_COLOR
		var/name = (mode == AOOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(C, "<span class='oocplain'><font color='[color]'><b><span class='prefix'>AOOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font></span>")

#undef AOOC_LISTEN_PLAYER
#undef AOOC_LISTEN_ADMIN

/proc/toggle_aooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling aooc
		if(toggle != GLOB.aooc_allowed)
			GLOB.aooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.aooc_allowed = !GLOB.aooc_allowed
	var/list/listeners = list()
	for(var/mind in get_antag_minds(/datum/antagonist))
		var/datum/mind/M = mind
		if(!M.current || !M.current.client || isnewplayer(M.current))
			continue
		listeners[M.current.client] = TRUE

	for(var/m in GLOB.player_list)
		var/mob/M = m
		if(M.client && M.client.holder && !M.client.holder.deadmined)
			listeners[M.client] = TRUE
	for(var/c in listeners)
		var/client/C = c
		to_chat(C, "<span class='oocplain'><B>The AOOC channel has been globally [GLOB.aooc_allowed ? "enabled" : "disabled"].</B></span>")

/datum/admins/proc/toggleaooc()
	set category = "Server"
	set name="Toggle Antag OOC"
	toggle_aooc()
	log_admin("[key_name(usr)] toggled Antagonist OOC.")
	message_admins("[key_name_admin(usr)] toggled Antagonist OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.aooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
