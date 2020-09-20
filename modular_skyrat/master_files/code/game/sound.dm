/proc/playsound_skyrat(atom/source, soundin, vol as num, vary, extrarange as num, falloff, frequency = null, channel = 0, pressure_affected = TRUE, ignore_walls = TRUE, soundenvwet = -10000, soundenvdry = 0)
	if(isarea(source))
		CRASH("playsound(): source is an area")

	var/turf/turf_source = get_turf(source)

	if (!turf_source)
		return

	//allocate a channel if necessary now so its the same for everyone
	channel = channel || SSsounds.random_available_channel()

 	// Looping through the player list has the added bonus of working for mobs inside containers
	var/sound/S = sound(get_sfx(soundin))
	var/maxdistance = (world.view + extrarange)
	var/z = turf_source.z
	var/list/listeners = SSmobs.clients_by_zlevel[z].Copy() //Skyrat change
	if(!ignore_walls) //these sounds don't carry through walls
		listeners = listeners & hearers(maxdistance,turf_source)
	for(var/P in listeners)
		var/mob/M = P
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local_skyrat(turf_source, soundin, vol, vary, frequency, falloff, channel, pressure_affected, S, soundenvwet, soundenvdry)
	for(var/P in SSmobs.dead_players_by_zlevel[z])
		var/mob/M = P
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local_skyrat(turf_source, soundin, vol, vary, frequency, falloff, channel, pressure_affected, S, soundenvwet, soundenvdry)

/mob/proc/playsound_local_skyrat(turf/turf_source, soundin, vol as num, vary, frequency, falloff, channel = 0, pressure_affected = TRUE, sound/S, envwet = -10000, envdry = 0, manual_x, manual_y, distance_multiplier = 1)
	/*
	if(audiovisual_redirect)
		var/turf/T = get_turf(src)
		audiovisual_redirect.playsound_local_skyrat(turf_source, soundin, vol, vary, frequency, falloff, channel, pressure_affected, S, 0, -1000, turf_source.x - T.x, turf_source.y - T.y, distance_multiplier)
	*/
	if(!client || !can_hear())
		return

	if(!S)
		S = sound(get_sfx(soundin))

	S.wait = 0 //No queue
	S.channel = channel || SSsounds.random_available_channel()
	S.volume = vol
	S.environment = 7

	if(vary)
		if(frequency)
			S.frequency = frequency
		else
			S.frequency = get_rand_frequency()

	if(isturf(turf_source))
		var/turf/T = get_turf(src)

		//sound volume falloff with distance
		var/distance = 0
		if(!manual_x && !manual_y)
			distance = get_dist(T, turf_source)

		distance *= distance_multiplier

		S.volume -= max(distance - world.view, 0) * 2 //multiplicative falloff to add on top of natural audio falloff.

		if(pressure_affected)
			//Atmosphere affects sound
			var/pressure_factor = 1
			var/datum/gas_mixture/hearer_env = T.return_air()
			var/datum/gas_mixture/source_env = turf_source.return_air()

			if(hearer_env && source_env)
				var/pressure = min(hearer_env.return_pressure(), source_env.return_pressure())
				if(pressure < ONE_ATMOSPHERE)
					pressure_factor = max((pressure - SOUND_MINIMUM_PRESSURE)/(ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)
			else //space
				pressure_factor = 0

			S.echo = list(envdry, null, envwet, null, null, null, null, null, null, null, null, null, null, 1, 1, 1, null, null)

			if(distance <= 1)
				pressure_factor = max(pressure_factor, 0.15) //touching the source of the sound

			S.volume *= pressure_factor
			//End Atmosphere affecting sound

		if(S.volume <= 0)
			return //No sound

		var/dx = 0 // Hearing from the right/left
		if(!manual_x)
			dx = turf_source.x - T.x
		else
			dx = manual_x
		S.x = dx * distance_multiplier
		var/dz = 0 // Hearing from infront/behind
		if(!manual_x)
			dz = turf_source.y - T.y
		else
			dz = manual_y
		S.z = dz * distance_multiplier
		// The y value is for above your head, but there is no ceiling in 2d spessmens.
		S.y = 1
		S.falloff = (falloff ? falloff : FALLOFF_SOUNDS)

	SEND_SOUND(src, S)
