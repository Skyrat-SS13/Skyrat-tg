GLOBAL_LIST_EMPTY(drone_control_nodes)

#define DRONE_MODE_PATROL "patrol"
#define DRONE_MODE_ATTACK "attack"
#define DRONE_MODE_IDLE "idle"
#define DRONE_MODE_AVOIDING "avoiding"

/**
 * Drones
 *
 * Drones are a new type of space fairing enemy. They are hostile and will shoot you on sight.
 *
 * They are also able to patrol a set of patrol nodes, and will return to their control node if they lose their target.
 */
/obj/drone
	name = "drone"
	desc = "A mindless drone out to kill you."
	icon = 'modular_skyrat/modules/spacepods/icons/pod1x1.dmi'
	icon_state = "drone"
	density = TRUE
	opacity = FALSE
	dir = NORTH
	max_integrity = 100
	/// The angle of our component
	var/component_angle = 0
	/// The target that we are going towards.
	var/atom/movable/target_atom
	/// Are we dodging an obstacle?
	var/is_avoiding_obstacle = FALSE
	/// A list of friendly factions.
	var/list/friendly_factions = list(FACTION_ROGUE_DRONE)
	/// A list of target types that we will target.
	var/list/target_types = list(
		/obj/spacepod,
		/mob/living,
		/obj/drone,
		/obj/vehicle/sealed/mecha,
	)
	/// Our current node.
	var/obj/effect/abstract/drone_patrol_node/current_node
	/// Our control node.
	var/obj/effect/abstract/drone_control_node/control_node
	/// Do we patrol?
	var/patrol_enabled = TRUE
	/// Our patrol ID, used for patrol beacons.
	var/patrol_id = "default"
	/// Our detection range.
	var/detection_range = 12
	/// The projectile we fire.
	var/obj/projectile/projectile_type = /obj/projectile/beam/laser
	/// The sound we play when we fire.
	var/fire_sound = 'sound/weapons/pulse3.ogg'
	/// Our reload time.
	var/reload_time = 2 SECONDS
	/// The minimum distance at which we can fire at a target.
	var/min_fire_distance = 3

	COOLDOWN_DECLARE(reload_cooldown)

	/// A list of mode speeds
	var/list/mode_speeds = list(
		DRONE_MODE_PATROL = 1,
		DRONE_MODE_ATTACK = 3,
		DRONE_MODE_IDLE = 1,
		DRONE_MODE_AVOIDING = 2,
	)
	/// What is our current mode?
	var/mode = DRONE_MODE_IDLE

	/// What is our target distance from the target?
	var/engage_distance = 3

	/// Our follow trail
	var/datum/effect_system/trail_follow/ion/grav_allowed/trail


/obj/drone/Initialize()
	. = ..()
	// Attach the physics component to the drone
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics, _max_velocity_x = mode_speeds[mode], _max_velocity_y = mode_speeds[mode], _thrust_check_required = FALSE, _stabilisation_check_required = FALSE, _reset_thrust_dir = FALSE)
	// Set the desired thrust direction to forward
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_FORWARD)
	// Register the signal to trigger the process_bump() proc
	RegisterSignal(physics_component, COMSIG_PHYSICS_PROCESSED_BUMP, PROC_REF(process_bump))
	RegisterSignal(physics_component, COMSIG_PHYSICS_UPDATE_MOVEMENT, PROC_REF(physics_update_movement))
	// Start the movement loop if the drone has a target

	START_PROCESSING(SSphysics, src)

	trail = new(src)
	trail.set_up(src)
	trail.start()

/obj/drone/Destroy()
	// Stop the movement loop when the drone is destroyed
	STOP_PROCESSING(SSphysics, src)
	current_node = null
	control_node = null
	target_atom = null
	QDEL_NULL(trail)
	return ..()

/obj/drone/process()
	switch(mode)
		if(DRONE_MODE_AVOIDING) // We are avoiding an obstacle
			return

		if(DRONE_MODE_ATTACK) // We are attacking a target
			process_attack()

		if(DRONE_MODE_IDLE) // We are idle
			if(!find_target(detection_range) && patrol_enabled)
				start_patrol()

		if(DRONE_MODE_PATROL) // We are patrolling
			if(!find_target(detection_range) && patrol_enabled)
				process_patrol()


