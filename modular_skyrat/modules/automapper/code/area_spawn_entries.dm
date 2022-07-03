SUBSYSTEM_DEF(area_spawn)
	name = "Area Spawn"
	flags = SS_NO_FIRE

/datum/controller/subsystem/area_spawn/Initialize(start_timeofday)
	for(var/iterating_type in subtypesof(/datum/area_spawn))
		var/datum/area_spawn/iterating_area_spawn = new iterating_type
		iterating_area_spawn.try_spawn()
	return ..()

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
	/// Do we need to be adjacent to a wall? This also checks the other 3 cardinals for no density. Generally useful for objects with density and anchored.
	var/wall_hug = FALSE
	/// Map blacklist, this is used to determine what maps we should not spawn on.
	var/list/blacklisted_stations = list("Blueshift", "Runtime Station", "MultiZ Debug")

/datum/area_spawn/proc/try_spawn()
	if(SSmapping.config.map_name in blacklisted_stations)
		return

	// Turfs that are available
	var/list/available_turfs = list()
	// Turfs that are available and completely void of contents
	var/list/available_empty_turfs = list()

	for(var/area_type in target_areas)
		if(LAZYLEN(available_turfs))
			break
		var/area/found_area = GLOB.areas_by_type[area_type]
		if(!found_area)
			continue
		for(var/turf/iterating_turf in found_area)
			if(iterating_turf.density)
				continue
			var/density_found = FALSE
			for(var/atom/movable/found_movable in iterating_turf)
				if(found_movable.density)
					density_found = TRUE
					break
			if(density_found)
				continue
			// Time to check cardinals
			// The cardinals must be clear of any density, aside from wall cardinals!
			var/cardinal_density_check = TRUE
			// Some items want to be hugging a wall, such as lockers, and machines. It just looks better.
			var/wall_check = FALSE
			for(var/dir in GLOB.cardinals)
				var/turf/cardinal_test_turf = get_step(iterating_turf, dir)
				if(isclosedturf(cardinal_test_turf))
					wall_check = TRUE
				for(var/atom/movable/found_movable in cardinal_test_turf)
					if(found_movable.density && !wall_check)
						cardinal_density_check = FALSE
						break
			if(wall_hug && !wall_check)
				continue
			if(!cardinal_density_check && wall_hug)
				continue
			// Finally we want to prioritise entirely empty turfs
			var/totally_empty = TRUE
			for(var/atom/movable/found_movable in iterating_turf)
				totally_empty = FALSE
				break
			if(totally_empty)
				available_empty_turfs += iterating_turf
			available_turfs += iterating_turf

	if(!LAZYLEN(available_turfs))
		CRASH("[src.type] could not find any suitable turfs on map [SSmapping.config.map_name]!")

	for(var/i in 1 to amount_to_spawn)
		if(LAZYLEN(available_empty_turfs))
			new desired_atom(pick(available_empty_turfs))
		else
			new desired_atom(pick(available_turfs))

// Pets
/datum/area_spawn/markus
	target_areas = list(/area/station/cargo/sorting,  /area/station/cargo/storage, /area/station/cargo/office, /area/station/cargo/qm)
	desired_atom = /mob/living/simple_animal/pet/dog/markus

/datum/area_spawn/bumbles
	target_areas = list(/area/station/service/hydroponics, /area/station/service/hydroponics/upper)
	desired_atom = /mob/living/simple_animal/pet/bumbles

/datum/area_spawn/borgi
	target_areas = list(/area/station/science/robotics, /area/station/science/robotics/mechbay, /area/station/science/robotics/lab)
	desired_atom = /mob/living/simple_animal/pet/dog/corgi/borgi

/datum/area_spawn/poppy
	target_areas = list(/area/station/engineering/main, /area/station/engineering/break_room, /area/station/engineering/lobby, /area/station/engineering/supermatter/room)
	desired_atom = /mob/living/simple_animal/pet/poppy

// Structures
/datum/area_spawn/secmed_locker
	target_areas = list(/area/station/security/medical)
	desired_atom = /obj/structure/closet/secure_closet/security_medic
	wall_hug = TRUE

/datum/area_spawn/command_drobe
	target_areas = list(/area/station/command/bridge, /area/station/command/meeting_room)
	desired_atom = /obj/machinery/vending/access/command
	wall_hug = TRUE

/datum/area_spawn/lustwish_dorms
	target_areas = list(/area/station/commons/locker, /area/station/commons/dorms)
	desired_atom = /obj/machinery/vending/dorms
	wall_hug = TRUE

/datum/area_spawn/lustwish_prison
	target_areas = list(/area/station/security/prison, /area/station/security/prison/shower)
	desired_atom = /obj/machinery/vending/dorms
	wall_hug = TRUE

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
	target_areas = list(/area/station/command/gateway, /area/station/science/lobby, /area/station/science/breakroom)
	desired_atom = /obj/effect/landmark/start/expeditionary_corps

/datum/area_spawn/bouncer_landmark
	desired_atom = /obj/effect/landmark/start/bouncer
	target_areas = list(/area/station/service/bar, /area/station/service/cafeteria, /area/station/service/kitchen/diner)

/datum/area_spawn/engineering_guard_landmark
	desired_atom = /obj/effect/landmark/start/engineering_guard
	target_areas = list(/area/station/security/checkpoint/engineering, /area/station/engineering/break_room, /area/station/engineering/lobby)

/datum/area_spawn/science_guard_landmark
	desired_atom = /obj/effect/landmark/start/science_guard
	target_areas = list(/area/station/security/checkpoint/science/research, /area/station/science/lobby)

/datum/area_spawn/orderly_landmark
	desired_atom = /obj/effect/landmark/start/orderly
	target_areas = list(/area/station/security/checkpoint/medical, /area/station/medical/medbay/lobby)
