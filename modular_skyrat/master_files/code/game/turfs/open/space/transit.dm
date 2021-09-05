/turf/open/space/transit
	name = "\proper hyperspace"
	icon_state = "black"
	dir = SOUTH
	baseturfs = /turf/open/space/transit
	flags_1 = NOJAUNT //This line goes out to every wizard that ever managed to escape the den. I'm sorry.
	explosion_block = INFINITY

/turf/open/space/transit/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_CREATED, .proc/CreatedOnTransit) //Why isn't this a turf proc too..

/turf/open/space/transit/Destroy()
	UnregisterSignal(src, COMSIG_ATOM_CREATED)
	return ..()

/turf/open/space/transit/proc/CreatedOnTransit(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	EnterTransitTurf(AM)

/turf/open/space/transit/Entered(atom/movable/arrived, direction)
	. = ..()
	EnterTransitTurf(arrived)

/turf/open/space/transit/proc/EnterTransitTurf(atom/movable/arrived)
	if(istype(arrived, /obj/effect/abstract) || arrived.invisibility == INVISIBILITY_ABSTRACT)
		return
	if(arrived.GetComponent(/datum/component/transit_handler))
		return
	if(arrived.loc != src || src.loc.type != /area/shuttle/transit)
		return
	var/datum/transit_instance/this_transit = SSshuttle.get_transit_instance(src)
	if(!this_transit)
		return
	arrived.AddComponent(/datum/component/transit_handler, this_transit)

/turf/open/space/transit/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	. = ..()
	underlay_appearance.icon_state = "speedspace_ns_[get_transit_state(asking_turf)]"
	underlay_appearance.transform = turn(matrix(), get_transit_angle(asking_turf))

/turf/open/space/transit/south
	dir = SOUTH

/turf/open/space/transit/north
	dir = NORTH

/turf/open/space/transit/horizontal
	dir = WEST

/turf/open/space/transit/west
	dir = WEST

/turf/open/space/transit/east
	dir = EAST

/turf/open/space/transit/CanBuildHere()
	return SSshuttle.is_in_shuttle_bounds(src)

/turf/open/space/transit/Initialize()
	. = ..()
	update_appearance()

/turf/open/space/transit/update_icon()
	. = ..()
	transform = turn(matrix(), get_transit_angle(src))

/turf/open/space/transit/update_icon_state()
	icon_state = "speedspace_ns_[get_transit_state(src)]"
	return ..()

/proc/get_transit_state(turf/T)
	var/p = 9
	. = 1
	switch(T.dir)
		if(NORTH)
			. = ((-p*T.x+T.y) % 15) + 1
			if(. < 1)
				. += 15
		if(EAST)
			. = ((T.x+p*T.y) % 15) + 1
		if(WEST)
			. = ((T.x-p*T.y) % 15) + 1
			if(. < 1)
				. += 15
		else
			. = ((p*T.x+T.y) % 15) + 1

/proc/get_transit_angle(turf/T)
	. = 0
	switch(T.dir)
		if(NORTH)
			. = 180
		if(EAST)
			. = 90
		if(WEST)
			. = -90

//Because I can't use a closed turfs because that makes something weird with the generation
/turf/open/space/transit/edge
	opacity = TRUE
	density = TRUE
