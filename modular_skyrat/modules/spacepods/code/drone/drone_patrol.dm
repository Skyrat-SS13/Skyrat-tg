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
	/// Our patrol ID
	var/patrol_id = DRONE_PATROL_ID_DEFAULT
	/// A list of nodes that we currently control.
	var/list/patrol_nodes = list()
	/// The next node in the patrol path.
	var/obj/effect/abstract/drone_patrol_node/next_node
	/// The max range at which we can connect.
	var/node_connection_range = 30

/obj/effect/abstract/drone_control_node/Initialize(mapload)
	. = ..()
	setup_patrol_path()
	for(var/obj/effect/abstract/drone_control_node/iterating_control_node as anything in GLOB.drone_control_nodes)
		if(iterating_control_node.patrol_id == patrol_id)
			stack_trace("Duplicate patrol ID found for control node [src] with patrol_id [patrol_id]!")
	GLOB.drone_control_nodes += src

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
	starting_node.control_node = src
	starting_node.find_closest_node()

/**
 * get_closest_node
 *
 * Returns the closest node to a drone in the patrol system.
 */
/obj/effect/abstract/drone_control_node/proc/get_closest_node(obj/drone/checking_drone)
	var/min_distance = INFINITY
	var/obj/effect/abstract/drone_patrol_node/closest_node
	for(var/obj/effect/abstract/drone_patrol_node/iterating_node as anything in patrol_nodes)
		var/distance = get_dist(checking_drone, iterating_node)
		if(distance < min_distance)
			min_distance = distance
			closest_node = iterating_node
	return closest_node


/**
 * Patrol Node
 *
 * A patrol node is a node that the drone will move to.
 */
/obj/effect/abstract/drone_patrol_node
	name = "drone patrol node"
	icon_state = "m_shield"
	/// Our patrol ID, used for lookup.
	var/patrol_id = DRONE_PATROL_ID_DEFAULT
	/// The control node that this node is connected to.
	var/obj/effect/abstract/drone_control_node/control_node
	/// The next node in the patrol path.
	var/obj/effect/abstract/drone_patrol_node/next_node

	var/node_connection_range = 30

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
		control_node.Beam(src)

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
	node_to_set.Beam(src)
