#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDOUT 2
#define SHELLEO_STDERR 3

#define COOLDOWN_LOCAL_INTERNET_SOUND "local_internet_sound"

///Takes an input from either proc/play_web_sound or the request manager and runs it through youtube-dl and prompts the user before playing it to the server.
/proc/localweb_sound(mob/user, input, credit, range = null)
	if(!check_rights(R_SOUND))
		return
	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		to_chat(user, span_boldwarning("Youtube-dl was not configured, action unavailable"), confidential = TRUE) //Check config.txt for the INVOKE_YOUTUBEDL value
		return
	var/localweb_sound_url = ""
	var/stop_localweb_sounds = FALSE
	var/list/music_extra_data = list()
	var/duration = 0
	if(istext(input))
		var/shell_scrubbed_input = shell_url_scrub(input)
		var/list/output = world.shelleo("[ytdl] --geo-bypass --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height <= 360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[shell_scrubbed_input]\"")
		var/errorlevel = output[SHELLEO_ERRORLEVEL]
		var/stdout = output[SHELLEO_STDOUT]
		var/stderr = output[SHELLEO_STDERR]
		if(errorlevel)
			to_chat(user, span_boldwarning("Youtube-dl URL retrieval FAILED:"), confidential = TRUE)
			to_chat(user, span_warning("[stderr]"), confidential = TRUE)
			return
		var/list/data
		try
			data = json_decode(stdout)
		catch(var/exception/e)
			to_chat(user, span_boldwarning("Youtube-dl JSON parsing FAILED:"), confidential = TRUE)
			to_chat(user, span_warning("[e]: [stdout]"), confidential = TRUE)
			return
		if (data["url"])
			localweb_sound_url = data["url"]
		var/title = "[data["title"]]"
		var/webpage_url = title
		if (data["webpage_url"])
			webpage_url = "<a href=\"[data["webpage_url"]]\">[title]</a>"
		music_extra_data["duration"] = DisplayTimeText(data["duration"] * 1 SECONDS)
		music_extra_data["link"] = data["webpage_url"]
		music_extra_data["artist"] = data["artist"]
		music_extra_data["upload_date"] = data["upload_date"]
		music_extra_data["album"] = data["album"]
		duration = data["duration"] * 1 SECONDS
		if (duration > 10 MINUTES)
			if((tgui_alert(user, "This song is over 10 minutes long. Are you sure you want to play it?", "Length Warning!", list("No", "Yes", "Cancel")) != "Yes"))
				return
		var/res = tgui_alert(user, "Show the title of and link to this song to the players?\n[title]", "Show Info?", list("Yes", "No", "Cancel"))
		switch(res)
			if("Yes")
				music_extra_data["title"] = data["title"]
			if("No")
				music_extra_data["link"] = "Song Link Hidden"
				music_extra_data["title"] = "Song Title Hidden"
				music_extra_data["artist"] = "Song Artist Hidden"
				music_extra_data["upload_date"] = "Song Upload Date Hidden"
				music_extra_data["album"] = "Song Album Hidden"
			if("Cancel", null)
				return
		var/anon = tgui_alert(user, "Display who played the song?", "Credit Yourself?", list("Yes", "No", "Cancel"))
		switch(anon)
			if("Yes")
				if(res == "Yes")
					to_chat(world, span_boldannounce("[user.key] locally played: [webpage_url]"), confidential = TRUE)
				else
					to_chat(world, span_boldannounce("[user.key] locally played a sound"), confidential = TRUE)
			if("No")
				if(res == "Yes")
					to_chat(world, span_boldannounce("An admin locally played: [webpage_url]"), confidential = TRUE)
			if("Cancel", null)
				return
		if(credit)
			to_chat(world, span_boldannounce(credit), confidential = TRUE)
		SSblackbox.record_feedback("nested tally", "played_url", 1, list("[user.ckey]", "[input]"))
		log_admin("[key_name(user)] played local web sound: [input]")
		message_admins("[key_name(user)] played local web sound: [input]")
	else
		//pressed ok with blank
		log_admin("[key_name(user)] stopped local web sounds.")

		message_admins("[key_name(user)] stopped local web sounds.")
		localweb_sound_url = null
		stop_localweb_sounds = TRUE
	if(localweb_sound_url && !findtext(localweb_sound_url, GLOB.is_http_protocol))
		tgui_alert(user, "The media provider returned a content URL that isn't using the HTTP or HTTPS protocol. This is a security risk and the sound will not be played.", "Security Risk", list("OK"))
		to_chat(user, span_boldwarning("BLOCKED: Content URL not using HTTP(S) Protocol!"), confidential = TRUE)

		return
	if(localweb_sound_url || stop_localweb_sounds)
		var/list/players = GLOB.player_list
		if (range)
			players = list()
			for (var/mob/listening_mob as anything in hearers(range, user))
				if (listening_mob.client)
					players += listening_mob
		for(var/mob/player_mob as anything in players)
			if(player_mob.client.prefs.read_preference(/datum/preference/toggle/sound_midi))
				if(!stop_localweb_sounds)
					player_mob.client.tgui_panel?.play_music(localweb_sound_url, music_extra_data)
				else
					player_mob.client.tgui_panel?.stop_music()

	S_TIMER_COOLDOWN_START(SStimer, COOLDOWN_LOCAL_INTERNET_SOUND, duration)

	BLACKBOX_LOG_ADMIN_VERB("Play Local Internet Sound")

ADMIN_VERB(play_localweb_sound, R_SOUND, "Play Local Internet Sound", "Play a given internet sound players within specified range.", ADMIN_CATEGORY_FUN)
	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		to_chat(src, span_boldwarning("Youtube-dl was not configured, action unavailable"), confidential = TRUE) //Check config.txt for the INVOKE_YOUTUBEDL value
		return

	if(S_TIMER_COOLDOWN_TIMELEFT(SStimer, COOLDOWN_LOCAL_INTERNET_SOUND))
		if(tgui_alert(usr, "Someone else is already playing an Internet sound! It has [DisplayTimeText(S_TIMER_COOLDOWN_TIMELEFT(SStimer, COOLDOWN_LOCAL_INTERNET_SOUND), 1)] remaining. \
		Would you like to override?", "Musicalis Interruptus", list("No","Yes")) != "Yes")
			return

	var/web_sound_input = tgui_input_text(usr, "Enter content URL (supported sites only, leave blank to stop playing)", "Play Local Internet Sound", null)

	if(length(web_sound_input))
		web_sound_input = trim(web_sound_input)
		if(findtext(web_sound_input, ":") && !findtext(web_sound_input, GLOB.is_http_protocol))
			to_chat(src, span_boldwarning("Non-http(s) URIs are not allowed."), confidential = TRUE)
			to_chat(src, span_warning("For youtube-dl shortcuts like ytsearch: please use the appropriate full URL from the website."), confidential = TRUE)
			return
		var/number_input = tgui_input_number(usr, "What range would you like to play it in? (leave empty for everyone)", "Play Local Internet Sound", null)
		localweb_sound(usr, web_sound_input, range = number_input)
	else
		localweb_sound(usr, null, null, null)
