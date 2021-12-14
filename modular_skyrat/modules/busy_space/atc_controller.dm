/////////
// This is simply a copy of 'priority announcements' with minor edits to better fit the ATC system.
// This is required, as we don't have a PA system like most of the Bay-based servers.
/////////
/proc/atc_announce(message, title = "Airspace Announcements", sound = 'sound/misc/compiler-stage2.ogg')
	if(!message)
		return

	for(var/mob/M in GLOB.player_list)
		if(!isnewplayer(M) && M.can_hear())
			to_chat(M, "<span class='bold'><font color = green>[html_encode(title)]</font color><BR>[html_encode(message)]</span><BR>")
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				SEND_SOUND(M, sound('sound/misc/compiler-stage2.ogg'))

/datum/admins/proc/atc_force()
	set name = "Force Random ATC Message"
	set category = "Admin.Events"
	var/datum/lore/atc_controller/ATC = atc

	ATC.random_convo()
