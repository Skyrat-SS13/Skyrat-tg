/datum/round_event_control/mold
	name = "mold"
	typepath = /datum/round_event/mold
	weight = 15
	max_occurrences = 3
	min_players = 10
	var/list/available_molds = list(
		/obj/structure/biohazard_blob/structure/core/fungus,
		/obj/structure/biohazard_blob/structure/core/fire,
		/obj/structure/biohazard_blob/structure/core/emp,
		/obj/structure/biohazard_blob/structure/core/toxic
	)

/datum/round_event/mold
	fakeable = FALSE

/datum/round_event/mold/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	for(var/area/maintenance/A in world)
		for(var/turf/open/F in A)
				turfs += F

	var/picked_mold = pick(available_molds)

	if(turfs.len) //Pick a turf to spawn at if we can
		var/turf/T = pick(turfs)
		new picked_mold(T)
