/proc/sentient_priority_announcement(text, title = "", sound, type, sender_override, has_important_message = FALSE, list/mob/players, encode_title = TRUE, encode_text = TRUE)
	text = SSgpt.send_single_request(message = text, preconditioning_prefix = GPT_CONDITIONING_PREFIX_SENTIENT_ANNOUNCER)

	if(encode_title && title && length(title) > 0)
		title = html_encode(title)
	if(encode_text)
		text = html_encode(text)
		if(!length(text))
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
			announcement += "<br><h2 class='alert'>[title]</h2>"
	else if(type == JOB_CAPTAIN)
		announcement += "<h1 class='alert'>Captain Announces</h1>"
		GLOB.news_network.submit_article(text, "Captain's Announcement", "Station Announcements", null)
	else if(type == "Syndicate Captain")
		announcement += "<h1 class='alert'>Syndicate Captain Announces</h1>"

	else
		if(!sender_override)
			announcement += "<h1 class='alert'>[command_name()] Update</h1>"
		else
			announcement += "<h1 class='alert'>[sender_override]</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[title]</h2>"

		if(!sender_override)
			if(title == "")
				GLOB.news_network.submit_article(text, "Central Command Update", "Station Announcements", null)
			else
				GLOB.news_network.submit_article(title + "<br><br>" + text, "Central Command", "Station Announcements", null)

	///If the announcer overrides alert messages, use that message.
	if(SSstation.announcer.custom_alert_message && !has_important_message)
		announcement +=  SSstation.announcer.custom_alert_message
	else
		announcement += "<br><span class='alert'>[text]</span><br>"
	announcement += "<br>"

	if(!players)
		players = GLOB.player_list

	var/sound_to_play = sound(sound)

	alert_sound_to_playing(sound_to_play, players = players)

	for(var/mob/target in players)
		if(!isnewplayer(target) && target.can_hear())
			to_chat(target, announcement)
