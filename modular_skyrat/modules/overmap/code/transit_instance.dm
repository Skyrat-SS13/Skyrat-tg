/datum/transit_instance
	var/datum/turf_reservation/reservation
	var/obj/docking_port/stationary/transit/dock
	var/datum/overmap_object/shuttle/overmap_shuttle
	//Associative for easy lookup
	var/list/affected_movables = list()

//Getter for hazards to easily find random and appropriate turfs to spawn/do stuff on
/datum/transit_instance/proc/GetActionSideTurf(dir, middle = FALSE)
	var/turf/found_turf
	var/list/bottom_left_coords = reservation.bottom_left_coords
	var/list/top_right_coords = reservation.top_right_coords
	var/z = bottom_left_coords[3]
	//The margin is 2 because diagonal movement will cause things to evaporate due to entering a transit border turf
	var/low_x = bottom_left_coords[1] + 2
	var/high_x = top_right_coords[1] - 2
	var/low_y = bottom_left_coords[2] + 2
	var/high_y = top_right_coords[2] - 2
	if(middle)
		found_turf = locate(rand(low_x, high_x), rand(low_y, high_y), z)
	else
		if(!dir)
			dir = pick(GLOB.cardinals)
		switch(dir)
			if(NORTH)
				found_turf = locate(rand(low_x, high_x), high_y, z)
			if(SOUTH)
				found_turf = locate(rand(low_x, high_x), low_y, z)
			if(EAST)
				found_turf = locate(high_x, rand(low_y, high_y), z)
			if(WEST)
				found_turf = locate(low_x, rand(low_y, high_y), z)
	return found_turf

/datum/transit_instance/New(datum/turf_reservation/arg_reservation, obj/docking_port/stationary/transit/arg_dock)
	. = ..()
	reservation = arg_reservation
	dock = arg_dock
	dock.transit_instance = src
	SSshuttle.transit_instances += src

/datum/transit_instance/Destroy()
	StrandAll()
	SSshuttle.transit_instances -= src
	reservation = null
	dock = null
	overmap_shuttle = null
	return ..()

//Movable moved in transit
/datum/transit_instance/proc/MovableMoved(atom/movable/moved)
	if(!moved)
		stack_trace("null movable on Movable Moved in Transit Instance")
		return
	if(!moved.loc || !isturf(moved.loc))
		return
	var/turf/my_turf = moved.loc
	if(!reservation.IsAdjacentToEdgeOrOutOfBounds(my_turf))
		return
	//We've moved to be adjacent to edge or out of bounds
	//Check for things that should just disappear as they bump into the edges of the map
	//Maybe listening for this event could be done in a better way?
	if(ishuman(moved)) //Humans could disconnect and not have a client, we dont want to get them stranded
		return
	if(ismob(moved))
		var/mob/moved_mob = moved
		if(moved_mob.client) //Client things never voluntairly get stranded
			return
	StrandAct(moved)

//Apply velocity to the movables we're handling
/datum/transit_instance/proc/ApplyVelocity(dir, velocity)
	var/velocity_stage
	switch(velocity)
		if(0 to 0.5)
			velocity_stage = TRANSIT_VELOCITY_NEGLIGIBLE
		if(0.5 to 1)
			velocity_stage = TRANSIT_VELOCITY_LOW
		if(1 to 1.5)
			velocity_stage = TRANSIT_VELOCITY_MEDIUM
		if(2 to INFINITY)
			velocity_stage = TRANSIT_VELOCITY_HIGH
	if(!velocity_stage)
		return
	for(var/i in affected_movables)
		var/atom/movable/movable = i
		if(movable.anchored)
			continue
		var/turf/my_turf = get_turf(movable)
		if(!my_turf)
			continue
		var/turf/step_turf = get_step(my_turf, dir)
		//Medium velocity, and someone gets bumped against an edge turf
		if(velocity_stage >= TRANSIT_VELOCITY_MEDIUM && reservation.IsAtEdge(step_turf))
			StrandAct(movable)
			continue
		//Huge velocity, check if we get squashed against something that blocks us
		if(velocity_stage >= TRANSIT_VELOCITY_HIGH && isliving(movable))
			var/mob/living/movable_mob = movable
			if(isclosedturf(step_turf) || step_turf.is_blocked_turf(TRUE))
				movable_mob.gib(FALSE, FALSE, FALSE)
				continue
		//If velocity is medium, mobs can still hold onto things to avoid being thrown
		if(velocity_stage <= TRANSIT_VELOCITY_MEDIUM && isliving(movable))
			if(movable.Process_Spacemove())
				continue
			for(var/cardinal in GLOB.cardinals)
				var/turf/cardinal_turf = get_step(my_turf, cardinal)
				if(!istype(cardinal_turf, /turf/open/space/transit))
					continue
		if(!isclosedturf(step_turf) && !step_turf.is_blocked_turf(TRUE))
			movable.throw_at(get_edge_target_turf(my_turf, dir), 4, 2)

///Strand all movables that we're managing
/datum/transit_instance/proc/StrandAll()
	for(var/movable in affected_movables)
		StrandAct(movable)

/datum/transit_instance/proc/StrandAct(atom/movable/strander)
	var/commit_strand = FALSE
	var/name_to_apply
	if(ishuman(strander))
		commit_strand = TRUE
		name_to_apply = "stranded human"
	else if (istype(strander, /obj/structure/closet))
		commit_strand = TRUE
		name_to_apply = "stranded cargo"
	else if(ismob(strander))
		var/mob/strander_mob = strander
		if(strander_mob.client)
			commit_strand = TRUE
			name_to_apply = "stranded creature"
	if(!commit_strand)
		qdel(strander)
		return
	var/turf/turfer = locate(1,1,1)
	strander.forceMove(turfer) //Lots of things doesn't like being in nullspace, huff
	var/overmap_y = 1
	var/overmap_x = 1
	var/overmap_system = SSovermap.main_system
	if(overmap_shuttle)
		overmap_x = overmap_shuttle.x
		overmap_y = overmap_shuttle.y
		overmap_system = overmap_shuttle.current_system
	var/datum/overmap_object/transportable/stranded/stranded_ovo = new(overmap_system, overmap_x, overmap_y)
	stranded_ovo.StoreStranded(strander, name_to_apply)
	if(ismob(strander))
		var/mob/strander_mob = strander
		to_chat(strander_mob, span_userdanger("You have been stranded in the empty void of space! Your body is able to be recovered by someone picking it up with a transporter."))
