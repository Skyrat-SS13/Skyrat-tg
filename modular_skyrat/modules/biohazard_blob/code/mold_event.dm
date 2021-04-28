/datum/round_event_control/mold
	name = "Moldies"
	typepath = /datum/round_event/mold
	weight = 15
	max_occurrences = 3
	min_players = 10

/datum/round_event/mold
	fakeable = FALSE
	var/list/available_molds = list(
		/obj/structure/biohazard_blob/structure/core/fungus,
		/obj/structure/biohazard_blob/structure/core/fire,
		/obj/structure/biohazard_blob/structure/core/emp,
		/obj/structure/biohazard_blob/structure/core/toxic
	)

/datum/round_event/mold/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	var/molds2spawn = rand(2, 3)

	var/obj/structure/biohazard_blob/resin/resintest = new()

	var/list/possible_spawn_areas = typecacheof(typesof(/area/maintenance, /area/security/prison, /area/construction, /area/engineering/atmos))

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

	for(var/i = 1, i <= molds2spawn, i++)
		var/picked_mold = pick(available_molds)

		if(turfs.len) //Pick a turf to spawn at if we can
			shuffle(turfs)
			var/good_turf = FALSE
			var/turf/T
			while(!good_turf && turfs.len)
				var/turf/turf_temp = pick(turfs)
				if(locate(/obj/structure/biohazard_blob/structure/core) in range(10, T))
					turfs -= T
				else
					good_turf = TRUE
					T = turf_temp
					break
			if(!T)
				message_admins("Mold failed to spawn due to the lack of a safe area.")
				return
			var/obj/structure/biohazard_blob/boob = new picked_mold(T)
			announce_to_ghosts(boob)
			turfs -= T
