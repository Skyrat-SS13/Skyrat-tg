/*
	Attached to an atom, this will rotate to make it face towards a target atom, which can be changed regularly
*/
/datum/extension/rotate_facing
	name = "rotate_facing"
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE
	var/atom/movable/AM
	var/atom/movable/target
	var/vector2/forward_vector = NORTH	//What direction we want to point at the target
	var/max_rotation	//A maximum total amount we can turn, useful for restricted turrets
	var/angular_speed = 60	//How fast we turn

	/*
		Active tracking switches between two modes.
		When False, the holder will rotate towards the target and then consider itself done until a new target is set.
		When True, we will constantly watch both holder and target for movement, and continue rotating as necessary to keep holder pointed at target
	*/
	var/active_track = TRUE

	var/current_rotation = 0	//how much have we turned already?
	var/interval_multiplier = FAST_PROCESS_INTERVAL * 0.1
	var/complete_cycles = 0



/datum/extension/rotate_facing/New(var/atom/holder)
	.=..()
	AM = holder


	//A forward vector might be passed in, or a direction can be passed
	if (!istype(forward_vector))
		forward_vector = Vector2.FromDir(forward_vector)

	src.forward_vector = forward_vector

	//Track our holder for movement
	if(active_track)
		GLOB.moved_event.register(AM, src, /datum/extension/rotate_facing/proc/holder_moved)

/datum/extension/rotate_facing/proc/set_target(var/atom/newtarget)
	if (active_track)
		//We need to remove the tracking from the old target
		if (target && ismovable(target))
			GLOB.moved_event.unregister(target, src, /datum/extension/rotate_facing/proc/target_moved)

		if (ismovable(newtarget))
			GLOB.moved_event.register(newtarget, src, /datum/extension/rotate_facing/proc/target_moved)

	target = newtarget


	start_tracking()


/*
	This proc returns our rotation delta towards the target, or optionally, a different, specified target
	This is here rather than in a helper proc since it depends upon existing data - our current rotation and forward vector
*/
/datum/extension/rotate_facing/proc/get_rotation_to_target(var/alt_target = null)
	var/vector2/rotated_forward_vector = forward_vector.Turn(current_rotation)

	//Where do we want to look?
	var/vector2/direction = Vector2.SmartDirectionBetween(AM, alt_target ? alt_target : target)
	//We can't face in a zero direction
	if (direction.x == 0 && direction.y == 0)
		return 0

	//This gets the rotiation from where we are currently facing, to where we want to face
	. = direction.AngleFrom(rotated_forward_vector, TRUE)

	release_vector(direction)
	release_vector(rotated_forward_vector)

/*
	Like the above, but works with the unrotated forward vector
*/
/datum/extension/rotate_facing/proc/get_total_rotation_to_target(var/alt_target = null)
	//Where do we want to look?
	var/vector2/direction = Vector2.SmartDirectionBetween(AM, alt_target ? alt_target : target)
	//We can't face in a zero direction
	if (direction.x == 0 && direction.y == 0)
		return 0

	//This gets the rotiation from where we are currently facing, to where we want to face
	. = direction.AngleFrom(forward_vector, TRUE)

	release_vector(direction)

/*
	Gets the turf infront of our
*/
/datum/extension/rotate_facing/proc/get_turf_infront(var/distance)
	var/vector2/rotated_forward_vector = forward_vector.Turn(current_rotation)
	rotated_forward_vector.SelfMultiply(WORLD_ICON_SIZE*distance)

	.= AM.get_turf_at_pixel_offset(rotated_forward_vector)
	release_vector(rotated_forward_vector)

/*
	This is called when a new target is set
	In active track mode, it is also called when the holder or target moves
	This starts the processing
*/
/datum/extension/rotate_facing/proc/start_tracking()
	complete_cycles = 0
	START_PROCESSING(SSfastprocess, src)

/*
	This is called once we are facing the target, we'll stop processing until more turning is needed
*/
/datum/extension/rotate_facing/proc/end_tracking()
	STOP_PROCESSING(SSfastprocess, src)

/datum/extension/rotate_facing/proc/target_moved()
	start_tracking()

/datum/extension/rotate_facing/proc/holder_moved()
	start_tracking()


/datum/extension/rotate_facing/Process()
	if (QDELETED(target))
		end_tracking()
		return

	//Where are we currently looking?
	var/vector2/rotated_forward_vector = forward_vector.Turn(current_rotation)

	//Where do we want to look?
	var/vector2/direction = Vector2.SmartDirectionBetween(AM, target)
	//We can't face in a zero direction
	if (direction.x == 0 && direction.y == 0)
		return

	//This gets the rotiation from where we are currently facing, to where we want to face
	var/rotation_delta = direction.AngleFrom(rotated_forward_vector, TRUE)
	var/target_rotation_delta = rotation_delta	//Cache this before clamping too

	//Now before we do anything with this we may need to clamp it

	//First of all, clamp the size of the movement to our turning speed
	if (angular_speed)
		rotation_delta = clamp(rotation_delta, -(angular_speed * interval_multiplier), (angular_speed * interval_multiplier))

	//Secondly, clamp the maximum rotation
	var/total_rotation = current_rotation + rotation_delta
	if (max_rotation)

		total_rotation = clamp(total_rotation, -max_rotation, max_rotation)
		rotation_delta = total_rotation - current_rotation
		//Done



	current_rotation = total_rotation



	//Alright lets do the animation, but only if we're actually turning a nonzero amount
	if (rotation_delta)
		var/matrix/newtransform = AM.transform
		newtransform.Turn(rotation_delta)
		animate(AM, transform = newtransform, time = FAST_PROCESS_INTERVAL, flags = ANIMATION_END_NOW)



	//If no clamping was done, then we know that this movement has made us reach the target, so we're done tracking until something changes
	if (target_rotation_delta == rotation_delta)
		complete_cycles++
		//If we've been at the target for two ticks in a row, we're done
		if (complete_cycles > 1)
			end_tracking()
	else
		complete_cycles = 0

	release_vector(direction)
	release_vector(rotated_forward_vector)