/datum/overmap_sun_system
	/// Name of the sun system
	var/name = "Alpha"
	/// It's x coordinate in the galaxy
	var/x = 0
	/// It's y coordinate in the galaxy
	var/y = 0
	/// All overmap objects that are inside the sunsystem
	var/list/overmap_objects = list()
	/// The simulated Z level
	var/datum/space_level/my_space_level
	/// The z value of the simulated space level, for easier lookup
	var/z_level = 0

	/// The levels are initialised in reserved blocks on the overmap level. Those offsets are this level's starting point
	var/x_offset = 0
	var/y_offset = 0
	/// The furthest x and y in the sun system
	var/maxx = 50
	var/maxy = 50

/datum/overmap_sun_system/proc/IsOutOfBoundsX(passed_x)
	return (passed_x > maxx || passed_x < 1)

/datum/overmap_sun_system/proc/IsOutOfBoundsY(passed_y)
	return (passed_y > maxy || passed_y < 1)

/datum/overmap_sun_system/proc/CoordsHaveHazard(passed_x, passed_y)
	var/list/objects_to_consider = GetObjectsOnCoords(passed_x, passed_y)
	for(var/i in objects_to_consider)
		if(istype(i, /datum/overmap_object/hazard))
			return TRUE
	return FALSE

//used by mapping to determine where to place planets, stations, ruins and such
/datum/overmap_sun_system/proc/GetEmptySpotForZLevelObjectWithinRange(lowx,highx,lowy,highy)
	return

/datum/overmap_sun_system/proc/CoordsClearHazard(passed_x, passed_y)
	var/list/objects_to_consider = GetObjectsOnCoords(passed_x, passed_y)
	for(var/i in objects_to_consider)
		if(istype(i, /datum/overmap_object/hazard))
			var/datum/overmap_object/hazard/our_hazard = i
			qdel(our_hazard)

/datum/overmap_sun_system/proc/GetObjectsOnCoords(passed_x, passed_y)
	if(passed_x > maxx || passed_y > maxy)
		CRASH("Attempted to get objects outside of the sun system")
	var/list/returned_list = list()
	var/turf/located = locate(passed_x + x_offset, passed_y + y_offset, z_level)
	for(var/obj/effect/abstract/overmap/overmap_visual in located.contents)
		if(!overmap_visual)
			continue
		returned_list += overmap_visual.my_overmap_object
	return returned_list

/datum/overmap_sun_system/proc/GetVisualX(passed_x)
	return x_offset + passed_x

/datum/overmap_sun_system/proc/GetVisualY(passed_y)
	return y_offset + passed_y

/datum/overmap_sun_system/proc/GetObjectsInRadius(_x,_y,rad)
	. = list()
	for(var/i in overmap_objects)
		var/datum/overmap_object/OO = i
		if(OO.x <= _x + rad && OO.x >= _x - rad && OO.y <= _y + rad && OO.y >= _y - rad)
			. += OO

/datum/overmap_sun_system/proc/ObjectsAdjacent(datum/overmap_object/object_one, datum/overmap_object/object_two)
	if(object_one.x <= object_two.x + 1 && object_one.x >= object_two.x - 1 && object_one.y <= object_two.y + 1 && object_one.y >= object_two.y - 1)
		return TRUE
	return FALSE

