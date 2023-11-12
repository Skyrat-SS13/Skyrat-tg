#define MOLDIES_SPAWN_LOWPOP_MIN 1
#define MOLDIES_SPAWN_LOWPOP_MAX 1
#define MOLDIES_SPAWN_HIGHPOP_MIN 1
#define MOLDIES_SPAWN_HIGHPOP_MAX 2

/datum/round_event_control/mold
	name = "Moldies"
	description = "A mold outbreak on the station. The mold will spread across the station if not contained."
	typepath = /datum/round_event/mold
	max_occurrences = 1
	earliest_start = 30 MINUTES
	min_players = EVENT_LOWPOP_THRESHOLD
	category = EVENT_CATEGORY_ENTITIES

/datum/round_event/mold
	fakeable = FALSE
	announce_when = 120 // 4 minutes
	announce_chance = 0

/datum/round_event/mold/announce(fake)
	if(!fake)
		INVOKE_ASYNC(SSsecurity_level, TYPE_PROC_REF(/datum/controller/subsystem/security_level, minimum_security_level), SEC_LEVEL_VIOLET, FALSE, FALSE)

	priority_announce("Confirmed outbreak of level 6 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_OUTBREAK6)

/datum/round_event/mold/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas
	var/mold_spawns = MOLDIES_SPAWN_LOWPOP_MIN
	var/active_players = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = FALSE)

	if(active_players > EVENT_HIGHPOP_THRESHOLD)
		mold_spawns = MOLDIES_SPAWN_HIGHPOP_MAX

	else if(active_players >= EVENT_MIDPOP_THRESHOLD && prob((active_players - EVENT_MIDPOP_THRESHOLD) * (100 / (EVENT_HIGHPOP_THRESHOLD - EVENT_MIDPOP_THRESHOLD))))
		mold_spawns = MOLDIES_SPAWN_HIGHPOP_MAX

	else if(active_players < EVENT_MIDPOP_THRESHOLD && prob((active_players - EVENT_LOWPOP_THRESHOLD) * (100 / (EVENT_MIDPOP_THRESHOLD - EVENT_LOWPOP_THRESHOLD))))
		mold_spawns = MOLDIES_SPAWN_LOWPOP_MAX

	var/obj/structure/mold/resin/test/test_resin = new()

	var/list/possible_spawn_areas = typecacheof(typesof(/area/station/maintenance, /area/station/security/prison, /area/station/construction))

	for(var/area/checked_area as anything in GLOB.areas)
		if(!is_station_level(checked_area.z))
			continue

		if(!is_type_in_typecache(checked_area, possible_spawn_areas))
			continue

		for(var/turf/open/floor in checked_area.get_contained_turfs())
			if(isopenspaceturf(floor))
				continue

			if(!floor.Enter(test_resin))
				continue

			if(locate(/turf/closed) in range(2, floor))
				continue

			turfs += floor

	qdel(test_resin)

	for(var/i in 1 to mold_spawns)
		var/threat_level = active_players >= EVENT_MIDPOP_THRESHOLD ? MOLD_TIER_HIGH_THREAT : MOLD_TIER_LOW_THREAT
		var/list/possible_mold_types = list()

		for(var/iterated_type in subtypesof(/datum/mold_type))
			var/datum/mold_type/mold_type = new iterated_type()

			if(mold_type.tier <= threat_level)
				possible_mold_types += mold_type

		if(!possible_mold_types)
			log_game("Event: Moldies failed to spawn due to lack of possible types.")
			message_admins("Moldies failed to spawn due to lack of possible types.")
			break

		var/datum/mold_type/picked_type = pick(possible_mold_types)

		shuffle(turfs)
		var/turf/picked_turf = pick(turfs)
		if(length(turfs)) //Pick a turf to spawn at if we can
			if(locate(/obj/structure/mold/structure/core) in range(20, picked_turf))
				turfs -= picked_turf
				continue

			if(picked_type.tier > MOLD_TIER_LOW_THREAT)
				announce_chance = 100

			var/obj/structure/mold/structure/core/new_core = new (picked_turf, picked_type)
			announce_to_ghosts(new_core)
			turfs -= picked_turf
			i++
		else
			log_game("Event: Moldies failed to spawn due to lack of available turfs.")
			message_admins("Moldies failed to spawn due to lack of available turfs.")
			break

#undef MOLDIES_SPAWN_LOWPOP_MIN
#undef MOLDIES_SPAWN_LOWPOP_MAX
#undef MOLDIES_SPAWN_HIGHPOP_MIN
#undef MOLDIES_SPAWN_HIGHPOP_MAX
#undef EVENT_LOWPOP_THRESHOLD
#undef EVENT_MIDPOP_THRESHOLD
#undef EVENT_HIGHPOP_THRESHOLD
