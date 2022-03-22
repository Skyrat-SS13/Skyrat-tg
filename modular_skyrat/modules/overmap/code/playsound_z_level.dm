/proc/playsound_z_level(affected_z, sound_in, volume = 100, hearing_check = FALSE, prefs)
	var/sound/processed_sound = sound(get_sfx(sound_in))
	processed_sound.volume = volume
	for(var/mob/iterating_mob in GLOB.player_list)
		if(!iterating_mob)
			continue
		if(!iterating_mob?.client)
			continue
		if(iterating_mob?.z != affected_z)
			continue
		if(prefs && !(iterating_mob?.client?.prefs?.toggles & prefs))
			continue
		if(hearing_check && !iterating_mob?.can_hear())
			continue
		SEND_SOUND(iterating_mob, processed_sound)
