///This is quite franlky the most important proc relating to global sounds, it uses area definition to play sounds depending on your location, and respects the players announcement volume. Generally if you're sending an announcement you want to use priority_announce.
/proc/alert_sound_to_playing(soundin, vary = FALSE, frequency = 0, falloff = FALSE, channel = 0, pressure_affected = FALSE, sound/S, override_volume = FALSE, list/players)
	if(!S)
		S = sound(get_sfx(soundin))
	var/static/list/quiet_areas = typecacheof(typesof(/area/station/maintenance) + typesof(/area/space) + typesof(/area/station/commons/dorms))
	if(!players)
		players = GLOB.player_list
	for(var/m in players)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			if(M.client?.prefs.read_preference(/datum/preference/toggle/sound_announcements) && M.can_hear())
				if(override_volume)
					M.playsound_local(get_turf(M), S, 80, FALSE)
				else
					var/area/A = get_area(M)
					if(is_type_in_typecache(A, quiet_areas)) //These areas don't hear it as loudly
						M.playsound_local(get_turf(M), S, 10, FALSE)
					else
						M.playsound_local(get_turf(M), S, 70, FALSE)
