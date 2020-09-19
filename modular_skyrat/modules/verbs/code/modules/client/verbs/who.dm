/client/verb/who()
	set name = "Who"
	set category = "OOC"

	var/msg = ""

	var/list/Lines = list()
	var/list/assembled = list()
	var/admin_mode = check_rights_for(src, R_ADMIN) && isobserver(mob)
	if(admin_mode)
		log_admin("[key_name(usr)] checked advanced who in-round")
	if(length(GLOB.admins))
		Lines += "<b>Admins:</b>"
		for(var/X in GLOB.admins)
			var/client/C = X
			if(C && C.holder && !C.holder.fakekey)
				assembled += "\t <font color='#FF0000'>[C.key]</font>[admin_mode? "[show_admin_info(C)]":""] ([round(C.avgping, 1)]ms)"
		Lines += sortList(assembled)
	assembled.len = 0
	if(length(GLOB.mentors))
		Lines += "<b>Mentors:</b>"
		for(var/X in GLOB.mentors)
			var/client/C = X
			if(C && (!C.holder || (C.holder && !C.holder.fakekey)))			//>using stuff this complex instead of just using if/else lmao
				assembled += "\t <font color='#0033CC'>[C.key]</font>[admin_mode? "[show_admin_info(C)]":""] ([round(C.avgping, 1)]ms)"
		Lines += sortList(assembled)
	assembled.len = 0
	Lines += "<b>Players:</b>"
	for(var/X in sortList(GLOB.clients))
		var/client/C = X
		if(!C)
			continue
		var/key = C.key
		if(C.holder && C.holder.fakekey)
			key = C.holder.fakekey
		var/keyprint = "[key]"
		if(admin_mode)
			if (C.holder && C.holder.fakekey)
				keyprint = "<font color='#F0C829'>[key]</font>"
			else if (in_tracked_watchlist(key))
				keyprint = "<font color='#B653C9'>[key]</font>"
			else if (C.mob && (C.mob.job == "Security Officer" || C.mob.job == "Warden" || C.mob.job == "Detective" || C.mob.job == "Head of Security"))
				keyprint = "<font color='#BF1D1D'>[key]</font>"
			else if(!C.prefs.exp || text2num(C.prefs.exp[EXP_TYPE_LIVING]) < 300)
				keyprint = "<font color='#538EED'>[key]</font>"
		assembled += "\t [keyprint][admin_mode? "[show_admin_info(C)]":""] ([round(C.avgping, 1)]ms)"
	Lines += sortList(assembled)

	for(var/line in Lines)
		msg += "[line]\n"

	msg += "<b>Total Players: [length(GLOB.clients)]</b>"
	to_chat(src, msg)

/client/proc/show_admin_info(var/client/C)
	if(!C)
		return ""

	var/entry = ""
	if(C.holder && C.holder.fakekey)
		entry += " <i>(as [C.holder.fakekey])</i>"
	if (isnewplayer(C.mob))
		entry += " - <font color='darkgray'><b>In Lobby</b></font>"
	else
		entry += " - Playing as [C.mob.real_name]"
		switch(C.mob.stat)
			if(UNCONSCIOUS)
				entry += " - <font color='darkgray'><b>Unconscious</b></font>"
			if(DEAD)
				if(isobserver(C.mob))
					var/mob/dead/observer/O = C.mob
					if(O.started_as_observer)
						entry += " - <font color='gray'>Observing</font>"
					else
						entry += " - <font color='black'><b>DEAD</b></font>"
				else
					entry += " - <font color='black'><b>DEAD</b></font>"
		if(is_special_character(C.mob))
			if(is_banned_from(C.mob, ROLE_SYNDICATE))
				entry += " - <b><font color='#FF70C6'>Antagonist</font></b>"
			else
				entry += " - <b><font color='red'>Antagonist</font></b>"
	entry += " (<A HREF='?_src_=holder;[HrefToken()];adminmoreinfo=\ref[C.mob]'>?</A>)"
	return entry

