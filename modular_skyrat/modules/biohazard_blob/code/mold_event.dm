/datum/round_event_control/mold
	name = "mold"
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

	var/molds2spawn = rand(1, 3)

	for(var/area/maintenance/A in world)
		for(var/turf/open/F in A)
			turfs += F

	for(var/i = 1, i <= molds2spawn, i++)
		var/picked_mold = pick(available_molds)

		if(turfs.len) //Pick a turf to spawn at if we can
			var/turf/T = pick(turfs)
			new picked_mold(T)
			turfs -= T
