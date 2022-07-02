/**
 * Area spawn datums
 *
 * Use these to spawn atoms in areas instead of placing them on a map. It will select any available open and entering turf.
 */
/datum/area_spawn
	/// The target area for us to spawn the desired atom
	var/list/target_areas
	/// The atom that we want to spawn
	var/desired_atom
	/// The amount we want to spawn
	var/amount_to_spawn = 1
	/// The max amount that the world can have
	var/max_amount = 1
	/// Do we require an open space to spawn?
	var/requires_open_space = TRUE
	/// Do we need to be adjacent to a wall?
	var/wall_hug = FALSE
	/// Map blacklist, this is used to determine what maps we should not spawn on.
	var/list/blacklisted_stations = list("Blueshift", "Runtime Station", "MultiZ Debug")

/datum/area_spawn/proc/try_spawn()
	SHOULD_CALL_PARENT(TRUE)

	if(SSmapping.config.map_name in blacklisted_stations)
		return

	var/amount_in_world = 0
	for(desired_atom in world)
		amount_in_world++

	if(amount_in_world >= max_amount)
		return

	var/list/available_turfs = list()

	var/obj/structure/enter_test = new()

	for(var/area_type in target_areas)
		var/area/found_area = GLOB.areas_by_type[area_type]
		if(!found_area)
			continue
		for(var/turf/iterating_turf in found_area)
			if(requires_open_space)
				if(iterating_turf.density)
					continue
				if(!enter_test.Enter(iterating_turf))
					continue
				var/cardinal_check = FALSE
				var/wall_check = FALSE
				for(var/dir in GLOB.cardinals)
					var/turf/cardinal_test_turf = get_step(iterating_turf, dir)
					if(enter_test.Enter(cardinal_test_turf))
						cardinal_check = TRUE
					if(isclosedturf(cardinal_test_turf))
						wall_check = TRUE
				if(wall_hug && !wall_check)
					continue
				if(!cardinal_check)
					continue
			available_turfs += iterating_turf

	qdel(enter_test)

	if(!available_turfs)
		CRASH("[src.type] could not find any suitable turfs!")

	for(var/i in 1 to amount_to_spawn)
		new desired_atom(pick(available_turfs))

// Pets
/datum/area_spawn/markus
	target_areas = list(/area/station/cargo/storage)
	desired_atom = /mob/living/simple_animal/pet/dog/markus

/datum/area_spawn/bumbles
	target_areas = list(/area/station/service/hydroponics)
	desired_atom = /mob/living/simple_animal/pet/bumbles

/datum/area_spawn/borgi
	target_areas = list(/area/station/science/robotics)
	desired_atom = /mob/living/simple_animal/pet/dog/corgi/borgi

/datum/area_spawn/poppy
	target_areas = list(/area/station/engineering)
	desired_atom = /mob/living/simple_animal/pet/poppy

// Structures
/datum/area_spawn/secmed_locker
	target_areas = list(/area/station/security/medical)
	desired_atom = /obj/structure/closet/secure_closet/security_medic

/datum/area_spawn/command_drobe
	target_areas = list(/area/station/command/heads_quarters)
	desired_atom = /obj/machinery/vending/access/command

// Job spawners
/datum/area_spawn/secmed_landmark
	target_areas = list(/area/station/security/medical, /area/station/security/brig)
	desired_atom = /obj/effect/landmark/start/security_medic

/datum/area_spawn/barber_landmark
	target_areas = list(/area/station/service/salon, /area/station/hallway/secondary/service)
	desired_atom = /obj/effect/landmark/start/barber

/datum/area_spawn/blueshield_landmark
	target_areas = list(/area/station/command/heads_quarters/captain, /area/station/command/bridge)
	desired_atom = /obj/effect/landmark/start/blueshield

/datum/area_spawn/vanguard_landmark
	target_areas = list(/area/station/command/gateway, /area/station/hallway/primary/central)
	desired_atom = /obj/effect/landmark/start/expeditionary_corps

