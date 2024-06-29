//use this define to highlight docking port bounding boxes (ONLY FOR DEBUG USE)
#ifdef TESTING
#define DOCKING_PORT_HIGHLIGHT
#endif

//NORTH default dir
/obj/docking_port
	invisibility = INVISIBILITY_ABSTRACT
	icon = 'icons/effects/docking_ports.dmi'
	icon_state = "static"

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = TRUE
	///Common standard is for this to point -away- from the dockingport door, ie towards the ship
	dir = NORTH
	/// The identifier of the port or ship.
	/// This will be used in numerous other places like the console,
	/// stationary ports and whatnot to tell them your ship's mobile
	/// port can be used in these places, or the docking port is compatible, etc.
	var/shuttle_id
	/// Possible destinations
	var/port_destinations
	///size of covered area, perpendicular to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/width = 0
	///size of covered area, parallel to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/height = 0
	///position relative to covered area, perpendicular to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/dwidth = 0
	///position relative to covered area, parallel to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/dheight = 0

	var/area_type
	///are we invisible to shuttle navigation computers?
	var/hidden = FALSE

	///Delete this port after ship fly off.
	var/delete_after = FALSE

	///are we registered in SSshuttles?
	var/registered = FALSE

///register to SSshuttles
/obj/docking_port/proc/register()
	if(registered)
		WARNING("docking_port registered multiple times")
		unregister()
	registered = TRUE
	return

///unregister from SSshuttles
/obj/docking_port/proc/unregister()
	if(!registered)
		WARNING("docking_port unregistered multiple times")
	registered = FALSE
	return

/obj/docking_port/proc/Check_id()
	return

//these objects are indestructible
/obj/docking_port/Destroy(force)
	// unless you assert that you know what you're doing. Horrible things
	// may result.
	if(force)
		..()
		return QDEL_HINT_QUEUE
	else
		return QDEL_HINT_LETMELIVE

/obj/docking_port/has_gravity(turf/current_turf)
	return TRUE

/obj/docking_port/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	return

/obj/docking_port/singularity_pull()
	return

/obj/docking_port/singularity_act()
	return FALSE

/obj/docking_port/shuttleRotate()
	return //we don't rotate with shuttles via this code.

///returns a list(x0,y0, x1,y1) where points 0 and 1 are bounding corners of the projected rectangle
/obj/docking_port/proc/return_coords(_x, _y, _dir)
	if(_dir == null)
		_dir = dir
	if(_x == null)
		_x = x
	if(_y == null)
		_y = y

	//byond's sin and cos functions are inaccurate. This is faster and perfectly accurate
	var/cos = 1
	var/sin = 0
	switch(_dir)
		if(WEST)
			cos = 0
			sin = 1
		if(SOUTH)
			cos = -1
			sin = 0
		if(EAST)
			cos = 0
			sin = -1

	return list(
		_x + (-dwidth*cos) - (-dheight*sin),
		_y + (-dwidth*sin) + (-dheight*cos),
		_x + (-dwidth+width-1)*cos - (-dheight+height-1)*sin,
		_y + (-dwidth+width-1)*sin + (-dheight+height-1)*cos,
	)

///returns turfs within our projected rectangle in no particular order
/obj/docking_port/proc/return_turfs()
	var/list/L = return_coords()
	var/turf/T0 = locate(L[1],L[2],z)
	var/turf/T1 = locate(L[3],L[4],z)
	return block(T0,T1)

///returns turfs within our projected rectangle in a specific order.this ensures that turfs are copied over in the same order, regardless of any rotation
/obj/docking_port/proc/return_ordered_turfs(_x, _y, _z, _dir)
	var/cos = 1
	var/sin = 0
	switch(_dir)
		if(WEST)
			cos = 0
			sin = 1
		if(SOUTH)
			cos = -1
			sin = 0
		if(EAST)
			cos = 0
			sin = -1

	. = list()

	for(var/dx in 0 to width-1)
		var/compX = dx-dwidth
		for(var/dy in 0 to height-1)
			var/compY = dy-dheight
			// realX = _x + compX*cos - compY*sin
			// realY = _y + compY*cos - compX*sin
			// locate(realX, realY, _z)
			var/turf/T = locate(_x + compX*cos - compY*sin, _y + compY*cos + compX*sin, _z)
			.[T] = NONE

#ifdef DOCKING_PORT_HIGHLIGHT
//Debug proc used to highlight bounding area
/obj/docking_port/proc/highlight(_color = "#f00")
	SetInvisibility(INVISIBILITY_NONE)
	SET_PLANE_IMPLICIT(src, GHOST_PLANE)
	var/list/L = return_coords()
	var/turf/T0 = locate(L[1],L[2],z)
	var/turf/T1 = locate(L[3],L[4],z)
	for(var/turf/T in block(T0,T1))
		T.color = _color
		LAZYINITLIST(T.atom_colours)
		T.maptext = null
	if(_color)
		var/turf/T = locate(L[1], L[2], z)
		T.color = "#0f0"
		T = locate(L[3], L[4], z)
		T.color = "#00f"
#endif

//return first-found touching dockingport
/obj/docking_port/proc/get_docked()
	return locate(/obj/docking_port/stationary) in loc

// Return id of the docked docking_port
/obj/docking_port/proc/getDockedId()
	var/obj/docking_port/P = get_docked()
	if(P)
		return P.shuttle_id

// Say that A in the absolute (rectangular) bounds of this shuttle or no.
/obj/docking_port/proc/is_in_shuttle_bounds(atom/A)
	var/turf/T = get_turf(A)
	if(T.z != z)
		return FALSE
	var/list/bounds = return_coords()
	var/x0 = bounds[1]
	var/y0 = bounds[2]
	var/x1 = bounds[3]
	var/y1 = bounds[4]
	if(!ISINRANGE(T.x, min(x0, x1), max(x0, x1)))
		return FALSE
	if(!ISINRANGE(T.y, min(y0, y1), max(y0, y1)))
		return FALSE
	return TRUE

