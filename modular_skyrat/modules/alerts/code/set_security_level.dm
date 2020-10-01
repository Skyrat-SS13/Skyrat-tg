/proc/set_security_level_skyrat(level)
	switch(level)
		if(SEC_LEVEL_BLUE)
			sound_to_playing_players('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg', volume = 50)
		if(SEC_LEVEL_RED)
			sound_to_playing_players('modular_skyrat/modules/alerts/sound/misc/tas_red_alert.ogg', volume = 50)
		if(SEC_LEVEL_DELTA)
			sound_to_playing_players('modular_skyrat/modules/alerts/sound/misc/deltaklaxon.ogg')
		else
			return
