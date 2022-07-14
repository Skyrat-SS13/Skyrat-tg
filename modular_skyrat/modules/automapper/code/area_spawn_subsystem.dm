SUBSYSTEM_DEF(area_spawn)
	name = "Area Spawn"
	flags = SS_NO_FIRE

	// Can't be on tile or a neighbor.
	// Usually things where it's important to be sure the players can walk up to them, but aren't dense.
	var/list/restricted_objects_list = list(
		/obj/machinery/recharge_station,
		/obj/machinery/disposal/bin,
		/obj/structure/table,
		/obj/machinery/door,
		/obj/structure/closet,
		/obj/structure/stairs,
	)

	// Only Blacklist if on same tile because looks bad, etc, but doesn't need to be reached.
	var/list/restricted_overlap_objects_list = list(
		/obj/item/kirbyplants,
	)

	// Things here in some way act as walls. This is the result of extensive tweaking.
	var/list/allowed_diagonal_objects_list = list(
		/obj/structure/grille,
		/obj/structure/window,
		/obj/machinery/door,
	)

	var/list/datum/area_turf_info/area_turf_cache = list()

/datum/controller/subsystem/area_spawn/Initialize(start_timeofday)
	for(var/iterating_type in subtypesof(/datum/area_spawn))
		var/datum/area_spawn/iterating_area_spawn = new iterating_type
		iterating_area_spawn.try_spawn()
	clear_cache()
	return ..()

/**
 * Clear the cached tiles for optimization or debugging purposes.
 */
/datum/controller/subsystem/area_spawn/proc/clear_cache()
	for(var/datum/cache in area_turf_cache)
		qdel(cache)
	LAZYCLEARLIST(area_turf_cache)

/**
 * Process the geometry of an area and cache the candidates.
 *
 * Returns turf candidate list. "[priority]" =
 *
 * Arguments:
 * * area - the area to process
 * * wall_hug - Are we processing for wall_hug case or not?
 */
/datum/controller/subsystem/area_spawn/proc/get_turf_candidates(area/area, wall_hug)
	// Get area cache or make a new one.
	var/datum/area_turf_info/area_turf_info
	if(!area_turf_cache[area.type])
		area_turf_info = area_turf_cache[area.type] = new /datum/area_turf_info()
	else
		area_turf_info = area_turf_cache[area.type]

	// Different use cases have different lists of turfs.
	// Get or create the cached list.
	var/list/turf_list
	if(wall_hug)
		if(area_turf_info.available_wall_turfs)
			return area_turf_info.available_wall_turfs
		turf_list = area_turf_info.available_wall_turfs = list()
	else
		if(area_turf_info.available_open_turfs)
			return area_turf_info.available_open_turfs
		turf_list = area_turf_info.available_open_turfs = list()

	// Get highest priority items
	for(var/turf/iterating_turf in area)
		// Only retain turfs of the highest priority
		var/priority = process_turf(iterating_turf, wall_hug)
		if(priority > 0)
			LAZYADDASSOC(turf_list, "[priority]", list(iterating_turf))

	// Sort the priorities descending
	return sortTim(turf_list, /proc/cmp_num_string_asc)

/**
 * Process a specific turf and return priority number from 0 to infinity.
 *
 * Turfs with highest priority will be picked. Priority 0 means NEVER.
 *
 * Arguments:
 * * turf - The turf to process
 * * wall_hug - Are we processing for wall_hug case or not?
 */
/datum/controller/subsystem/area_spawn/proc/process_turf(turf/turf, wall_hug)
	// Only spawn on actual floors
	if(!isfloorturf(turf))
		return 0

	// Turf completely empty?
	var/totally_empty = TRUE
	for(var/atom/movable/found_movable in turf)
		// Same tile conditions for no-go
		if(
			found_movable.density \
			|| is_type_in_list(found_movable, restricted_objects_list) \
			|| is_type_in_list(found_movable, restricted_overlap_objects_list)
		)
			return 0
		if(found_movable.layer > LOW_OBJ_LAYER && found_movable.layer < ABOVE_MOB_LAYER)
			totally_empty = FALSE

	// Number of directions that have a closed wall
	var/num_walls_found = 0
	// Found a dense object?
	var/found_dense_object = FALSE
	// Number of directions that have anything dense
	var/num_dense_found = 0
	// Number of directions that have 2 squares of open space.
	var/num_very_open_floors = 0
	for(var/dir in GLOB.cardinals)
		var/turf/neighbor_turf = get_step(turf, dir)
		if(isclosedturf(neighbor_turf))
			num_walls_found++
			num_dense_found++
			continue
		if(wall_hug)
			var/turf/long_test_turf = get_step(neighbor_turf, dir)
			if(isopenturf(long_test_turf))
				num_very_open_floors++
		for(var/atom/movable/found_movable in neighbor_turf)
			if(found_movable.density || is_type_in_list(found_movable, restricted_objects_list))
				found_dense_object = TRUE
				num_dense_found++
				break

	// Wall hugging also, as a low priority, doesn't even want diagnal things
	var/num_diagonal_objects = 0
	if(wall_hug)
		for(var/dir in GLOB.diagonals)
			var/turf/neighbor_turf = get_step(turf, dir)
			for(var/atom/movable/found_movable in neighbor_turf)
				if(
					!is_type_in_list(found_movable, allowed_diagonal_objects_list) \
					&& (found_movable.density || is_type_in_list(found_movable, restricted_objects_list))
				)
					num_diagonal_objects++
					break

	if(wall_hug)
		// For wall hugging, must be against wall, and not touching another dense object as it may completely block it.
		if(num_walls_found == 0 || found_dense_object || num_walls_found == 4)
			return 0

		// #1 Priority after that: be in a totally empty square
		// #2 favor being in a cozy wall nook
		// #3 (marginally) have clear diagnals
		// #4 be in a big room/hallway so we don't pinch a room down to 1 square of passage.
		return (totally_empty ? 1000 : 0) + (400 - num_diagonal_objects * 100) + (num_walls_found * 10) + num_very_open_floors

	// For non-wall hug
	// #1 priority is totally empty
	// #2 priority is being in the middle of the room
	return (totally_empty ? 10 : 0) + (4 - num_dense_found)