/obj/docking_port/stationary
	name = "dock"

	var/last_dock_time

	/// Map template to load when the dock is loaded
	var/datum/map_template/shuttle/roundstart_template
	/// Used to check if the shuttle template is enabled in the config file
	var/json_key
	///If true, the shuttle can always dock at this docking port, despite its area checks, or if something is already docked
	var/override_can_dock_checks = FALSE

/obj/docking_port/stationary/register(replace = FALSE)
	. = ..()
	if(!shuttle_id)
		shuttle_id = "dock"
	else
		port_destinations = shuttle_id

	if(!name)
		name = "dock"

	var/counter = SSshuttle.assoc_stationary[shuttle_id]
	if(!replace || !counter)
		if(counter)
			counter++
			SSshuttle.assoc_stationary[shuttle_id] = counter
			shuttle_id = "[shuttle_id]_[counter]"
			name = "[name] [counter]"
		else
			SSshuttle.assoc_stationary[shuttle_id] = 1

	if(!port_destinations)
		port_destinations = shuttle_id

	SSshuttle.stationary_docking_ports += src

/obj/docking_port/stationary/Initialize(mapload)
	. = ..()
	register()
	if(!area_type)
		var/area/place = get_area(src)
		area_type = place?.type // We might be created in nullspace

	if(mapload)
		for(var/turf/T in return_turfs())
			T.turf_flags |= NO_RUINS

	if(SSshuttle.initialized)
		INVOKE_ASYNC(SSshuttle, TYPE_PROC_REF(/datum/controller/subsystem/shuttle, setup_shuttles), list(src))

	#ifdef DOCKING_PORT_HIGHLIGHT
	highlight("#f00")
	#endif

/obj/docking_port/stationary/unregister()
	. = ..()
	SSshuttle.stationary_docking_ports -= src

/obj/docking_port/stationary/Destroy(force)
	if(force)
		unregister()
	return ..()

/obj/docking_port/stationary/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(area_type) // We already have one
		return
	var/area/newarea = get_area(src)
	area_type = newarea?.type

/obj/docking_port/stationary/proc/load_roundstart()
	if(json_key)
		var/sid = SSmapping.config.shuttles[json_key]
		roundstart_template = SSmapping.shuttle_templates[sid]
		if(!roundstart_template)
			CRASH("json_key:[json_key] value \[[sid]\] resulted in a null shuttle template for [src]")
	else if(roundstart_template) // passed a PATH
		var/sid = "[initial(roundstart_template.port_id)]_[initial(roundstart_template.suffix)]"

		roundstart_template = SSmapping.shuttle_templates[sid]
		if(!roundstart_template)
			CRASH("Invalid path ([sid]/[roundstart_template]) passed to docking port.")

	if(roundstart_template)
		SSshuttle.action_load(roundstart_template, src)

//returns first-found touching shuttleport
/obj/docking_port/stationary/get_docked()
	. = locate(/obj/docking_port/mobile) in loc

/// Subtype for escape pod ports so that we can give them trait behaviour
/obj/docking_port/stationary/escape_pod
	name = "escape pod loader"
	height = 5
	width = 3
	dwidth = 1
	roundstart_template = /datum/map_template/shuttle/escape_pod/default
	/// Set to true if you have a snowflake escape pod dock which needs to always have the normal pod or some other one
	var/enforce_specific_pod = FALSE

/obj/docking_port/stationary/escape_pod/Initialize(mapload)
	. = ..()
	if (enforce_specific_pod)
		return

	if (HAS_TRAIT(SSstation, STATION_TRAIT_SMALLER_PODS))
		roundstart_template = /datum/map_template/shuttle/escape_pod/cramped
		return
	if (HAS_TRAIT(SSstation, STATION_TRAIT_BIGGER_PODS))
		roundstart_template = /datum/map_template/shuttle/escape_pod/luxury

// should fit the syndicate infiltrator, and smaller ships like the battlecruiser corvettes and fighters
/obj/docking_port/stationary/syndicate
	name = "near the station"
	dheight = 1
	dwidth = 12
	height = 17
	width = 23
	shuttle_id = "syndicate_nearby"

/obj/docking_port/stationary/syndicate/northwest
	name = "northwest of station"
	shuttle_id = "syndicate_nw"

/obj/docking_port/stationary/syndicate/northeast
	name = "northeast of station"
	shuttle_id = "syndicate_ne"

/obj/docking_port/stationary/transit
	name = "In Transit"
	override_can_dock_checks = TRUE
	/// The turf reservation returned by the transit area request
	var/datum/turf_reservation/reserved_area
	/// The area created during the transit area reservation
	var/area/shuttle/transit/assigned_area
	/// The mobile port that owns this transit port
	var/obj/docking_port/mobile/owner

/obj/docking_port/stationary/transit/Initialize(mapload)
	. = ..()
	SSshuttle.transit_docking_ports += src

/obj/docking_port/stationary/transit/Destroy(force=FALSE)
	if(force)
		if(get_docked())
			log_world("A transit dock was destroyed while something was docked to it.")
		SSshuttle.transit_docking_ports -= src
		if(owner)
			if(owner.assigned_transit == src)
				owner.assigned_transit = null
			owner = null
		if(!QDELETED(reserved_area))
			qdel(reserved_area)
		reserved_area = null
	return ..()

/obj/docking_port/stationary/picked
	///Holds a list of map name strings for the port to pick from
	var/list/shuttlekeys

/obj/docking_port/stationary/picked/Initialize(mapload)
	. = ..()
	if(!LAZYLEN(shuttlekeys))
		WARNING("Random docking port [shuttle_id] loaded with no shuttle keys")
		return
	var/selectedid = pick(shuttlekeys)
	roundstart_template = SSmapping.shuttle_templates[selectedid]

