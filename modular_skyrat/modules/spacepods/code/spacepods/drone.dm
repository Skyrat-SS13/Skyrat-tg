/obj/drone
	name = "drone"
	desc = "A mindless drone out to kill you."
	icon = 'modular_skyrat/modules/spacepods/icons/pod1x1.dmi'
	icon_state = "drone"
	density = TRUE
	opacity = FALSE
	dir = NORTH
	max_integrity = 100
	var/component_angle = 0
	var/turf/target_turf
	var/is_avoiding_obstacle = FALSE


/obj/drone/Initialize()
	. = ..()
	// Attach the physics component to the drone
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics, _max_velocity_x = 4, _max_velocity_y = 4, _thrust_check_required = FALSE, _stabilisation_check_required = FALSE, _reset_thrust_dir = FALSE)
	// Set the desired thrust direction to forward
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, NORTH)
	// Register the signal to trigger the process_bump() proc
	RegisterSignal(physics_component, COMSIG_PHYSICS_PROCESSED_BUMP, PROC_REF(process_bump))
	RegisterSignal(physics_component, COMSIG_PHYSICS_UPDATE_MOVEMENT, PROC_REF(physics_update_movement))
	// Start the movement loop if the drone has a target
	if(target_turf)
		START_PROCESSING(SSphysics, src)

/obj/drone/Destroy()
	. = ..()
	// Stop the movement loop when the drone is destroyed
	STOP_PROCESSING(SSphysics, src)

/obj/drone/process()
	// If the drone has a target and is not avoiding an obstacle, update the desired angle to point towards it
	if(target_turf && !is_avoiding_obstacle)
		var/distance_x = target_turf.x - x
		var/distance_y = target_turf.y - y
		var/new_angle = ATAN2(distance_y, distance_x) * (180 / PI)
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, new_angle)
		return
	STOP_PROCESSING(SSphysics, src)

/obj/drone/proc/process_bump()
	SIGNAL_HANDLER
	// When the drone bumps into something, change the desired angle to the opposite direction for a short duration
	if(!is_avoiding_obstacle)
		is_avoiding_obstacle = TRUE
		var/opposite_angle = (component_angle + 180) % 360
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, opposite_angle)
		addtimer(CALLBACK(src, PROC_REF(finish_avoiding_obstacle)), 2 SECONDS)

/obj/drone/proc/finish_avoiding_obstacle()
	is_avoiding_obstacle = FALSE

/obj/drone/proc/set_target(turf/target)
	target_turf = target
	// If the drone is not processing, start the movement loop
	START_PROCESSING(SSphysics, src)


/obj/drone/proc/physics_update_movement(datum/source, updated_angle, updated_velocity_x, updated_velocity_y, updated_offset_x, updated_offset_y, updated_last_rotate, updated_last_thrust_forward, updated_last_thrust_right)
	SIGNAL_HANDLER
	component_angle = updated_angle

/obj/drone/proc/find_target(range)
	var/min_distance = INFINITY
	var/turf/closest_turf
	for(var/turf/iterating_turf in view(range, src))
		if(!iterating_turf.contents)
			continue
		for(var/mob/living/iterating_mob in iterating_turf.contents)
			var/distance = get_dist(src, iterating_mob)
			if(distance < min_distance)
				min_distance = distance
				closest_turf = iterating_mob
	if(closest_turf)
		set_target(closest_turf)
