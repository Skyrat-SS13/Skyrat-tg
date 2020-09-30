/set_security_level(level)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("delta")
			level = SEC_LEVEL_DELTA

	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != GLOB.security_level)
		switch(level)
			if(SEC_LEVEL_BLUE)
				sound_to_playing_players('modular_skyrat/modules/alerts/sound/misc/notice1.ogg', volume = 50)
			if(SEC_LEVEL_RED)
				sound_to_playing_players('modular_skyrat/modules/alerts/sound/misc/redalert1.ogg', volume = 50)
			if(SEC_LEVEL_DELTA)
				sound_to_playing_players('modular_skyrat/modules/alerts/sound/misc/deltaklaxon.ogg')
	. = ..()
