/**
 * Area spawn datums
 *
 * Use these to spawn atoms in areas instead of placing them on a map. It will select any available open and entering turf.
 */
/datum/area_spawn
	/// The target area for us to spawn the desired atom
	var/target_area
	/// The atom that we want to spawn
	var/desired_atom
	/// The amount we want to spawn
	var/amount_to_spawn = 1
	/// Do we require an open space to spawn?
	var/requires_open_space = TRUE

/datum/area_spawn/proc/try_spawn(list/available_areas)
	var/area/found_area = GLOB.areas_by_type[target_area]

	if(!found_area)
		CRASH("[src.type] could not find area [target_area]!")

	var/list/available_turfs = list()

	var/obj/structure/enter_test = new()

	for(var/turf/iterating_turf in found_area)
		if(requires_open_space)
			if(iterating_turf.density)
				continue
			if(!enter_test.Enter(iterating_turf))
				continue
		available_turfs += iterating_turf

	qdel(enter_test)

	if(!available_turfs)
		CRASH("[src.type] could not find any suitable turfs!")

	for(var/i in 1 to amount_to_spawn)
		new desired_atom(pick(available_turfs))


/datum/area_spawn/markus
	target_area = /area/station/cargo/warehouse
	desired_atom = /mob/living/simple_animal/pet/dog/markus