/obj/drone/atom_break(damage_flag)
	. = ..()
	explosion(src, 0, 0, 2, 3)

/**
 * process_attack
 *
 * Process the attack mode, calculate all that good stuff and FIRE.
 */
/obj/drone/proc/process_attack()
	if(!target_atom)
		lose_target()
		return

	var/distance_to_target = get_dist(src, target_atom)
	if(distance_to_target > detection_range || !check_target(target_atom))
		lose_target()
		return

	if(distance_to_target > engage_distance)
		go_to(target_atom)
	else if(distance_to_target < engage_distance)
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, get_angle(src, target_atom))
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_BACKWARDS)
	else
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, get_angle(src, target_atom))
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_STOP)

	if(distance_to_target <= min_fire_distance && COOLDOWN_FINISHED(src, reload_cooldown))
		// We are in range, so we can shoot
		shoot_at(target_atom)
		COOLDOWN_START(src, reload_cooldown, reload_time)

	go_to(target_atom)

/**
 * shoot_at
 *
 * Fires our projectile type at a set target while also making noise!
 */
/obj/drone/proc/shoot_at(atom/movable/target)
	var/turf/our_turf = get_turf(src)
	var/obj/projectile/projectile = new projectile_type(our_turf)
	projectile.starting = our_turf
	projectile.firer = src
	projectile.def_zone = CHEST
	projectile.original = target
	projectile.fire(component_angle)

	playsound(src, fire_sound, 50, TRUE)

/**
 * go_to
 *
 * Automatically paths the drone to a select atom.
 */
/obj/drone/proc/go_to(atom/movable/target)
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, get_angle(src, target))
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_FORWARD)

/**
 * start_patrol
 *
 * Starts the patrol mode.
 */
/obj/drone/proc/start_patrol()
	switch_mode(DRONE_MODE_PATROL)
	balloon_alert_to_viewers("PATROL MODE: Engaging.")
	process_patrol()

/**
 * switch_mode
 *
 * Switches the drone's mode.
 */
/obj/drone/proc/switch_mode(new_mode)
	mode = new_mode
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_MAX_VELOCITY, mode_speeds[mode], mode_speeds[mode])

/**
 * process_patrol
 *
 * Processes patrolling and automatically moves between patrol nodes.
 */
/obj/drone/proc/process_patrol()
	if(!control_node)
		find_control_node()
		return

	if(!current_node)
		current_node = control_node.get_random_node()
		return

	if(get_dist(src, current_node) < 1) // We are on top of it
		current_node = current_node.next_node
		balloon_alert_to_viewers("PATROL MODE: Moving to next node.")

	go_to(current_node)

/**
 * find_control_node
 *
 * Finds the control node for the drone to use.
 */
/obj/drone/proc/find_control_node()
	if(!LAZYLEN(GLOB.drone_control_nodes))
		return
	for(var/obj/effect/abstract/drone_control_node/iterating_control_node in GLOB.drone_control_nodes)
		if(iterating_control_node.patrol_id == patrol_id)
			control_node = iterating_control_node
			return


/**
 * process_bump
 *
 * Handles the drone bumping into something.
 */
/obj/drone/proc/process_bump()
	SIGNAL_HANDLER
	// When the drone bumps into something, change the desired angle to the opposite direction for a short duration
	if(mode != DRONE_MODE_AVOIDING)
		switch_mode(DRONE_MODE_AVOIDING)
		var/opposite_angle = (component_angle + 180) % 360
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, opposite_angle)
		addtimer(CALLBACK(src, PROC_REF(finish_avoiding_obstacle)), 0.5 SECONDS)
		balloon_alert_to_viewers("AVOIDING OBSTACLE")

/**
 * finish_avoiding_obstacle
 *
 * Finishes the obstacle avoidance process.
 */
