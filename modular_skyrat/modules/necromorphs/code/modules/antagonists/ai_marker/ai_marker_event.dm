/datum/round_event_control/ai_marker
	name = "Necromorph Outbreak"
	typepath = /datum/round_event/ai_marker
	weight = 5
	max_occurrences = 1
	min_players = 10

/datum/round_event/ai_marker
	fakeable = FALSE
	var/list/available_molds_t1 = list(
		/obj/structure/corruption/structure/core
	)
	var/list/available_molds_t2 = list(
		/obj/structure/corruption/structure/core

	)

/datum/round_event/ai_marker/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas
	var/molds2spawn
	if(get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE) >= 60)
		molds2spawn	= 2 //Guaranteedly worse
	else
		molds2spawn = rand(1,2)

	var/obj/structure/corruption/resin/resintest = new()

	var/list/possible_spawn_areas = typecacheof(typesof(/area/maintenance, /area/security/prison, /area/construction))

	for(var/area/A in world)
		if(!is_station_level(A.z))
			continue
		if(!is_type_in_typecache(A, possible_spawn_areas))
			continue
		for(var/turf/open/floor in A)
			if(!floor.Enter(resintest))
				continue
			if(locate(/turf/closed) in range(2, floor))
				continue
			turfs += floor

	qdel(resintest)

	for(var/i = 1, i <= molds2spawn)
		var/picked_mold
		if(get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE) >= 60)
			picked_mold = pick(available_molds_t2)
		else
			picked_mold = pick(available_molds_t1)
		shuffle(turfs)
		var/turf/picked_turf = pick(turfs)
		if(turfs.len) //Pick a turf to spawn at if we can
			if(locate(/obj/structure/corruption/structure/core) in range(20, picked_turf))
				turfs -= picked_turf
				continue
			var/obj/structure/corruption/boob = new picked_mold(picked_turf)
			announce_to_ghosts(boob)
			turfs -= picked_turf
			i++
		else
			message_admins("Mold failed to spawn.")
			break
