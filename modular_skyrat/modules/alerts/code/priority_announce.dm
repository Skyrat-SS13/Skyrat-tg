///Sends an announcement to all players and formats it accordingly. Use this for big bad shit.
/proc/priority_announce(text, title = "", sound, type , sender_override, has_important_message, players)
	if(!text)
		return

	var/announcement

	if(!sound)
		sound = SSstation.announcer.get_rand_alert_sound()
	else if(SSstation.announcer.event_sounds[sound])
		var/list/picked = SSstation.announcer.event_sounds[sound]
		sound = pick(picked)

	if(type == "Priority")
		announcement += "<h1 class='alert'>Priority Announcement</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"
	else if(type == JOB_CAPTAIN)
		announcement += "<h1 class='alert'>Captain Announces</h1>"
		GLOB.news_network.SubmitArticle(html_encode(text), "Captain's Announcement", "Station Announcements", null)
	else if(type == "Syndicate Captain")
		announcement += "<h1 class='alert'>Syndicate Captain Announces</h1>"

	else
		if(!sender_override)
			announcement += "<h1 class='alert'>[command_name()] Update</h1>"
		else
			announcement += "<h1 class='alert'>[sender_override]</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"

		if(!sender_override)
			if(title == "")
				GLOB.news_network.SubmitArticle(text, "Central Command Update", "Station Announcements", null)
			else
				GLOB.news_network.SubmitArticle(title + "<br><br>" + text, "Central Command", "Station Announcements", null)

	///If the announcer overrides alert messages, use that message.
	if(SSstation.announcer.custom_alert_message && !has_important_message)
		announcement +=  SSstation.announcer.custom_alert_message
	else
		announcement += "<br><span class='alert'>[html_encode(text)]</span><br>"
	announcement += "<br>"

	if(!players)
		players = GLOB.player_list

	var/sound_to_play = sound(sound)

	alert_sound_to_playing(sound_to_play, players = players)

	for(var/mob/target in players)
		if(!isnewplayer(target) && target.can_hear())
			to_chat(target, announcement)

/proc/print_command_report(text = "", title = null, announce=TRUE)
	if(!title)
		title = "Classified [command_name()] Update"

	if(announce)
		priority_announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", SSstation.announcer.get_rand_report_sound(), has_important_message = TRUE)

	var/datum/comm_message/M  = new
	M.title = title
	M.content =  text

	SScommunications.send_message(M)

///This proc sends an announcement to all currently playing mobs. Use alert to send a more ominious BEEP. Generally used for updating people on minor things, such as CME locaiton. Use priority_announce for large announcements.
/proc/minor_announce(message, title = "Attention:", alert, html_encode = TRUE, list/players, sound, override_volume = FALSE)
	if(!message)
		return

	if (html_encode)
		title = html_encode(title)
		message = html_encode(message)

	if(!players)
		players = GLOB.player_list

	for(var/mob/M in players)
		if(!isnewplayer(M) && M.can_hear())
			to_chat(M, span_minorannounce("<font color = red>[title]</font color><BR>[message]</span><BR>"))

	if(sound)
		if(SSstation.announcer.event_sounds[sound])
			var/list/picked = SSstation.announcer.event_sounds[sound]
			sound = pick(picked)
		alert_sound_to_playing(sound, override_volume = override_volume, players = players)

	if(alert)
		alert_sound_to_playing(sound('modular_skyrat/modules/alerts/sound/alert1.ogg'), players = players)
	else
		alert_sound_to_playing(sound('sound/misc/notice2.ogg'), players = players)
