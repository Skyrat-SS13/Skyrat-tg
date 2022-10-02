/datum/round_event_control/fleshmind
	name = "Fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 0
	min_players = 100
	earliest_start = 1 HOURS

/datum/round_event/fleshmind
	fakeable = TRUE
	announce_when = 200
	end_when = 201

/datum/round_event/fleshmind/announce(fake)
	priority_announce("Confirmed outbreak of level $£%!£ biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_AIMALF)

/datum/round_event/fleshmind/start()
	make_core()

/datum/round_event/fleshmind/proc/make_core()

	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	var/obj/structure/biohazard_blob/resin/resintest = new()

	var/list/possible_spawn_areas = typecacheof(typesof(/area/station/maintenance, /area/station/security/prison, /area/station/construction))

	for(var/area/iterating_area in world)
		if(!is_station_level(iterating_area.z))
			continue
		if(!is_type_in_typecache(iterating_area, possible_spawn_areas))
			continue
		for(var/turf/open/floor in iterating_area)
			if(!floor.Enter(resintest))
				continue
			if(locate(/turf/closed) in range(2, floor))
				continue
			turfs += floor

	qdel(resintest)

	shuffle(turfs)
	var/turf/picked_turf = pick(turfs)
	if(!picked_turf)
		message_admins("Fleshmind failed to spawn.")
		return
	var/obj/structure/fleshmind/structure/core/new_core = new(picked_turf)
	announce_to_ghosts(new_core)


