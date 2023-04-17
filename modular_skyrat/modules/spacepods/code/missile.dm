/**
 * Missiles
 *
 * These missiles use the physics component to simulate a rocket engine with payload.
 *
 * Given these are missiles and not rockets, they have capabilities to seek towards things.
 */
/obj/physics_missile
	name = "missile"
	desc = "A heat seeking missile."
	icon = 'modular_skyrat/modules/spacepods/icons/objects.dmi'
	icon_state = "missile"
	density = TRUE
	opacity = FALSE
	dir = NORTH
	max_integrity = 10
	/// The amount of thrust power we have.
	var/max_forward_thrust = 10
	var/component_angle = 0
	var/component_velocity_x = 0
	var/component_velocity_y = 0
	var/auto_target
	var/auto_target_range = 10
	var/list/auto_target_targets = list(
		/mob/living,
		/obj/spacepod,
		/obj/vehicle,
	)
	/// Our target, if any.
	var/atom/target
	/// Are we firing the thrusters?
	var/thruster_on = FALSE
	/// How much tolerance we give
	var/angle_tolerance = 0
	/// What angle do we disable the thruster
	var/thruster_disable_threshold = 30
	/// Our looping thrust sound.
	var/datum/looping_sound/rocket_thrust/rocket_sound
	/// The type that we will actually go after.
	var/target_type = /mob/living
	/// Is this the first time we have launched, play a sound effect.
	var/first_launch = TRUE
	/// How big the payload size is. EX calculations used for the list.
	var/list/payload_size = list(0, 0, 3, 4)
	/// How much time do we push forwards before ignition?
	var/initial_forwards_time = 0.1 SECONDS
	/// Who fired us, used for targeting checks
	var/mob/firer
	/// Do we check factions when firing?
	var/check_factions = FALSE
	/// A list of factions we ignore for targeting.
	var/list/friendly_factions
	/// Have we completed our ignition?
	var/initial_ignition_complete = TRUE

/obj/physics_missile/Initialize(mapload, start_angle, start_velocity_x, start_velocity_y, start_offset_x, start_offset_y, target_to_set, ignition_time, incoming_firer, incoming_faction_check, list/incoming_factions)
	. = ..()
	rocket_sound = new(src)
	// Attach the physics component to the physics_missile
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics, max_forward_thrust, _thrust_check_required = FALSE, _stabilisation_check_required = FALSE, _reset_thrust_dir = FALSE, starting_angle = start_angle, starting_velocity_x = start_velocity_x, starting_velocity_y = start_velocity_y, _takes_atmos_damage = FALSE)

	// Register the signal to trigger the process_bump() proc
	RegisterSignal(physics_component, COMSIG_PHYSICS_PROCESSED_BUMP, PROC_REF(explode))
	RegisterSignal(physics_component, COMSIG_PHYSICS_UPDATE_MOVEMENT, PROC_REF(physics_update_movement))

	physics_component.offset_x = start_offset_x
	physics_component.offset_y = start_offset_y

	check_factions = incoming_faction_check

	friendly_factions = incoming_factions

	if(incoming_firer)
		firer = incoming_firer
		RegisterSignal(incoming_firer, COMSIG_PARENT_QDELETING, PROC_REF(clear_firer))

	if(target_to_set && target_check(target_to_set))
		set_target(target_to_set)

	if(ignition_time)
		initial_ignition_complete = FALSE
		if(ignition_time > initial_forwards_time)
			addtimer(CALLBACK(src, PROC_REF(cut_initial_thrust)), ignition_time)
			SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_FORWARD)
		addtimer(CALLBACK(src, PROC_REF(ignite)), ignition_time)

	START_PROCESSING(SSphysics, src)

/obj/physics_missile/Bumped(atom/movable/bumped_atom)
	. = ..()
	explode()

/obj/physics_missile/proc/clear_firer(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(firer, COMSIG_PARENT_QDELETING)
	firer = null


/obj/physics_missile/proc/cut_initial_thrust()
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, 0)

/obj/physics_missile/proc/ignite()
	initial_ignition_complete = TRUE

/obj/physics_missile/Destroy()
	rocket_sound.stop()
	QDEL_NULL(rocket_sound)
	// Stop the movement loop when the physics_missile is destroyed
	STOP_PROCESSING(SSphysics, src)
	if(target)
		lose_target(target)
	return ..()

/obj/physics_missile/process()
	if(!initial_ignition_complete)
		return
	// If the physics_missile has a target and is not avoiding an obstacle, update the desired angle to point towards it
	if(target)
		calculate_target_angle()
	else if(auto_target)
		find_target()

/obj/physics_missile/update_overlays()
	. = ..()
	if(thruster_on)
		. += "[icon_state]_thrust_overlay"


/obj/physics_missile/proc/explode()
	SIGNAL_HANDLER
	explosion(src, payload_size[1], payload_size[2], payload_size[3], payload_size[4])
	qdel(src)

/obj/physics_missile/proc/set_target(atom/target_to_set)
	if(!target_to_set)
		return
	target = target_to_set
	RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(lose_target))
	SEND_SIGNAL(target, COMSIG_MISSILE_LOCK, src)

