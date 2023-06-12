#define MOLDIES_SPAWN_LOWPOP_MIN 1
#define MOLDIES_SPAWN_LOWPOP_MAX 1
#define MOLDIES_SPAWN_HIGHPOP_MIN 1
#define MOLDIES_SPAWN_HIGHPOP_MAX 2
#define MOLDIES_LOWPOP_THRESHOLD 45
#define MOLDIES_MIDPOP_THRESHOLD 75
#define MOLDIES_HIGHPOP_THRESHOLD 115

/datum/round_event_control/mold
	name = "Moldies"
	typepath = /datum/round_event/mold
	weight = 5
	max_occurrences = 1
	earliest_start = 30 MINUTES
	min_players = MOLDIES_LOWPOP_THRESHOLD
	category = EVENT_CATEGORY_ENTITIES

/datum/round_event/mold
	fakeable = FALSE
	var/list/available_molds_t1 = list(
		/obj/structure/biohazard_blob/structure/core/fire,
		/obj/structure/biohazard_blob/structure/core/emp,
		/obj/structure/biohazard_blob/structure/core/radioactive,
	)
	var/list/available_molds_t2 = list(
		/obj/structure/biohazard_blob/structure/core/fire,
		/obj/structure/biohazard_blob/structure/core/fungus,
		/obj/structure/biohazard_blob/structure/core/radioactive,
		/obj/structure/biohazard_blob/structure/core/emp,
	)

/datum/round_event/mold
	announce_when = 120 // 4 minutes
	announce_chance = 0

/datum/round_event/mold/announce(fake)
	if(!fake)
		INVOKE_ASYNC(SSsecurity_level, TYPE_PROC_REF(/datum/controller/subsystem/security_level/, minimum_security_level), SEC_LEVEL_VIOLET, FALSE, FALSE)
	priority_announce("Confirmed outbreak of level 6 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_OUTBREAK6)

/datum/round_event/mold/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas
	var/mold_spawns = MOLDIES_SPAWN_LOWPOP_MIN
	var/active_players = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = FALSE)

	if(active_players > MOLDIES_HIGHPOP_THRESHOLD)
		mold_spawns = MOLDIES_SPAWN_HIGHPOP_MAX

	else if(active_players >= MOLDIES_MIDPOP_THRESHOLD && prob((active_players - MOLDIES_MIDPOP_THRESHOLD) * (100 / (MOLDIES_HIGHPOP_THRESHOLD - MOLDIES_MIDPOP_THRESHOLD))))
		mold_spawns = MOLDIES_SPAWN_HIGHPOP_MAX

	else if(active_players < MOLDIES_MIDPOP_THRESHOLD && prob((active_players - MOLDIES_LOWPOP_THRESHOLD) * (100 / (MOLDIES_MIDPOP_THRESHOLD - MOLDIES_LOWPOP_THRESHOLD))))
		mold_spawns = MOLDIES_SPAWN_LOWPOP_MAX

	var/obj/structure/biohazard_blob/resin/resin_test = new()

	var/list/possible_spawn_areas = typecacheof(typesof(/area/station/maintenance, /area/station/security/prison, /area/station/construction))

	for(var/area/A as anything in GLOB.areas)
		if(!is_station_level(A.z))
			continue
		if(!is_type_in_typecache(A, possible_spawn_areas))
			continue
		for(var/turf/open/floor in A.get_contained_turfs())
			if(!floor.Enter(resin_test))
				continue
			if(locate(/turf/closed) in range(2, floor))
				continue
			turfs += floor

	qdel(resin_test)

	for(var/i in 1 to mold_spawns)
		var/picked_mold
		if(active_players >= MOLDIES_MIDPOP_THRESHOLD)
			picked_mold = pick(available_molds_t2)
		else
			picked_mold = pick(available_molds_t1)
		shuffle(turfs)
		var/turf/picked_turf = pick(turfs)
		if(turfs.len) //Pick a turf to spawn at if we can
			if(locate(/obj/structure/biohazard_blob/structure/core) in range(20, picked_turf))
				turfs -= picked_turf
				continue
			if(istype(picked_mold, /obj/structure/biohazard_blob/structure/core/fungus))
				announce_chance = 100
			var/obj/structure/biohazard_blob/blob = new picked_mold(picked_turf)
			announce_to_ghosts(blob)
			turfs -= picked_turf
			i++
		else
			log_game("Event: Moldies failed to spawn.")
			message_admins("Moldies failed to spawn.")
			break

#undef MOLDIES_SPAWN_LOWPOP_MIN
#undef MOLDIES_SPAWN_LOWPOP_MAX
#undef MOLDIES_SPAWN_HIGHPOP_MIN
#undef MOLDIES_SPAWN_HIGHPOP_MAX
#undef MOLDIES_LOWPOP_THRESHOLD
#undef MOLDIES_MIDPOP_THRESHOLD
#undef MOLDIES_HIGHPOP_THRESHOLD