/**
 * Pick a turf candidate and remove from the list.
 *
 * Only picks one of the highest priority ones.
 *
 * Arguments:
 * * turf_candidates - Turf candidate list produced by
 */
/datum/controller/subsystem/area_spawn/proc/pick_turf_candidate(list/list/turf/turf_candidates)
	// Pick-n-take highest priority.
	var/list/turf/sublist = turf_candidates[peek(turf_candidates)]
	var/turf/winner = pick_n_take(sublist)

	// To be safe, remove the neighbors too.
	for(var/dir in GLOB.cardinals)
		var/turf/neighbor = get_step(winner, dir)
		sublist -= neighbor

	// Remove this priority if it's now empty.
	if(!LAZYLEN(sublist))
		pop(turf_candidates)

	// Extremely specific, but landmarks are immediately destroyed when created so can't be detected another way.
	// This is the only landmark list that normally creates solid objects in non-maintenance spaces.
	GLOB.secequipment -= winner

	return winner

/**
 * Turf into for a given area
 */
/datum/area_turf_info
	/// Turfs in the middle of the room
	var/list/list/turf/available_open_turfs
	/// Turfs hugging the wall
	var/list/list/turf/available_wall_turfs

/**
 * Area spawn datums
 *
 * Use these to spawn atoms in areas instead of placing them on a map. It will select any available open and entering turf.
 */
/datum/area_spawn
	/// The target area for us to spawn the desired atom, the list is formatted, highest priority first.
	var/list/target_areas
	/// The atom that we want to spawn
	var/desired_atom
	/// The amount we want to spawn
	var/amount_to_spawn = 1
	/// Do we need to be adjacent to a wall? This also checks the other 3 cardinals for no density. Generally useful for objects with density and anchored.
	var/wall_hug = FALSE
	/// Map blacklist, this is used to determine what maps we should not spawn on.
	var/list/blacklisted_stations = list("Blueshift", "Runtime Station", "MultiZ Debug")

/**
 * Attempts to find a location using an algorithm to spawn the desired atom.
 */
/datum/area_spawn/proc/try_spawn()
	if(SSmapping.config.map_name in blacklisted_stations)
		return

	// Turfs that are available
	var/list/available_turfs

	for(var/area_type in target_areas)
		var/area/found_area = GLOB.areas_by_type[area_type]
		if(!found_area)
			continue
		available_turfs = SSarea_spawn.get_turf_candidates(found_area, wall_hug)
		if(LAZYLEN(available_turfs))
			break

	if(!LAZYLEN(available_turfs))
		CRASH("[src.type] could not find any suitable turfs on map [SSmapping.config.map_name]!")

	for(var/i in 1 to amount_to_spawn)
		new desired_atom(SSarea_spawn.pick_turf_candidate(available_turfs))

/obj/effect/turf_test
	name = "PASS"
	icon = 'modular_skyrat/modules/automapper/icons/area_test.dmi'
	icon_state = "area_test"
	color = COLOR_RED
	anchored = TRUE

/obj/effect/turf_test/wall
	color = COLOR_BLUE
	maptext_y = 16

/**
 * Show overlay over area of priorities. Wall priority over open priority.
 */
/client/proc/test_area_spawner(area/area)
	set category = "Debug"
	set name = "Test Area Spawner"
	set desc = "Show area spawner placement candidates as an overlay."

	for(var/obj/effect/turf_test/old_test in area)
		qdel(old_test)

	SSarea_spawn.clear_cache()
	var/list/list/turf/open_candidates = SSarea_spawn.get_turf_candidates(area, FALSE)
	var/list/list/turf/wall_candidates = SSarea_spawn.get_turf_candidates(area, TRUE)

	for(var/priority in open_candidates)
		var/list/turf/turfs = open_candidates[priority]
		for(var/turf/turf as anything in turfs)
			var/obj/overlay = new /obj/effect/turf_test(turf)
			overlay.maptext = MAPTEXT(priority)

	for(var/priority in wall_candidates)
		var/list/turf/turfs = wall_candidates[priority]
		for(var/turf/turf as anything in turfs)
			var/obj/overlay = new /obj/effect/turf_test/wall(turf)
			overlay.maptext = MAPTEXT(priority)