/obj/docking_port/stationary/picked/whiteship
	name = "Deep Space"
	shuttle_id = "whiteship_away"
	height = 45 //Width and height need to remain in sync with the size of whiteshipdock.dmm, otherwise we'll get overflow
	width = 44
	dheight = 18
	dwidth = 18
	dir = 2
	shuttlekeys = list(
		"whiteship_meta",
		"whiteship_pubby",
		"whiteship_box",
		"whiteship_cere",
		"whiteship_kilo",
		"whiteship_donut",
		"whiteship_delta",
		"whiteship_tram",
		"whiteship_personalshuttle",
		"whiteship_obelisk",
	)

/// Helper proc that tests to ensure all whiteship templates can spawn at their docking port, and logs their sizes
/// This should be a unit test, but too much of our other code breaks during shuttle movement, so not yet, not yet.
/proc/test_whiteship_sizes()
	var/obj/docking_port/stationary/port_type = /obj/docking_port/stationary/picked/whiteship
	var/datum/turf_reservation/docking_yard = SSmapping.request_turf_block_reservation(
		initial(port_type.width),
		initial(port_type.height),
		1,
	)
	var/turf/bottom_left = docking_yard.bottom_left_turfs[1]
	var/turf/spawnpoint = locate(
		bottom_left.x + initial(port_type.dwidth),
		bottom_left.y + initial(port_type.dheight),
		bottom_left.z,
	)

	var/obj/docking_port/stationary/picked/whiteship/port = new(spawnpoint)
	var/list/ids = port.shuttlekeys
	var/height = 0
	var/width = 0
	var/dheight = 0
	var/dwidth = 0
	var/delta_height = 0
	var/delta_width = 0
	for(var/id in ids)
		var/datum/map_template/shuttle/our_template = SSmapping.shuttle_templates[id]
		// We do a standard load here so any errors will properly runtimes
		var/obj/docking_port/mobile/ship = SSshuttle.action_load(our_template, port)
		if(ship)
			ship.jumpToNullSpace()
			ship = null
		// Yes this is very hacky, but we need to both allow loading a template that's too big to be an error state
		// And actually get the sizing information from every shuttle
		SSshuttle.load_template(our_template)
		var/obj/docking_port/mobile/theoretical_ship = SSshuttle.preview_shuttle
		if(theoretical_ship)
			height = max(theoretical_ship.height, height)
			width = max(theoretical_ship.width, width)
			dheight = max(theoretical_ship.dheight, dheight)
			dwidth = max(theoretical_ship.dwidth, dwidth)
			delta_height = max(theoretical_ship.height - theoretical_ship.dheight, delta_height)
			delta_width = max(theoretical_ship.width - theoretical_ship.dwidth, delta_width)
			theoretical_ship.jumpToNullSpace()
	qdel(port, TRUE)
	log_world("Whiteship sizing information. Use this to set the docking port, and the map size\n\
		Max Height: [height] \n\
		Max Width: [width] \n\
		Max DHeight: [dheight] \n\
		Max DWidth: [dwidth] \n\
		The following are the safest bet for map sizing. Anything smaller then this could in the worst case not fit in the docking port\n\
		Max Combined Width: [height + dheight] \n\
		Max Combinded Height [width + dwidth]")

/obj/docking_port/mobile
	name = "shuttle"
	icon_state = "mobile"

	area_type = SHUTTLE_DEFAULT_SHUTTLE_AREA_TYPE

	///List of all areas our shuttle holds.
	var/list/shuttle_areas = list()
	///List of all currently used engines that propels us.
	var/list/obj/machinery/power/shuttle_engine/engine_list = list()

	///How fast the shuttle should be, taking engine thrust into account.
	var/engine_coeff = 1
	///How much engine power (thrust) the shuttle currently has.
	var/current_engine_power = 0
	///How much engine power (thrust) the shuttle starts with at mapload.
	var/initial_engine_power = 0
	///Speed multiplier based on station alert level
	var/alert_coeff = ALERT_COEFF_BLUE
	///used as a timer (if you want time left to complete move, use timeLeft proc)
	var/timer
	var/last_timer_length
	///current shuttle mode
	var/mode = SHUTTLE_IDLE
	///time spent in transit (deciseconds). Should not be lower then 10 seconds without editing the animation of the hyperspace ripples.
	var/callTime = 100
	/// time spent "starting the engines". Also rate limits how often we try to reserve transit space if its ever full of transiting shuttles.
	var/ignitionTime = 55
	/// time spent after arrival before being able to begin ignition
	var/rechargeTime = 0
	/// time spent after transit 'landing' before actually arriving
	var/prearrivalTime = 0

	/// The direction the shuttle prefers to travel in, ie what direction the animation will cause it to appear to be traveling in
	var/preferred_direction = NORTH
	/// relative direction of the docking port from the front of the shuttle. NORTH is towards front, EAST would be starboard side, WEST port, etc.
	var/port_direction = NORTH

	var/obj/docking_port/stationary/destination
	var/obj/docking_port/stationary/previous

	var/obj/docking_port/stationary/transit/assigned_transit

	var/launch_status = NOLAUNCH

	var/list/ripples = list()
	///Whether or not you want your ship to knock people down, and also whether it will throw them several tiles upon launching.
	var/list/movement_force = list(
		"KNOCKDOWN" = 3,
		"THROW" = 0,
	)

	///if this shuttle can move docking ports other than the one it is docked at
	var/can_move_docking_ports = FALSE
	var/list/hidden_turfs = list()
	///List of shuttle events that can run or are running
	var/list/datum/shuttle_event/event_list = list()

	var/admin_forced = FALSE //SKYRAT EDIT ADDITION