/obj/physics_missile/proc/lose_target(atom/lost_target)
	SIGNAL_HANDLER
	if(target)
		SEND_SIGNAL(target, COMSIG_MISSILE_LOCK_LOST, src)
		UnregisterSignal(target, COMSIG_PARENT_QDELETING)
		target = null

/**
 * physics_update_movement
 *
 * Called when our physics component moves.
 */
/obj/physics_missile/proc/physics_update_movement(datum/source, updated_angle, updated_velocity_x, updated_velocity_y, updated_offset_x, updated_offset_y, updated_last_rotate, updated_last_thrust_forward, updated_last_thrust_right)
	SIGNAL_HANDLER
	component_angle = updated_angle
	component_velocity_x = updated_velocity_x
	component_velocity_y = updated_velocity_y
	if(initial_ignition_complete)
		calculate_target_angle()

/**
 * calculate_target_angle
 *
 * Calculates the angle between the target and ourselves, then we update our physics component to said angle.
 */
/obj/physics_missile/proc/calculate_target_angle()
	if(!target)
		return

	var/new_angle = get_angle(src, target)
	var/angle_diff = abs(new_angle - component_angle)

	if(angle_diff > 180)
		angle_diff = 360 - angle_diff

	if(angle_diff > angle_tolerance)
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, new_angle)

	if(angle_diff > thruster_disable_threshold)
		if(thruster_on)
			toggle_thruster(FALSE)
	else
		if(!thruster_on)
			toggle_thruster(TRUE)

/**
 * toggle_thruster
 *
 * Toggles the missile thruster on or off, while also dealing with effects.
 */
/obj/physics_missile/proc/toggle_thruster(toggle)
	thruster_on = toggle
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, toggle ? THRUST_DIR_FORWARD : 0)
	if(toggle)
		if(first_launch)
			playsound(src, 'modular_skyrat/modules/spacepods/sound/rocket_fire.ogg', 100)
			first_launch = FALSE
		rocket_sound.start()
	else
		rocket_sound.stop()
	update_appearance()

/**
 * find_target
 *
 * Finds a target within a specific range while also checking said target.
 */
/obj/physics_missile/proc/find_target()
	var/min_distance = INFINITY
	var/closest_object
	for(var/iterating_target in view(auto_target_range, src))

		if(!target_check(iterating_target))
			continue
		var/distance = get_dist(src, iterating_target)
		if(distance < min_distance)
			min_distance = distance
			closest_object = iterating_target
	if(closest_object)
		set_target(closest_object)

/**
 * target_check
 *
 * Performs checks on a target, returns TRUE if they pass or FALSE if they dont, thus targeting the target.
 */
/obj/physics_missile/proc/target_check(target)
	if(!is_type_in_list(target, auto_target_targets))
		return FALSE

	if(firer && target == firer)
		return FALSE

	if(isliving(target))
		var/mob/living/living_target = target
		if(check_factions && friendly_factions && faction_check(friendly_factions, living_target.faction))
			return FALSE
		if(living_target.stat != CONSCIOUS)
			return FALSE

	if(isspacepod(target) && check_factions)
		var/obj/spacepod/target_spacepod = target
		if(faction_check(target_spacepod.get_factions(), target))
			return FALSE

	return TRUE


/**
 * lead_angle seeking missile
 *
 * This missile uses a basic form of lead angle targeting. Requies the target to have a physics component.
 */
/obj/physics_missile/lead_angle
	name = "lead angle targeting missile"
	icon_state = "medium_missile"
	payload_size = list(0, 2, 3, 4)

/**
 * lead angle calculation
 */
/obj/physics_missile/lead_angle/calculate_target_angle()
	if(!target)
		return

	// Calculate the relative velocity of the target
	var/datum/component/physics/target_physics = target.GetComponent(/datum/component/physics)
	if(!target_physics)
		return
	var/target_velocity_x = target_physics.velocity_x - component_velocity_x
	var/target_velocity_y = target_physics.velocity_y - component_velocity_y

	// Calculate the time it would take for the missile to reach the target (assuming constant velocity)
	var/distance_to_target = get_dist(src, target)
	var/missile_speed = sqrt(component_velocity_x ** 2 + component_velocity_y ** 2)
	var/time_to_reach_target = (missile_speed != 0) ? distance_to_target / missile_speed : 0

	// Predict the future position of the target based on its velocity
	var/future_target_x = target.x + target_velocity_x * time_to_reach_target
	var/future_target_y = target.y + target_velocity_y * time_to_reach_target

	// Calculate the angle to the predicted position
	var/new_angle = get_angle(src, locate(future_target_x, future_target_y, target.z))

	// Update desired angle and thrusters accordingly
	var/angle_diff = abs(new_angle - component_angle)
	if(angle_diff > 180)
		angle_diff = 360 - angle_diff

	if(angle_diff > angle_tolerance)
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, new_angle)

	if(angle_diff > thruster_disable_threshold)
		if(thruster_on)
			toggle_thruster(FALSE)
	else if(!thruster_on)
		toggle_thruster(TRUE)

/obj/physics_missile/auto_target
	name = "auto targeting missile"
	auto_target = TRUE
	icon_state = "small_missile"
	payload_size = list(0, 0, 3, 4)
