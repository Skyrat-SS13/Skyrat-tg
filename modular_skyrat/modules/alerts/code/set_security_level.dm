/proc/set_security_level_skyrat(level)
	switch(level)
		if(SEC_LEVEL_BLUE)
			alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg', volume = 50)
		if(SEC_LEVEL_RED)
			alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/tas_red_alert.ogg', volume = 50)
		if(SEC_LEVEL_DELTA)
			alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/deltaklaxon.ogg')
		else
			return

/proc/alert_sound_to_playing(soundin, volume = 100, vary = FALSE, frequency = 0, falloff = FALSE, channel = 0, pressure_affected = FALSE, sound/S)
	if(!S)
		S = sound(get_sfx(soundin))
	for(var/m in GLOB.player_list)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				M.playsound_local(M, null, volume, vary, frequency, falloff, channel, pressure_affected, S)