#define WORLDMAXX_CUTOFF (world.maxx + 1)
#define WORLDMAXY_CUTOFF (world.maxx + 1)
/**
 * Calculated and populates the information used for docking and some internal vars.
 * This can also be used to calculate from shuttle_areas so that you can expand/shrink shuttles!
 *
 * Arguments:
 * * loading_from - The template that the shuttle was loaded from, if not given we iterate shuttle_areas to calculate information instead
 */
/obj/docking_port/mobile/proc/calculate_docking_port_information(datum/map_template/shuttle/loading_from)
	var/port_x_offset = loading_from?.port_x_offset
	var/port_y_offset = loading_from?.port_y_offset
	var/width = loading_from?.width
	var/height = loading_from?.height
	if(!loading_from)
		if(!length(shuttle_areas))
			CRASH("Attempted to calculate a docking port's information without a template before it was assigned any areas!")
		// no template given, use shuttle_areas to calculate width and height
		var/min_x = -1
		var/min_y = -1
		var/max_x = WORLDMAXX_CUTOFF
		var/max_y = WORLDMAXY_CUTOFF
		for(var/area/shuttle_area as anything in shuttle_areas)
			for (var/list/zlevel_turfs as anything in shuttle_area.get_zlevel_turf_lists())
				for(var/turf/turf as anything in zlevel_turfs)
					min_x = max(turf.x, min_x)
					max_x = min(turf.x, max_x)
					min_y = max(turf.y, min_y)
					max_y = min(turf.y, max_y)
				CHECK_TICK

		if(min_x == -1 || max_x == WORLDMAXX_CUTOFF)
			CRASH("Failed to locate shuttle boundaries when iterating through shuttle areas, somehow.")
		if(min_y == -1 || max_y == WORLDMAXY_CUTOFF)
			CRASH("Failed to locate shuttle boundaries when iterating through shuttle areas, somehow.")

		width = (max_x - min_x) + 1
		height = (max_y - min_y) + 1
		port_x_offset = min_x - x
		port_y_offset = min_y - y

	if(dir in list(EAST, WEST))
		src.width = height
		src.height = width
	else
		src.width = width
		src.height = height

	switch(dir)
		if(NORTH)
			dwidth = port_x_offset - 1
			dheight = port_y_offset - 1
		if(EAST)
			dwidth = height - port_y_offset
			dheight = port_x_offset - 1
		if(SOUTH)
			dwidth = width - port_x_offset
			dheight = height - port_y_offset
		if(WEST)
			dwidth = port_y_offset - 1
			dheight = width - port_x_offset
#undef WORLDMAXX_CUTOFF
#undef WORLDMAXY_CUTOFF

/**
 * Actions to be taken after shuttle is loaded but before it has been moved out of transit z-level to its final location
 *
 * Arguments:
 * * replace - TRUE if this shuttle is replacing an existing one. FALSE by default.
 */
/obj/docking_port/mobile/register(replace = FALSE)
	. = ..()
	if(!shuttle_id)
		shuttle_id = "shuttle"

	if(!name)
		name = "shuttle"

	var/counter = SSshuttle.assoc_mobile[shuttle_id]
	if(!replace || !counter)
		if(counter)
			counter++
			SSshuttle.assoc_mobile[shuttle_id] = counter
			shuttle_id = "[shuttle_id]_[counter]"
			name = "[name] [counter]"
			//Re link machinery to new shuttle id
			linkup()
		else
			SSshuttle.assoc_mobile[shuttle_id] = 1

	SSshuttle.mobile_docking_ports += src

/**
 * Actions to be taken after shuttle is loaded and has been moved to its final location
 *
 * Arguments:
 * * replace - TRUE if this shuttle is replacing an existing one. FALSE by default.
 */
/obj/docking_port/mobile/proc/postregister(replace = FALSE)
	return

/obj/docking_port/mobile/unregister()
	. = ..()
	SSshuttle.mobile_docking_ports -= src

/obj/docking_port/mobile/Destroy(force)
	unregister()
	destination = null
	previous = null
	if(!QDELETED(assigned_transit))
		qdel(assigned_transit, force = TRUE)
		assigned_transit = null
	shuttle_areas = null
	remove_ripples()
	return ..()

/obj/docking_port/mobile/Initialize(mapload)
	. = ..()

	if(!shuttle_id)
		shuttle_id = "shuttle"
	if(!name)
		name = "shuttle"
	var/counter = 1
	var/tmp_id = shuttle_id
	var/tmp_name = name
	while(Check_id(shuttle_id))
		counter++
		shuttle_id = "[tmp_id]_[counter]"
		name = "[tmp_name] [counter]"

	var/list/all_turfs = return_ordered_turfs(x, y, z, dir)
	for(var/i in 1 to all_turfs.len)
		var/turf/curT = all_turfs[i]
		var/area/cur_area = curT.loc
		if(istype(cur_area, area_type))
			shuttle_areas[cur_area] = TRUE

	#ifdef DOCKING_PORT_HIGHLIGHT
	highlight("#0f0")
	#endif

// Called after the shuttle is loaded from template, so we make sure they know it's from mapload.
/obj/docking_port/mobile/proc/linkup(obj/docking_port/stationary/dock)
	for(var/area/place as anything in shuttle_areas)
		place.connect_to_shuttle(TRUE, src, dock)
		for(var/atom/individual_atoms in place)
			individual_atoms.connect_to_shuttle(TRUE, src, dock)

//this is a hook for custom behaviour. Maybe at some point we could add checks to see if engines are intact
/obj/docking_port/mobile/proc/canMove()
	return TRUE

