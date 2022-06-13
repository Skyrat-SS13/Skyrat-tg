/datum/round_event_control/fleshmind
	name = "Fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 0
	min_players = 100
	earliest_start = 1 HOURS


/datum/round_event/fleshmind
	fakeable = TRUE
	announceWhen = 200
	endWhen = 200
	var/list/possible_mob_conversions = list(
		/mob/living/simple_animal/hostile/fleshmind/globber,
		/mob/living/simple_animal/hostile/fleshmind/slicer,
		/mob/living/simple_animal/hostile/fleshmind/stunner,
		/mob/living/simple_animal/hostile/fleshmind/floater,
	)
	/// Has our core been made?
	var/core_made = FALSE

/datum/round_event/fleshmind/announce(fake)
	priority_announce("Confirmed outbreak of level $£%!£ biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_AIMALF)

/datum/round_event/fleshmind/tick()
	if(prob(FLESHMIND_EVENT_MAKE_CORRUPTION_CHANCE))
		var/obj/machinery/picked_machinery = pick(GLOB.machines)
		picked_machinery.AddComponent(/datum/component/machine_corruption)
		announce_to_ghosts(picked_machinery)

	if(prob(FLESHMIND_EVENT_MAKE_CORRUPT_MOB))
		for(var/mob/living/simple_animal/iterating_simple_animal in GLOB.mob_living_list)
			if(iterating_simple_animal.key || iterating_simple_animal.mind || is_station_level(iterating_simple_animal.z))
				continue
			var/picked_mob_type = pick(possible_mob_conversions)
			var/mob/living/new_mob = new picked_mob_type(get_turf(iterating_simple_animal))
			announce_to_ghosts(new_mob)
			qdel(iterating_simple_animal)
			break

	if(activeFor > 100 && !core_made)
		make_core()
		core_made = TRUE



/datum/round_event/fleshmind/proc/make_core()

	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	var/obj/structure/biohazard_blob/resin/resintest = new()

	var/list/possible_spawn_areas = typecacheof(typesof(/area/station/maintenance, /area/station/security/prison, /area/station/construction, /area/station/engineering/atmos))

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


