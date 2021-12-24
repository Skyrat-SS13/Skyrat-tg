/proc/playsound_z_level(affected_z, sound_in, volume = 100)
	var/sound/processed_sound = get_sfx(sound_in)
	processed_sound.volume = volume
	for(var/mob/iterating_mob in GLOB.player_list)
		if(!iterating_mob)
			continue
		if(!iterating_mob?.client)
			continue
		if(iterating_mob?.z != affected_z)
			continue
		if(iterating_mob?.client?.prefs?.toggles & SOUND_ANNOUNCEMENTS && iterating_mob?.can_hear())
			SEND_SOUND(iterating_mob, processed_sound)