//this is to check if this shuttle can physically dock at dock stationary_dock
/obj/docking_port/mobile/proc/canDock(obj/docking_port/stationary/stationary_dock)
	if(!istype(stationary_dock))
		return SHUTTLE_NOT_A_DOCKING_PORT

	if(stationary_dock.override_can_dock_checks)
		return SHUTTLE_CAN_DOCK

	if(dwidth > stationary_dock.dwidth)
		return SHUTTLE_DWIDTH_TOO_LARGE

	if(width-dwidth > stationary_dock.width-stationary_dock.dwidth)
		return SHUTTLE_WIDTH_TOO_LARGE

	if(dheight > stationary_dock.dheight)
		return SHUTTLE_DHEIGHT_TOO_LARGE

	if(height-dheight > stationary_dock.height-stationary_dock.dheight)
		return SHUTTLE_HEIGHT_TOO_LARGE

	//check the dock isn't occupied
	var/currently_docked = stationary_dock.get_docked()
	if(currently_docked)
		// by someone other than us
		if(currently_docked != src)
			return SHUTTLE_SOMEONE_ELSE_DOCKED
		else
		// This isn't an error, per se, but we can't let the shuttle code
		// attempt to move us where we currently are, it will get weird.
			return SHUTTLE_ALREADY_DOCKED

	return SHUTTLE_CAN_DOCK

/obj/docking_port/mobile/proc/check_dock(obj/docking_port/stationary/S, silent = FALSE)
	var/status = canDock(S)
	if(status == SHUTTLE_CAN_DOCK)
		return TRUE
	else
		if(status != SHUTTLE_ALREADY_DOCKED && !silent) // SHUTTLE_ALREADY_DOCKED is no cause for error
			message_admins("Shuttle [src] cannot dock at [S], error: [status]")
		// We're already docked there, don't need to do anything.
		// Triggering shuttle movement code in place is weird
		return FALSE

/obj/docking_port/mobile/proc/transit_failure()
	message_admins("Shuttle [src] repeatedly failed to create transit zone.")

/**
 * Calls the shuttle to the destination port, respecting its ignition and call timers
 *
 * Arguments:
 * * destination_port - Stationary docking port to move the shuttle to
 */
/obj/docking_port/mobile/proc/request(obj/docking_port/stationary/destination_port, forced = FALSE) // SKYRAT EDIT ADDITION - Forced check
	if(!check_dock(destination_port) && !forced) // SKYRAT EDIT ADDITION - Forced check
		testing("check_dock failed on request for [src]")
		return

	// SKYRAT EDIT START - Forced check
	if(forced)
		admin_forced = TRUE
	// SKYRAT EDIT END

	if(mode == SHUTTLE_IGNITING && destination == destination_port)
		return

	switch(mode)
		if(SHUTTLE_CALL)
			if(destination_port == destination)
				if(timeLeft(1) < callTime * engine_coeff)
					setTimer(callTime * engine_coeff)
			else
				destination = destination_port
				setTimer(callTime * engine_coeff)
		if(SHUTTLE_RECALL)
			if(destination_port == destination)
				setTimer(callTime * engine_coeff - timeLeft(1))
			else
				destination = destination_port
				setTimer(callTime * engine_coeff)
			mode = SHUTTLE_CALL
		if(SHUTTLE_IDLE, SHUTTLE_IGNITING)
			destination = destination_port
			mode = SHUTTLE_IGNITING
			// SKYRAT EDIT ADD START
			bolt_all_doors()
			play_engine_sound(src, TRUE)
			// SKYRAT EDIT ADD END
			setTimer(ignitionTime)

//recall the shuttle to where it was previously
/obj/docking_port/mobile/proc/cancel()
	if(mode != SHUTTLE_CALL)
		return

	remove_ripples()

	invertTimer()
	mode = SHUTTLE_RECALL

/obj/docking_port/mobile/proc/enterTransit()
	if((SSshuttle.lockdown && is_station_level(z)) || !canMove()) //emp went off, no escape
		mode = SHUTTLE_IDLE
		return
	previous = null
	if(!destination)
		// sent to transit with no destination -> unlimited timer
		timer = INFINITY
	var/obj/docking_port/stationary/S0 = get_docked()
	var/obj/docking_port/stationary/S1 = assigned_transit
	if(S1)
		if(initiate_docking(S1) != DOCKING_SUCCESS)
			WARNING("shuttle \"[shuttle_id]\" could not enter transit space. Docked at [S0 ? S0.shuttle_id : "null"]. Transit dock [S1 ? S1.shuttle_id : "null"].")
		else if(S0)
			if(S0.delete_after)
				qdel(S0, TRUE)
			else
				previous = S0
	else
		WARNING("shuttle \"[shuttle_id]\" could not enter transit space. S0=[S0 ? S0.shuttle_id : "null"] S1=[S1 ? S1.shuttle_id : "null"]")


/obj/docking_port/mobile/proc/jumpToNullSpace()
	// Destroys the docking port and the shuttle contents.
	// Not in a fancy way, it just ceases.
	var/obj/docking_port/stationary/current_dock = get_docked()

	var/underlying_area_type = SHUTTLE_DEFAULT_UNDERLYING_AREA
	// If the shuttle is docked to a stationary port, restore its normal
	// "empty" area and turf
	if(current_dock?.area_type)
		underlying_area_type = current_dock.area_type

	var/list/old_turfs = return_ordered_turfs(x, y, z, dir)

	var/area/underlying_area = GLOB.areas_by_type[underlying_area_type]
	if(!underlying_area)
		underlying_area = new underlying_area_type(null)

	for(var/i in 1 to old_turfs.len)
		var/turf/oldT = old_turfs[i]
		if(!oldT || !istype(oldT.loc, area_type))
			continue
		oldT.change_area(oldT.loc, underlying_area)
		oldT.empty(FALSE)

		// Here we locate the bottommost shuttle boundary and remove all turfs above it
		var/shuttle_tile_depth = oldT.depth_to_find_baseturf(/turf/baseturf_skipover/shuttle)
		if (!isnull(shuttle_tile_depth))
			oldT.ScrapeAway(shuttle_tile_depth)

	qdel(src, force=TRUE)

