GLOBAL_VAR_INIT(SOOC_COLOR, "#ff5454")
GLOBAL_VAR_INIT(sooc_allowed, TRUE)	// used with admin verbs to disable sooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_sooc_name)

#define SOOC_LISTEN_PLAYER 1
#define SOOC_LISTEN_ADMIN 2

/client/verb/sooc(msg as text)
	set name = "SOOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return

	var/static/list/job_lookup = list("Security Officer"=TRUE, "Warden"=TRUE, "Detective"=TRUE, "Head of Security"=TRUE, "Captain"=TRUE, "Blueshield"=TRUE, "Security Medic"=TRUE, "Security Sergeant"=TRUE, "Civil Disputes Officer"=TRUE)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, "<span class='danger'>You're not a security role!</span>")
			return
		if(!GLOB.sooc_allowed)
			to_chat(src, "<span class='danger'>SOOC is globally muted.</span>")
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

	mob.log_talk(raw_msg, LOG_OOC, tag="SOOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_sooc_name[key])
			GLOB.ckey_to_sooc_name[key] = "Deputy [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_sooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/m in GLOB.player_list)
		var/mob/M = m
		//Admins with muted OOC do not get to listen to SOOC, but normal players do, as it could be admins talking important stuff to them
		if(M.client && M.client.holder && !M.client.holder.deadmined && M.client.prefs.chat_toggles & CHAT_OOC)
			listeners[M.client] = SOOC_LISTEN_ADMIN
		else
			if(M.mind)
				var/datum/mind/MIND = M.mind
				if(job_lookup[MIND.assigned_role.title])
					listeners[M.client] = SOOC_LISTEN_PLAYER

	for(var/c in listeners)
		var/client/C = c
		var/mode = listeners[c]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && C.prefs?.read_preference(/datum/preference/color/ooc_color)) ? C.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.SOOC_COLOR
		var/name = (mode == SOOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(C, "<span class='oocplain'><font color='[color]'><b><span class='prefix'>SOOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font></span>")

#undef SOOC_LISTEN_PLAYER
#undef SOOC_LISTEN_ADMIN

/proc/toggle_sooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling sooc
		if(toggle != GLOB.sooc_allowed)
			GLOB.sooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.sooc_allowed = !GLOB.sooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list("Security Officer"=TRUE, "Warden"=TRUE, "Detective"=TRUE, "Head of Security"=TRUE, "Captain"=TRUE, "Blueshield"=TRUE)
	for(var/m in GLOB.player_list)
		var/mob/M = m
		if(M.client && M.client.holder && !M.client.holder.deadmined)
			listeners[M.client] = TRUE
		else
			if(M.mind)
				var/datum/mind/MIND = M.mind
				if(job_lookup[MIND.assigned_role])
					listeners[M.client] = TRUE
	for(var/c in listeners)
		var/client/C = c
		to_chat(C, "<span class='oocplain'><B>The SOOC channel has been globally [GLOB.sooc_allowed ? "enabled" : "disabled"].</B></span>")

/datum/admins/proc/togglesooc()
	set category = "Server"
	set name="Toggle Security OOC"
	toggle_sooc()
	log_admin("[key_name(usr)] toggled Security OOC.")
	message_admins("[key_name_admin(usr)] toggled Security OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.sooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