/obj/drone/proc/finish_avoiding_obstacle()
	switch_mode(DRONE_MODE_IDLE)
	balloon_alert_to_viewers("AVOIDANCE COMPLETE")

/**
 * set_target
 *
 * Sets the target that the drone will move towards.
 */
/obj/drone/proc/set_target(atom/movable/target_to_set)
	target_atom = target_to_set
	switch_mode(DRONE_MODE_ATTACK)
	balloon_alert_to_viewers("TARGET ACQUIRED: [target_to_set.name]")
	RegisterSignal(target_to_set, COMSIG_PARENT_QDELETING, PROC_REF(lose_target))

/**
 * lose_target
 *
 * Removes the target from the drone.
 */
/obj/drone/proc/lose_target()
	target_atom = null
	switch_mode(DRONE_MODE_IDLE)
	balloon_alert_to_viewers("TARGET LOST")

/**
 * physics_update_movement
 *
 * Updates the drone's component angle.
 */
/obj/drone/proc/physics_update_movement(datum/source, updated_angle, updated_velocity_x, updated_velocity_y, updated_offset_x, updated_offset_y, updated_last_rotate, updated_last_thrust_forward, updated_last_thrust_right)
	SIGNAL_HANDLER
	component_angle = updated_angle

/**
 * find_target
 *
 * Finds the closest target in range.
 */
/obj/drone/proc/find_target(range)
	var/min_distance = INFINITY
	var/atom/movable/closest_atom
	for(var/atom/movable/iterating_atom in view(range, src))
		if(!check_target(iterating_atom))
			continue
		var/distance = get_dist(src, iterating_atom)
		if(distance < min_distance)
			min_distance = distance
			closest_atom = iterating_atom
	if(closest_atom)
		set_target(closest_atom)
		return TRUE
	return FALSE

/**
 * check_target
 *
 * Checks if the target is valid.
 */
/obj/drone/proc/check_target(target_to_check)
	if(!is_type_in_list(target_to_check, target_types))
		return FALSE

	// Living checks
	if(isliving(target_to_check))
		var/mob/living/target_mob = target_to_check
		if(target_mob.stat != CONSCIOUS)
			return FALSE // No ultra dead people pls.
		if(faction_check(target_mob.faction, friendly_factions))
			return FALSE
		return TRUE

	// Drone checks
	if(istype(target_to_check, /obj/drone))
		var/obj/drone/target_drone = target_to_check
		if(faction_check(target_drone.friendly_factions, friendly_factions))
			return FALSE
		return TRUE

	// Spacepod checks
	if(istype(target_to_check, /obj/spacepod))
		var/obj/spacepod/target_spacepod = target_to_check
		if(faction_check(target_spacepod.get_factions(), friendly_factions))
			return FALSE
		return TRUE

	// Mecha checks
	if(ismecha(target_to_check))
		var/obj/vehicle/sealed/mecha/target_mecha = target_to_check
		for(var/occupant in target_mecha.occupants)
			var/mob/living/living_occupant = occupant
			if(faction_check(living_occupant.faction, friendly_factions))
				return FALSE
		return TRUE

	return TRUE

// PATROL SYSTEMS

/**
 * Drone patrol paths
 *
 * These are used to create a sort of "patrol path" for the drones to follow.
 * To create a patrol path, you must place a drone patrol node on the map,
 * and then set the patrol_id of the node to the same value as the other nodes in the patrol path.
 *
 * They must be within 5 tiles of eachother.
 *
 * A drone control node must be placed on the map, and the patrol_id of the node must be set to the same value as the patrol nodes to create a full patrol path.
 */


/**
 * Control Node
 *
 * A control node must be placed nearby other patrol nodes. This control node will initate and create the patrol path.
 */
/obj/effect/abstract/drone_control_node
	name = "drone control node"
	icon_state = "m_shield"
	color = COLOR_RED
	var/patrol_id = "default"
	var/list/patrol_nodes = list()
	var/obj/effect/abstract/drone_patrol_node/next_node
	var/node_connection_range = 20