/**
 * Ghosts and marks as escaped (for greentext purposes) all mobs, then deletes the shuttle.
 * Used by the Shuttle Manipulator
 */
/obj/docking_port/mobile/proc/intoTheSunset()
	// Loop over mobs
	for(var/turf/turfs as anything in return_turfs())
		for(var/mob/living/sunset_mobs in turfs.get_all_contents())
			// If they have a mind and they're not in the brig, they escaped
			if(sunset_mobs.mind && !istype(get_area(sunset_mobs), /area/shuttle/escape/brig))
				sunset_mobs.mind.force_escaped = TRUE
			// Ghostize them and put them in nullspace stasis (for stat & possession checks)
			ADD_TRAIT(sunset_mobs, TRAIT_NO_TRANSFORM, REF(src))
			sunset_mobs.ghostize(FALSE)
			sunset_mobs.moveToNullspace()

	// Now that mobs are stowed, delete the shuttle
	jumpToNullSpace()

/obj/docking_port/mobile/proc/create_ripples(obj/docking_port/stationary/S1, animate_time)
	var/list/turfs = ripple_area(S1)
	for(var/t in turfs)
		ripples += new /obj/effect/abstract/ripple(t, animate_time)

/obj/docking_port/mobile/proc/remove_ripples()
	QDEL_LIST(ripples)

/obj/docking_port/mobile/proc/ripple_area(obj/docking_port/stationary/S1)
	var/list/L0 = return_ordered_turfs(x, y, z, dir)
	var/list/L1 = return_ordered_turfs(S1.x, S1.y, S1.z, S1.dir)

	var/list/ripple_turfs = list()
	var/stop = min(L0.len, L1.len)
	for(var/i in 1 to stop)
		var/turf/T0 = L0[i]
		var/turf/T1 = L1[i]
		if(!istype(T0.loc, area_type) || istype(T0.loc, /area/shuttle/transit))
			continue  // not part of the shuttle
		ripple_turfs += T1

	return ripple_turfs

/obj/docking_port/mobile/proc/check_poddoors()
	for(var/obj/machinery/door/poddoor/shuttledock/pod as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor/shuttledock))
		pod.check()

/obj/docking_port/mobile/proc/dock_id(id)
	var/port = SSshuttle.getDock(id)
	if(port)
		. = initiate_docking(port)
	else
		. = null

//used by shuttle subsystem to check timers
/obj/docking_port/mobile/proc/check()
	check_effects()
	//process_events() if you were to add events to non-escape shuttles, uncomment this

	if(mode == SHUTTLE_IGNITING)
		check_transit_zone()

	if(timeLeft(1) > 0)
		return
	// If we can't dock or we don't have a transit slot, wait for 20 ds,
	// then try again
	switch(mode)
		if(SHUTTLE_CALL, SHUTTLE_PREARRIVAL)
			if(prearrivalTime && mode != SHUTTLE_PREARRIVAL)
				mode = SHUTTLE_PREARRIVAL
				setTimer(prearrivalTime)
				return
			var/error = initiate_docking(destination, preferred_direction)
			if(error && error & (DOCKING_NULL_DESTINATION | DOCKING_NULL_SOURCE))
				var/msg = "A mobile dock in transit exited initiate_docking() with an error. This is most likely a mapping problem: Error: [error],  ([src]) ([previous][ADMIN_JMP(previous)] -> [destination][ADMIN_JMP(destination)])"
				WARNING(msg)
				message_admins(msg)
				mode = SHUTTLE_IDLE
				return
			else if(error)
				setTimer(20)
				return
			if(rechargeTime)
				mode = SHUTTLE_RECHARGING
				unbolt_all_doors() //SKYRAT EDIT ADDITION
				setTimer(rechargeTime)
				return
		if(SHUTTLE_RECALL)
			if(initiate_docking(previous) != DOCKING_SUCCESS)
				setTimer(20)
				return
		if(SHUTTLE_IGNITING)
			if(check_transit_zone() != TRANSIT_READY)
				setTimer(20)
				return
			else
				mode = SHUTTLE_CALL
				setTimer(callTime * engine_coeff)
				enterTransit()
				return

	admin_forced = FALSE //SKYRAT EDIT ADDITION
	unbolt_all_doors() //SKYRAT EDIT ADDITION
	mode = SHUTTLE_IDLE
	timer = 0
	destination = null

/obj/docking_port/mobile/proc/check_effects()
	if(!ripples.len)
		if((mode == SHUTTLE_CALL) || (mode == SHUTTLE_RECALL))
			var/tl = timeLeft(1)
			if(tl <= SHUTTLE_RIPPLE_TIME)
				create_ripples(destination, tl)
				play_engine_sound(src, FALSE) //SKYRAT EDIT ADDITION
				play_engine_sound(destination, FALSE) //SKYRAT EDIT ADDITION

	var/obj/docking_port/stationary/S0 = get_docked()
	if(istype(S0, /obj/docking_port/stationary/transit) && timeLeft(1) <= PARALLAX_LOOP_TIME)
		for(var/place in shuttle_areas)
			var/area/shuttle/shuttle_area = place
			if(shuttle_area.parallax_movedir)
				parallax_slowdown()

/obj/docking_port/mobile/proc/parallax_slowdown()
	for(var/place in shuttle_areas)
		var/area/shuttle/shuttle_area = place
		shuttle_area.parallax_movedir = FALSE
	if(assigned_transit?.assigned_area)
		assigned_transit.assigned_area.parallax_movedir = FALSE
	var/list/L0 = return_ordered_turfs(x, y, z, dir)
	for (var/thing in L0)
		var/turf/T = thing
		if(!T || !istype(T.loc, area_type))
			continue
		for (var/atom/movable/movable as anything in T)
			if (movable.client_mobs_in_contents)
				movable.update_parallax_contents()

