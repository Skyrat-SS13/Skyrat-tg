#define SPREAD_PROCESS 1
#define SPREAD_STALLED_PROCESS 20

#define RESIN_CANT_SPREAD 0
#define RESIN_DID_SPREAD 1
#define RESIN_ATTACKED_DOOR 2

/datum/biohazard_blob_controller
	var/list/active_resin = list()
	var/list/all_resin = list()
	var/obj/structure/biohazard_blob/core/our_core
	var/list/other_structures = list()
	var/progress_to_spread = 0
	var/stalled = FALSE

/datum/biohazard_blob_controller/New(obj/structure/biohazard_blob/core/the_core)
	if(!the_core)
		qdel(src)
		return
	our_core = the_core
	our_core.our_controller = src
	START_PROCESSING(SSobj, src)
	return ..()

/datum/biohazard_blob_controller/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/biohazard_blob_controller/proc/CoreDeath()
	active_resin.Cut()
	for(var/t in all_resin)
		var/obj/structure/biohazard_blob/resin/a_resin = t
		a_resin.color = null
		if(a_resin.blooming)
			a_resin.blooming = FALSE
			a_resin.set_light(0)
			a_resin.update_overlays()
	return

/datum/biohazard_blob_controller/proc/TrySpreadResin(obj/structure/biohazard_blob/resin/spreaded_resin)
	var/turf/ownturf = get_turf(spreaded_resin)
	var/list/possible_locs = list(ownturf) //Ownturf, because it could spread into the same turf, but on the wall
	for(var/T in ownturf.GetAtmosAdjacentTurfs())
		possible_locs += T

	for(var/T in possible_locs)
		var/turf/iterated_turf = T
		var/resinCount = 0
		var/placeCount = 1
		for(var/obj/structure/biohazard_blob/resin/potato in iterated_turf)
			resinCount++
		for(var/wallDir in GLOB.cardinals)
			var/turf/isWall = get_step(iterated_turf,wallDir)
			if(isWall.density)
				placeCount++
		if(resinCount >= placeCount)
			continue
		SpawnResin(iterated_turf)
		return RESIN_DID_SPREAD

	active_resin -= spreaded_resin
	return RESIN_CANT_SPREAD

/datum/biohazard_blob_controller/proc/SpawnResin(loc)
	//On spawning effects
	for(var/obj/machinery/light/potato in loc)
		potato.break_light_tube()
	//Spawn the resin
	var/obj/structure/biohazard_blob/resin/new_resin = new /obj/structure/biohazard_blob/resin(loc)
	new_resin.our_controller = src
	all_resin[new_resin] = TRUE
	active_resin[new_resin] = TRUE
	new_resin.CalcDir()
	return

/datum/biohazard_blob_controller/proc/ActivateAdjacentResin(obj/structure/biohazard_blob/resin/centrum)
	if(!our_core)
		//We're dead, no point in doing this
		return
	var/turf/centrum_turf = get_turf(centrum)
	var/list/turfs = list(centrum_turf)
	for(var/t in centrum_turf.GetAtmosAdjacentTurfs())
		turfs += t
	for(var/t in turfs)
		var/turf/ite_turf = t
		for(var/obj/structure/biohazard_blob/resin/potato in ite_turf)
			if(potato && potato.our_controller && potato.our_controller == src)
				active_resin[potato] = TRUE
				return

/datum/biohazard_blob_controller/process(delta_time)
	progress_to_spread++
	if(stalled && progress_to_spread < SPREAD_STALLED_PROCESS)
		return
	if(progress_to_spread < SPREAD_PROCESS)
		return
	stalled = FALSE
	progress_to_spread = 0

	if(!our_core)
		if(length(all_resin))
			var/obj/structure/biohazard_blob/resin/iterated_resin = pick(all_resin)
			qdel(iterated_resin)
			return

	//No resin, but we've got a core
	if(!length(all_resin))
		SpawnResin(get_turf(our_core))
		return

	if(!length(active_resin))
		var/did_anything = FALSE
		for(var/t in all_resin)
			var/obj/structure/biohazard_blob/resin/iterated_resin = t
			var/attempt = TrySpreadResin(iterated_resin)
			switch(attempt)
				if(RESIN_DID_SPREAD, RESIN_ATTACKED_DOOR)
					active_resin[iterated_resin] = TRUE
					did_anything = TRUE
					break
		//If we didnt manage to do anything even though we iterated over all resin, stall us
		if(!did_anything)
			stalled = TRUE
		return

	for(var/t in active_resin)
		var/obj/structure/biohazard_blob/resin/active_resin = t
		var/attempt = TrySpreadResin(active_resin)
		switch(attempt)
			if(RESIN_DID_SPREAD, RESIN_ATTACKED_DOOR)
				return

#undef SPREAD_PROCESS
#undef SPREAD_STALLED_PROCESS

#undef RESIN_CANT_SPREAD
#undef RESIN_DID_SPREAD
#undef RESIN_ATTACKED_DOOR