/obj/effect/abstract/drone_control_node/Initialize(mapload)
	. = ..()
	setup_patrol_path()
	GLOB.drone_control_nodes += src
	if(!LAZYLEN(patrol_nodes))
		stack_trace("No patrol nodes found for control node [src] with patrol_id [patrol_id]!")
		return INITIALIZE_HINT_QDEL

/obj/effect/abstract/drone_control_node/Destroy()
	QDEL_LIST(patrol_nodes)
	next_node = null
	GLOB.drone_control_nodes -= src
	return ..()


/**
 * connect_node
 *
 * Connects a node to the control node.
 */
/obj/effect/abstract/drone_control_node/proc/connect_node(obj/effect/abstract/drone_patrol_node/node_to_connect)
	LAZYADD(patrol_nodes, node_to_connect)
	node_to_connect.control_node = src
	RegisterSignal(node_to_connect, COMSIG_PARENT_QDELETING, PROC_REF(disconnect_node))

/**
 * disconnect_node
 *
 * Disconnects a node from the control node.
 */
/obj/effect/abstract/drone_control_node/proc/disconnect_node(obj/effect/abstract/drone_patrol_node/node_to_disconnect)
	SIGNAL_HANDLER
	patrol_nodes -= node_to_disconnect

/**
 * setup_patrol_path
 *
 * Sets up the patrol path for the control node.
 */
/obj/effect/abstract/drone_control_node/proc/setup_patrol_path()
	var/min_distance = INFINITY
	var/obj/effect/abstract/drone_patrol_node/closest_node
	for(var/obj/effect/abstract/drone_patrol_node/iterating_node in range(node_connection_range, src))
		if(iterating_node.patrol_id != patrol_id)
			continue
		var/distance = get_dist(src, iterating_node)
		if(distance < min_distance)
			min_distance = distance
			closest_node = iterating_node
	if(closest_node)
		set_start_node(closest_node)


/**
 * set_start_node
 *
 * Sets the starting node for the patrol path.
 */
/obj/effect/abstract/drone_control_node/proc/set_start_node(obj/effect/abstract/drone_patrol_node/starting_node)
	connect_node(starting_node)
	next_node = starting_node
	next_node.control_node = src
	next_node.find_closest_node()

/**
 * get_random_node
 *
 * Returns a random node from the patrol path.
 */
/obj/effect/abstract/drone_control_node/proc/get_random_node()
	return pick(patrol_nodes)


/**
 * Patrol Node
 *
 * A patrol node is a node that the drone will move to.
 */
/obj/effect/abstract/drone_patrol_node
	name = "drone patrol node"
	icon_state = "m_shield"
	var/patrol_id = "default"
	/// The control node that this node is connected to.
	var/obj/effect/abstract/drone_control_node/control_node
	/// The next node in the patrol path.
	var/obj/effect/abstract/drone_patrol_node/next_node

	var/node_connection_range = 20

/**
 * find_closest_node
 *
 * Finds the closest node to the current node.
 */
/obj/effect/abstract/drone_patrol_node/proc/find_closest_node()
	var/min_distance = INFINITY
	var/obj/effect/abstract/drone_patrol_node/closest_node
	for(var/obj/effect/abstract/drone_patrol_node/iterating_node in range(node_connection_range, src))
		if(iterating_node == src)
			continue
		if(iterating_node in control_node.patrol_nodes)
			continue
		if(iterating_node.patrol_id != patrol_id)
			continue
		var/distance = get_dist(src, iterating_node)
		if(distance < min_distance)
			min_distance = distance
			closest_node = iterating_node
	if(closest_node)
		set_next_node(closest_node)
	else
		next_node = control_node // OK, we seem to be at the end of our nodes, so we'll just go back to the control node.
		color = COLOR_GREEN
		Beam(control_node)

/**
 * set_next_node
 *
 * Sets the next node to the given node.
 */
/obj/effect/abstract/drone_patrol_node/proc/set_next_node(obj/effect/abstract/drone_patrol_node/node_to_set)
	next_node = node_to_set
	control_node.connect_node(node_to_set)
	node_to_set.find_closest_node()
	color = COLOR_GREEN
	Beam(node_to_set)