/obj/docking_port/mobile/proc/check_transit_zone()
	if(assigned_transit)
		return TRANSIT_READY
	else
		SSshuttle.request_transit_dock(src)

/obj/docking_port/mobile/proc/setTimer(wait)
	timer = world.time + wait
	last_timer_length = wait

/obj/docking_port/mobile/proc/modTimer(multiple)
	var/time_remaining = timer - world.time
	if(time_remaining < 0 || !last_timer_length)
		return
	time_remaining *= multiple
	last_timer_length *= multiple
	setTimer(time_remaining)

/obj/docking_port/mobile/proc/alert_coeff_change(new_coeff)
	if(isnull(new_coeff))
		return

	var/time_multiplier = new_coeff / alert_coeff
	var/time_remaining = timer - world.time
	if(time_remaining < 0 || !last_timer_length)
		return

	time_remaining *= time_multiplier
	last_timer_length *= time_multiplier
	alert_coeff = new_coeff
	setTimer(time_remaining)

/obj/docking_port/mobile/proc/invertTimer()
	if(!last_timer_length)
		return
	var/time_remaining = timer - world.time
	if(time_remaining > 0)
		var/time_passed = last_timer_length - time_remaining
		setTimer(time_passed)

//returns timeLeft
/obj/docking_port/mobile/proc/timeLeft(divisor)
	if(divisor <= 0)
		divisor = 10

	var/ds_remaining
	if(!timer)
		ds_remaining = callTime * engine_coeff
	else
		ds_remaining = max(0, timer - world.time)

	. = round(ds_remaining / divisor, 1)

// returns 3-letter mode string, used by status screens and mob status panel
/obj/docking_port/mobile/proc/getModeStr()
	switch(mode)
		if(SHUTTLE_IGNITING)
			return "IGN"
		if(SHUTTLE_RECALL)
			return "RCL"
		if(SHUTTLE_CALL)
			return "ETA"
		if(SHUTTLE_DOCKED)
			return "ETD"
		if(SHUTTLE_ESCAPE)
			return "ESC"
		if(SHUTTLE_STRANDED)
			return "ERR"
		if(SHUTTLE_RECHARGING)
			return "RCH"
		if(SHUTTLE_PREARRIVAL)
			return "LDN"
		if(SHUTTLE_DISABLED)
			return "DIS"
	return ""

// returns 5-letter timer string, used by status screens and mob status panel
/obj/docking_port/mobile/proc/getTimerStr()
	if(mode == SHUTTLE_STRANDED || mode == SHUTTLE_DISABLED)
		return "--:--"

	var/timeleft = timeLeft()
	if(timeleft > 1 HOURS)
		return "--:--"
	else if(timeleft > 0)
		return "[add_leading(num2text((timeleft / 60) % 60), 2, "0")]:[add_leading(num2text(timeleft % 60), 2, "0")]"
	else
		return "00:00"

/**
 * Gets shuttle location status in a form of string for tgui interfaces
 */
/obj/docking_port/mobile/proc/get_status_text_tgui()
	var/obj/docking_port/stationary/dockedAt = get_docked()
	var/docked_at = dockedAt?.name || "Unknown"
	if(!istype(dockedAt, /obj/docking_port/stationary/transit))
		return docked_at
	if(timeLeft() > 1 HOURS)
		return "Hyperspace"
	else
		var/obj/docking_port/stationary/dst = (mode == SHUTTLE_RECALL) ? previous : destination
		return "In transit to [dst?.name || "unknown location"]"

/obj/docking_port/mobile/proc/getStatusText()
	var/obj/docking_port/stationary/dockedAt = get_docked()
	var/docked_at = dockedAt?.name || "unknown"
	if(istype(dockedAt, /obj/docking_port/stationary/transit))
		if (timeLeft() > 1 HOURS)
			return "hyperspace"
		else
			var/obj/docking_port/stationary/dst
			if(mode == SHUTTLE_RECALL)
				dst = previous
			else
				dst = destination
			. = "transit towards [dst?.name || "unknown location"] ([getTimerStr()])"
	else if(mode == SHUTTLE_RECHARGING)
		return "[docked_at], recharging [getTimerStr()]"
	else
		return docked_at

/obj/docking_port/mobile/proc/getDbgStatusText()
	var/obj/docking_port/stationary/dockedAt = get_docked()
	. = (dockedAt?.name) ? dockedAt.name : "unknown"
	if(istype(dockedAt, /obj/docking_port/stationary/transit))
		var/obj/docking_port/stationary/dst
		if(mode == SHUTTLE_RECALL)
			dst = previous
		else
			dst = destination
		if(dst)
			. = "(transit to) [dst.name || dst.shuttle_id]"
		else
			. = "(transit to) nowhere"
	else if(dockedAt)
		. = dockedAt.name || dockedAt.shuttle_id
	else
		. = "unknown"


// attempts to locate /obj/machinery/computer/shuttle with matching ID inside the shuttle
/obj/docking_port/mobile/proc/get_control_console()
	for(var/area/shuttle/shuttle_area as anything in shuttle_areas)
		var/obj/machinery/computer/shuttle/shuttle_computer = locate(/obj/machinery/computer/shuttle) in shuttle_area
		if(!shuttle_computer)
			continue
		if(shuttle_computer.shuttleId == shuttle_id)
			return shuttle_computer
	return null