/datum/overmap_sun_system/New(datum/space_level/passed_level)
	my_space_level = passed_level
	z_level = my_space_level.z_value
	//Initialize the turfs
	var/list/transportables_loot_list = TRANSPORTABLE_LOOT_TABLE
	for(var/iterated_x in 1 to maxx+1)
		for(var/iterated_y in 1 to maxy+1)
			var/turf/located = locate(iterated_x + x_offset, iterated_y + y_offset, z_level)
			if(!located)
				WARNING("Sun system generation could not find a turf")
			//Place a corner turf
			if(iterated_x == maxx+1 || iterated_y == maxy+1)
				located.ChangeTurf(/turf/open/overmap/border, flags = CHANGETURF_IGNORE_AIR)
			//Plase a map turf and name it
			else
				located.ChangeTurf(/turf/open/overmap/map, flags = CHANGETURF_IGNORE_AIR)
				var/turf/open/overmap/map/map_turf = located
				map_turf.name = "[iterated_x]-[iterated_y]"
				//Handle their number overlays
				var/lowx
				var/lowy
				var/highx
				var/highy
				if(iterated_x == 1)
					lowy = iterated_y
				else if (iterated_x == maxx)
					highy = iterated_y
				if(iterated_y == 1)
					lowx = iterated_x
				else if (iterated_y == maxy)
					highx = iterated_x
				map_turf.set_coords_overlays(lowx, lowy, highx, highy)
				if(prob(TRANSPORTABLE_LOOT_CHANCE_PER_TILE))
					var/transp_type = pick_weight(transportables_loot_list)
					new transp_type(src, iterated_x, iterated_y)
				if(prob(ORE_ROCK_PER_TILE_CHANCE))
					new /datum/overmap_object/ore_rock(src, iterated_x, iterated_y)
					if(prob(ORE_ROCK_DOUBLE_CHANCE))
						new /datum/overmap_object/ore_rock(src, iterated_x, iterated_y)
	//Spawn hazards
	SeedHazards()

///Map Generation Stuff
/datum/overmap_sun_system/proc/SeedHazards(cluster_amount = DEFAULT_HAZARD_CLUSTER_AMOUNT, cluster_dropoff = DEFAULT_HAZARD_CLUSTER_DROPOFF, hazard_types = DEFAULT_OVERMAP_HAZARDS)
	var/list/transportables_loot_list = TRANSPORTABLE_SPECIAL_LOOT_TABLE
	for(var/i in 1 to cluster_amount)
		var/chosen_type = pick(hazard_types)

		//We try and pick a clear initial spot
		var/list/initial_loc
		var/cleared = FALSE
		var/cleared_tries = 10
		while(!cleared)
			cleared_tries--
			if(cleared_tries <= 0)
				break
			var/rand_x = rand(1,maxx)
			var/rand_y = rand(1,maxy)
			if(!CoordsHaveHazard(rand_x, rand_y))
				initial_loc = list(rand_x, rand_y)
				cleared = TRUE
		if(!cleared)
			continue

		var/list/possible_locs = list(initial_loc)
		var/safefail_count = 30
		var/spread_prob = 100
		while(length(possible_locs))
			safefail_count--
			if(safefail_count <= 0)
				WARNING("Sun system hazard generation exited through a safefail")
				break
			var/list/chosen_list = pick_n_take(possible_locs)
			var/chosen_x = chosen_list[1]
			var/chosen_y = chosen_list[2]
			if(CoordsHaveHazard(chosen_x, chosen_y))
				continue
			new chosen_type(src, chosen_x, chosen_y)
			if(prob(TRANSPORTABLE_SPECIAL_ON_DEBRIS_CHANCE))
				var/transp_type = pick_weight(transportables_loot_list)
				new transp_type(src, chosen_x, chosen_y)
			//Add adjacent turf to the possible pool to spawn
			for(var/b in 1 to 4)
				var/list/step_list
				switch(b)
					if(1)
						step_list = list(chosen_x+1, chosen_y)
					if(2)
						step_list = list(chosen_x-1, chosen_y)
					if(3)
						step_list = list(chosen_x, chosen_y+1)
					if(4)
						step_list = list(chosen_x, chosen_y-1)
				if(IsOutOfBoundsX(step_list[1]) || IsOutOfBoundsY(step_list[2]))
					continue
				if(CoordsHaveHazard(step_list[1], step_list[2]))
					continue
				possible_locs += list(step_list) //Dumb byond list appending
			spread_prob -= cluster_dropoff
			if(!prob(spread_prob))
				break

#define SAFE_COORDS_ITERATION_TRIES 30

/datum/overmap_sun_system/proc/GetRandomSafeCoords()
	var/safe_x
	var/safe_y
	for(var/i in 1 to SAFE_COORDS_ITERATION_TRIES)
		safe_x = rand(1, maxx)
		safe_y = rand(1, maxy)

		var/list/objects = GetObjectsOnCoords(safe_x, safe_y)
		var/safe = TRUE
		for(var/object in objects)
			if(istype(object, /datum/overmap_object/hazard))
				safe = FALSE
				break
		if(safe)
			break
	return list(safe_x, safe_y)

#undef SAFE_COORDS_ITERATION_TRIES
