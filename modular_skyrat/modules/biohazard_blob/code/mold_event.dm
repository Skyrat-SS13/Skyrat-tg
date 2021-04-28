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

	for(var/area/maintenance/A in world)
		for(var/turf/open/floor in A)
			if(!floor.Enter(resintest))
				continue
			if(locate(/turf/closed) in range(3, floor))
				continue
			turfs += floor

	qdel(resintest)

	for(var/i = 1, i <= molds2spawn, i++)
		var/picked_mold = pick(available_molds)

		if(turfs.len) //Pick a turf to spawn at if we can
			var/turf/T = pick(turfs)
			var/obj/structure/biohazard_blob/boob = new picked_mold(T)
			announce_to_ghosts(boob)
			turfs -= T
