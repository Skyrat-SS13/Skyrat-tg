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

/datum/area_spawn/proc/try_spawn()
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
			var/cardinal_check = FALSE
			for(var/dir in GLOB.cardinals)
				var/turf/cardinal_test_turf = get_step(iterating_turf, dir)
				if(enter_test.Enter(cardinal_test_turf))
					cardinal_check = TRUE
			if(!cardinal_check)
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

/datum/area_spawn/bumbles
	target_area = /area/station/service/hydroponics
	desired_atom = /mob/living/simple_animal/pet/bumbles

/datum/area_spawn/borgi
	target_area = /area/station/science/robotics
	desired_atom = /mob/living/simple_animal/pet/dog/corgi/borgi

/datum/area_spawn/poppy
	target_area = /area/station/engineering
	desired_atom = /mob/living/simple_animal/pet/poppy

/datum/area_spawn/secmed_locker
	target_area = /area/station/security/medical
	desired_atom = /obj/structure/closet/secure_closet/security_medic

/datum/area_spawn/command_drobe
	target_area = /area/station/command/heads_quarters
	desired_atom = /obj/machinery/vending/access/command

