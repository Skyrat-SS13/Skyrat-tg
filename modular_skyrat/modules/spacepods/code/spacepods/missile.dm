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
	/// Our target, if any.
	var/atom/target
	/// Are we firing the thrusters?
	var/thruster_on = FALSE
	/// How far we detect in tiles
	var/detection_range = 10
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
	/// The factions we will check for targeting purposes.
	var/faction_check

/obj/physics_missile/Initialize(starting_angle)
	. = ..()
	rocket_sound = new(src)
	// Attach the physics component to the physics_missile
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics, max_forward_thrust, _thrust_check_required = FALSE, _stabilisation_check_required = FALSE, _reset_thrust_dir = FALSE)

	// Register the signal to trigger the process_bump() proc
	RegisterSignal(physics_component, COMSIG_PHYSICS_PROCESSED_BUMP, PROC_REF(process_bump))
	RegisterSignal(physics_component, COMSIG_PHYSICS_UPDATE_MOVEMENT, PROC_REF(physics_update_movement))

	if(starting_angle)
		physics_component.angle = starting_angle

	START_PROCESSING(SSphysics, src)

/obj/physics_missile/Destroy()
	rocket_sound.stop()
	QDEL_NULL(rocket_sound)
	// Stop the movement loop when the physics_missile is destroyed
	STOP_PROCESSING(SSphysics, src)
	if(target)
		UnregisterSignal(target, COMSIG_PARENT_QDELETING)
		target = null
	return ..()

/obj/physics_missile/process()
	// If the physics_missile has a target and is not avoiding an obstacle, update the desired angle to point towards it
	if(target)
		calculate_target_angle()
	else
		if(thruster_on)
			toggle_thruster(FALSE)
		find_target(detection_range)
	update_overlays()

/obj/physics_missile/update_overlays()
	. = ..()
	if(thruster_on)
		. += "thrust_overlay"

/obj/physics_missile/proc/process_bump()
	SIGNAL_HANDLER
	explosion(src, 0, 0, 3, 4)
	qdel(src)

/obj/physics_missile/proc/set_target(atom/target_to_set)
	if(!target_to_set)
		return
	target = target_to_set
	RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(lose_target))

/obj/physics_missile/proc/lose_target(atom/lost_target)
	SIGNAL_HANDLER
	UnregisterSignal(lost_target, COMSIG_PARENT_QDELETING)
	target = null

/**
 * physics_update_movement
 *
 * Called when our physics component moves.
 */
/obj/physics_missile/proc/physics_update_movement(datum/source, updated_angle, updated_velocity_x, updated_velocity_y, updated_offset_x, updated_offset_y, updated_last_rotate, updated_last_thrust_forward, updated_last_thrust_right)
	SIGNAL_HANDLER
	component_angle = updated_angle
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
/obj/physics_missile/proc/find_target(range)
	var/min_distance = INFINITY
	var/closest_object
	for(var/iterating_target as anything in view(range, src))
		if(!istype(iterating_target, target_type))
			continue
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
	return TRUE

/**
 * spacepod seeking missile
 *
 * This missile uses a basic form of lead angle targeting.
 */
/obj/physics_missile/spacepod
	name = "spacepod seeking missile"
	target_type = /obj/spacepod


/obj/physics_missile/spacepod/calculate_target_angle()
    if(!target)
        return

    // Calculate the relative velocity of the target
    var/datum/component/physics/target_physics = target.GetComponent(/datum/component/physics)
    var/datum/component/physics/missile_physics = GetComponent(/datum/component/physics)
    var/target_velocity_x = target_physics.velocity_x - missile_physics.velocity_x
    var/target_velocity_y = target_physics.velocity_y - missile_physics.velocity_y

    // Calculate the time it would take for the missile to reach the target (assuming constant velocity)
    var/distance_to_target = get_dist(src, target)
    var/missile_speed = sqrt(missile_physics.velocity_x ** 2 + missile_physics.velocity_y ** 2)
    var/time_to_reach_target = distance_to_target / missile_speed

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