/obj/docking_port/mobile/proc/hyperspace_sound(phase, list/areas)
	var/selected_sound
	switch(phase)
		if(HYPERSPACE_WARMUP)
			selected_sound = "hyperspace_begin"
		if(HYPERSPACE_LAUNCH)
			selected_sound = "hyperspace_progress"
		if(HYPERSPACE_END)
			selected_sound = "hyperspace_end"
		else
			CRASH("Invalid hyperspace sound phase: [phase]")
	// This previously was played from each door at max volume, and was one of the worst things I had ever seen.
	// Now it's instead played from the nearest engine if close, or the first engine in the list if far since it doesn't really matter.
	// Or a door if for some reason the shuttle has no engine, fuck oh hi daniel fuck it
	var/range = (engine_coeff * max(width, height))
	var/long_range = range * 2.5
	var/atom/distant_source

	if(engine_list.len)
		distant_source = engine_list[1]
	else
		for(var/our_area in areas)
			distant_source = locate(/obj/machinery/door) in our_area
			if(distant_source)
				break

	if(!distant_source)
		return
	for(var/mob/zlevel_mobs as anything in SSmobs.clients_by_zlevel[z])
		var/dist_far = get_dist(zlevel_mobs, distant_source)
		if(dist_far <= long_range && dist_far > range)
			zlevel_mobs.playsound_local(distant_source, "sound/runtime/hyperspace/[selected_sound]_distance.ogg", 100)
		else if(dist_far <= range)
			var/source
			if(!engine_list.len)
				source = distant_source
			else
				var/closest_dist = 10000
				for(var/obj/machinery/power/shuttle_engine/engines as anything in engine_list)
					var/dist_near = get_dist(zlevel_mobs, engines)
					if(dist_near < closest_dist)
						source = engines
						closest_dist = dist_near
			zlevel_mobs.playsound_local(source, "sound/runtime/hyperspace/[selected_sound].ogg", 100)

// Losing all initial engines should get you 2
// Adding another set of engines at 0.5 time
/obj/docking_port/mobile/proc/alter_engines(mod)
	if(!mod)
		return
	var/old_coeff = engine_coeff
	engine_coeff = get_engine_coeff(mod)
	current_engine_power = max(0, current_engine_power + mod)
	if(in_flight())
		var/delta_coeff = engine_coeff / old_coeff
		modTimer(delta_coeff)

// Double initial engines to get to 0.5 minimum
// Lose all initial engines to get to 2
//For 0 engine shuttles like BYOS 5 engines to get to doublespeed
/obj/docking_port/mobile/proc/get_engine_coeff(engine_mod)
	var/new_value = max(0, current_engine_power + engine_mod)
	if(new_value == initial_engine_power)
		return 1
	if(new_value > initial_engine_power)
		var/delta = new_value - initial_engine_power
		var/change_per_engine = (1 - ENGINE_COEFF_MIN) / ENGINE_DEFAULT_MAXSPEED_ENGINES // 5 by default
		if(initial_engine_power > 0)
			change_per_engine = (1 - ENGINE_COEFF_MIN) / initial_engine_power // or however many it had
		return clamp(1 - delta * change_per_engine,ENGINE_COEFF_MIN, ENGINE_COEFF_MAX)
	if(new_value < initial_engine_power)
		var/delta = initial_engine_power - new_value
		var/change_per_engine = 1 //doesn't really matter should not be happening for 0 engine shuttles
		if(initial_engine_power > 0)
			change_per_engine = (ENGINE_COEFF_MAX - 1) / initial_engine_power //just linear drop to max delay
		return clamp(1 + delta * change_per_engine, ENGINE_COEFF_MIN, ENGINE_COEFF_MAX)


/obj/docking_port/mobile/proc/in_flight()
	switch(mode)
		if(SHUTTLE_CALL,SHUTTLE_RECALL,SHUTTLE_PREARRIVAL)
			return TRUE
		if(SHUTTLE_IDLE,SHUTTLE_IGNITING)
			return FALSE
	return FALSE // hmm

/obj/docking_port/mobile/emergency/in_flight()
	switch(mode)
		if(SHUTTLE_ESCAPE)
			return TRUE
		if(SHUTTLE_STRANDED,SHUTTLE_ENDGAME)
			return FALSE
	return ..()

//Called when emergency shuttle leaves the station
/obj/docking_port/mobile/proc/on_emergency_launch()
	if(launch_status == UNLAUNCHED) //Pods will not launch from the mine/planet, and other ships won't launch unless we tell them to.
		launch_status = ENDGAME_LAUNCHED
		enterTransit()

///Let people know shits about to go down
/obj/docking_port/mobile/proc/announce_shuttle_events()
	for(var/datum/shuttle_event/event as anything in event_list)
		notify_ghosts("The [name] has selected: [event.name]")

/obj/docking_port/mobile/emergency/on_emergency_launch()
	return

//Called when emergency shuttle docks at centcom
/obj/docking_port/mobile/proc/on_emergency_dock()
	// Mapping a new docking point for each ship mappers could potentially want docking with centcom would take up lots of space,
	// just let them keep flying off "into the sunset" for their greentext.
	if(launch_status == ENDGAME_LAUNCHED)
		launch_status = ENDGAME_TRANSIT

/obj/docking_port/mobile/pod/on_emergency_dock()
	if(launch_status == ENDGAME_LAUNCHED)
		initiate_docking(SSshuttle.getDock("[shuttle_id]_away")) //Escape pods dock at centcom
		mode = SHUTTLE_ENDGAME

/obj/docking_port/mobile/emergency/on_emergency_dock()
	return

///Process all the shuttle events for every shuttle tick we get
/obj/docking_port/mobile/proc/process_events()
	var/list/removees
	for(var/datum/shuttle_event/event as anything in event_list)
		if(event.event_process() == SHUTTLE_EVENT_CLEAR) //if we return SHUTTLE_EVENT_CLEAR, we clean them up
			LAZYADD(removees, event)
	for(var/item in removees)
		event_list.Remove(item)

#ifdef TESTING
#undef DOCKING_PORT_HIGHLIGHT
#endif
