/datum/round_event_control/mold
	name = "Moldies"
	typepath = /datum/round_event/mold
	weight = 5
	max_occurrences = 0 // SKYRAT EDIT - disables moldies until a rework is made - Moldies are unfun, anti-RP, and round ending. It has got to the point where the best way to deal with them is often just wall up the area if they spawn in maint, and decide that it has just been lost. It also loves to spawn in the middle of perma with people around (something blob can't do), which is kind of crap if you had anything going on there. Blob is fine, because they don't spawn in pairs. They provide a more engaging fight for both groups, and don't spawn mobs that use broken/buggy mechanics that end up turning half of the station into an unending smoke cloud. While leaving behind a bunch of weird corpses that reply the death animation whenever they came off/on your screen. Moldies have no benefit, no positive upside, and are all negatives. They have the same reason for being in the game as an event that suddenly gibs everyone on station with no warning. I've heard mention of a possible rework, but until then, they should be disabled to prevent any more round-ruining.
	min_players = 10

/datum/round_event/mold
	fakeable = FALSE
	var/list/available_molds_t1 = list(
		/obj/structure/biohazard_blob/structure/core/fire,
		/obj/structure/biohazard_blob/structure/core/toxic
	)
	var/list/available_molds_t2 = list(
		/obj/structure/biohazard_blob/structure/core/fire,
		/obj/structure/biohazard_blob/structure/core/toxic,
		/obj/structure/biohazard_blob/structure/core/radioactive,
		/obj/structure/biohazard_blob/structure/core/emp,
		/obj/structure/biohazard_blob/structure/core/fungus
	)

/datum/round_event/mold/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas
	var/molds2spawn 
	if(get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE) >= 60)
		molds2spawn	= 2 //Guaranteedly worse
	else
		molds2spawn = rand(1,2)

	var/obj/structure/biohazard_blob/resin/resintest = new()

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
			if(locate(/obj/structure/biohazard_blob/structure/core) in range(20, picked_turf))
				turfs -= picked_turf
				continue
			var/obj/structure/biohazard_blob/boob = new picked_mold(picked_turf)
			announce_to_ghosts(boob)
			turfs -= picked_turf
			i++
		else
			message_admins("Mold failed to spawn.")
			break
