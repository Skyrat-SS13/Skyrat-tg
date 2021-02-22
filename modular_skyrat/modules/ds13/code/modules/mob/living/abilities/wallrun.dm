/*
	Wallrun extension

	Used for an atom - primarily mobs - that can move along walls as if they were floors.
	Functionally, the mob doesn't leave its floor tile. But
		it visually offsets and rotates towards the wall,
		turns partially transparent to signify being closer to the camera
		counts as flying for the purpose of collision and floor traps
*/
//wallrun
//Wall Run
//wallrunning
///atom/movable
/datum/extension/wallrun
	name = "Wall Run"
	base_type = /datum/extension/wallrun
	expected_type = /atom/movable
	flags = EXTENSION_FLAG_IMMEDIATE

	var/started_at
	var/stopped_at

	var/status
	var/atom/movable/A
	var/mob/living/user
	var/mount_time = 0.7 SECONDS	//Time taken for the visual animation to mount/unmount

	var/atom/mountpoint	//What thing are we currently standing on?
	var/turf/mount_turf	//What tile are we walking against?
	//This will usually be the location of mountpoint, but it can be different in the case of border items like windows

	var/mount_angle

	var/atom/next_mountpoint	//What will we mount to next? This is set in pre-move
	var/vector2/offset

	//What things count as a surface for our practical purposes?
	//This should only contain types of dense atoms which generally occupy their whole tile. Walls, windows, grilles, etc
	var/list/valid_types = list(/turf/simulated/wall,
	/obj/structure/grille,
	/obj/structure/window,
	/obj/machinery/door,
	/mob/living)

	var/pixel_offset_magnitude = 0	//How far to offset us towards the target atom

	//These hold cached values of the user's default - not current - variables, at the time we mounted a wall
	var/vector2/cached_pixels
	var/default_rotation
	var/cached_alpha
	var/cached_passflags
	var/passflag_delta	//Holds flying and table passflags, but only if the user doesn't have them naturally. Used to apply/remove them
	var/vector2/centre_offset //What offset do we add to our sprite to centre it in the tile? Calculated based on dmi size. This is applied flatly regardless of rotation
	var/vector2/base_offset	//What offset do we add to place our feet against the edge of the tile? This is rotated before applying
	var/cached_density
	var/visual_dir = SOUTH	//Which direction is our sprite facing? This may be different from the normal dir value

	//Bonus stats
	var/evasion_mod	=	10
	var/view_range_mod = 1

	//Used to prevent duplicate stacking
	var/evasion_delta = 0
	var/view_range_delta = 0

	statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE = 1.15)
	auto_register_statmods = FALSE

/datum/extension/wallrun/New(var/atom/movable/_user)
	.=..()


	A = _user
	if (isliving(_user))
		user = _user
	start()



/datum/extension/wallrun/proc/apply_stats()
	if (!user)
		return

	if (!evasion_delta)
		user.evasion  += evasion_mod
		evasion_delta  += evasion_mod

	register_statmods()

	if (!view_range_delta)
		user.view_range += view_range_mod
		view_range_delta = view_range_mod

	if (isnull(cached_density))
		cached_density = user.density
		user.density = FALSE

/datum/extension/wallrun/proc/unapply_stats()

	if (evasion_delta)
		user.evasion  -= evasion_delta
		evasion_delta  = 0

	unregister_statmods()

	if (view_range_delta)
		user.view_range -= view_range_delta
		view_range_delta = 0

	if (!isnull(cached_density))
		user.density = cached_density
		cached_density = null




/datum/extension/wallrun/proc/start()
	started_at	=	world.time
	GLOB.bump_event.register(A, src, /datum/extension/wallrun/proc/on_bumped)


/datum/extension/wallrun/proc/stop()
	GLOB.bump_event.unregister(A, src, /datum/extension/wallrun/proc/on_bumped)
	remove_extension(holder, base_type)







/*-----------------
	Mounting
------------------*/
//This should only be called when we are NOT already mounted. When we are mounted, use attempt_transition instead
/datum/extension/wallrun/proc/attempt_mount(var/atom/target)
	if (is_valid_mount_target(target))
		cache_data()
		mount_to_atom(target)
		mount_animation()
		A.visible_message(SPAN_NOTICE("[A] climbs onto the [target]"))
		return TRUE


//This cannot fail, make sure safety checks are done already
/datum/extension/wallrun/proc/mount_to_atom(var/atom/target)
	mountpoint = target
	if (offset)
		release_vector(offset)
	offset = get_new_vector(A.x - target.x, A.y - target.y)

	if (istype(mountpoint, /atom/movable))
		GLOB.moved_event.register(mountpoint, src, /datum/extension/wallrun/proc/on_mountpoint_move)
	GLOB.destroyed_event.register(mountpoint, src, /datum/extension/wallrun/proc/unmount_to_floor)
	GLOB.density_set_event.register(mountpoint, src, /datum/extension/wallrun/proc/on_density_set)
	GLOB.pre_move_event.register(A, src, /datum/extension/wallrun/proc/on_premove)
	GLOB.moved_event.register(A, src, /datum/extension/wallrun/proc/on_move)
	GLOB.dir_set_event.register(A, src, /datum/extension/wallrun/proc/dir_set)
	GLOB.death_event.register(A, src, /datum/extension/wallrun/proc/unmount_to_floor)


	A.pass_flags |= passflag_delta
	apply_stats()

	mount_turf = get_mount_target_turf(A, target)



/datum/extension/wallrun/proc/mount_animation()
	//Visuals

	mount_angle = rotation_to_target(A, mount_turf, SOUTH)	//Point our feet at the wall we're walking on
	A.default_rotation = mount_angle


	var/vector2/newpix = base_offset.Turn(mount_angle)
	newpix.SelfAdd(centre_offset)	//The base offset is used with rotation
	A.default_pixel_x = newpix.x
	A.default_pixel_y = newpix.y

	A.default_alpha = min(cached_alpha * 0.5, 100)


	animate(A, transform = A.get_default_transform(), alpha = A.default_alpha, pixel_x = A.default_pixel_x, pixel_y = A.default_pixel_y, time = mount_time, easing = BACK_EASING)


	release_vector(newpix)





/*-----------------
	Transitioning
------------------*/
//This should only be called when we are already mounted
/datum/extension/wallrun/proc/attempt_transition(var/atom/target)
	if (!target)
		return
	if (is_valid_mount_target(target) && is_valid_transition_target(target))
		return transition_to_atom(target)

//Called when we move from one mounted atom to another
/datum/extension/wallrun/proc/transition_to_atom(var/atom/target)
	var/target_turf = get_mount_target_turf(A, target)
	if (!target_turf)
		return
	var/angle_to_target = rotation_to_target(A, target_turf, SOUTH)
	//If its a different direction from our current mount, redo the animation
	var/do_animate = FALSE
	if (mount_angle != angle_to_target)
		do_animate = TRUE

	//First of all, unmount us from the old atom
	unmount()



	mount_to_atom(target)
	if (do_animate)
		mount_animation()
	return TRUE



//Attempts either mount or transition according to current mounted status
/datum/extension/wallrun/proc/attempt_connect(var/atom/target)
	if(mountpoint)
		return attempt_transition(next_mountpoint)
	else
		return attempt_mount(next_mountpoint)


/*-----------------
	Unmounting
------------------*/
//Called everytime we move between mountpoints, or end mounting
/datum/extension/wallrun/proc/unmount(var/atom/target)
	if (mountpoint)
		if (istype(mountpoint, /atom/movable))
			GLOB.moved_event.unregister(mountpoint, src, /datum/extension/wallrun/proc/on_mountpoint_move)
		GLOB.destroyed_event.unregister(mountpoint, src, /datum/extension/wallrun/proc/unmount_to_floor)
		GLOB.density_set_event.unregister(mountpoint, src, /datum/extension/wallrun/proc/on_density_set)
		GLOB.pre_move_event.unregister(A, src, /datum/extension/wallrun/proc/on_premove)
		GLOB.moved_event.unregister(A, src, /datum/extension/wallrun/proc/on_move)
		GLOB.death_event.unregister(A, src, /datum/extension/wallrun/proc/unmount_to_floor)


	mountpoint = null

	A.pass_flags -= passflag_delta
	unapply_stats()


//Called to end mounting and return to standing on the floor
/datum/extension/wallrun/proc/unmount_to_floor()
	if (user && !user.stat)
		user.visible_message(SPAN_NOTICE("[A] climbs down from \the [mountpoint]"))
	unmount_animation()
	unmount()

//Called when unmounting as part of some other action, like performing a leap off a wall
/datum/extension/wallrun/proc/unmount_silent()
	unmount()
	//Visuals
	A.default_rotation = 0

	A.default_pixel_x = cached_pixels.x
	A.default_pixel_y = cached_pixels.y
	cached_pixels = null

	A.default_alpha = cached_alpha
	cached_alpha = null


	A.animate_to_default(0)



/datum/extension/wallrun/proc/cache_data()
	cached_pixels = get_new_vector(A.default_pixel_x, A.default_pixel_y)
	default_rotation = A.default_rotation
	cached_alpha = A.default_alpha
	cached_passflags = A.pass_flags
	if (!(cached_passflags & PASS_FLAG_TABLE))
		passflag_delta |= PASS_FLAG_TABLE

	if (!(cached_passflags & PASS_FLAG_FLYING))
		passflag_delta |= PASS_FLAG_FLYING

	//Lets calculate the centre offset, once only
	if (!centre_offset)

		//Size won't be released in this stack, because its value is transferred into base_offset
		var/vector2/size = A.get_icon_size()

		//We cut the size in half and then subtract 16,16, which is the centre of a normal 32x32 tile.
		size *= 0.5
		size -= get_new_vector(WORLD_ICON_SIZE * 0.5, WORLD_ICON_SIZE * 0.5)

		if (centre_offset)
			release_vector(centre_offset)
		centre_offset = size*-1

		//Base offset is simple. Its just the inverted Y offset and no X
		if (base_offset)
			release_vector(base_offset)
		base_offset = size
		base_offset.x = 0
		base_offset.y += pixel_offset_magnitude //We can add in the pixel offset here for efficiency too



/datum/extension/wallrun/proc/unmount_animation()
	//Visuals
	A.default_rotation = default_rotation
	default_rotation = 0

	A.default_pixel_x = cached_pixels.x
	A.default_pixel_y = cached_pixels.y
	cached_pixels = null

	A.default_alpha = cached_alpha
	cached_alpha = null


	animate(A, transform = A.get_default_transform(), alpha = A.default_alpha, pixel_x = A.default_pixel_x, pixel_y = A.default_pixel_y, time = mount_time, easing = BACK_EASING)





/*-----------------
	Detection
------------------*/
/datum/extension/wallrun/proc/find_mountpoint(var/origin)
	for (var/atom/target in orange(origin, 1))
		if (is_valid_mount_target(target) && is_valid_transition_target(target))
			return target
	return null

//Finds what turf we're trying to connect to
/datum/extension/wallrun/proc/get_mount_target_turf(var/atom/origin, var/atom/target)
	var/turf/U = get_turf(origin)
	var/turf/T = get_turf(target)


	//Special behaviour for border items
	if (target.atom_flags & ATOM_FLAG_CHECKS_BORDER)
		//In the case of border atoms, we want to get the tile on the OTHER side of the border from us
		var/dir_to_us = get_dir(T, origin)
		if (dir_to_us & target.dir)
			return T	//If the item is facing towards us, the other side is its own turf
		//If its facing away from us, the other side is the turf its facing
		return get_step(T, target.dir)

	if (U != T)
		return T

	else
		return null //IF its in our own turf and not a border item, we don't want to attach to it

/***********************
	Safety Checks
************************/
/*
	Returns true if our user could possibly mount on this.
	The user's position is only taken into account if the target is on a border
*/
/datum/extension/wallrun/proc/is_valid_mount_target(var/atom/target, var/ignore_self = FALSE)
	//Don't transition to ourself silly
	if (!ignore_self && (target == mountpoint || target == A))
		return FALSE

	//Only dense atoms
	if (!target.density)
		return FALSE

	//Must be correct type
	var/typematch = FALSE
	for (var/typepath in valid_types)
		if (istype(target, typepath))
			typematch = TRUE
			break
	if (!typematch)
		return FALSE

	//If its a border item, it must be roughly facing the user
	var/target_turf = get_mount_target_turf(A, target)
	if (!(target_turf in orange(1, A)))
		return FALSE

	//Special checks for mobs
	if (isliving(target))
		var/mob/living/LT = target
		if (LT.mob_size < MOB_LARGE)
			return FALSE


	return TRUE




/*
	Called when we're moving from one mountpoint to another. We already know the target is valid
	This proc tests whether we can reach it from our current spot
*/
/datum/extension/wallrun/proc/is_valid_transition_target(var/atom/target)
	var/target_turf = get_mount_target_turf(A, target)
	if (!(target_turf in orange(mountpoint, 1)))
		return FALSE

	return TRUE


//Access Proc
/*
/atom/movable/proc/can_wallrun(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	var/datum/extension/wallrun/E = get_extension(src, /datum/extension/wallrun)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already wallrunning"))
		return FALSE

	return TRUE
*/


/*------------------------
	Observation Calls
-------------------------*/
//Called when we bump into something
/datum/extension/wallrun/proc/on_bumped(var/atom/movable/mover, var/atom/obstacle)
	//Can't do wallrun and wallmount at the same time
	if (mover.is_mounted())
		return

	if (!mountpoint)
		attempt_mount(obstacle)
	else
		attempt_transition(obstacle)

//Called when the thing we're mounted to, moves
//This will most often happen when attached to mobs
/datum/extension/wallrun/proc/on_mountpoint_move()
	var/turf/T = locate(mountpoint.x + offset.x, mountpoint.y + offset.y, mountpoint.z)
	if (T.Enter(A))
		A.forceMove(T)
	else	//We can't move with it and get pushed off
		unmount_to_floor()

//Called when the thing we're mounted to changes density
//This will most often happen with airlocks opening
/datum/extension/wallrun/proc/on_density_set()
	if (!mountpoint  || QDELETED(mountpoint) || mountpoint.density == FALSE)
		unmount_to_floor()


/*
	Called just before the user moves.
	We will attempt to find a valid mountpoint near the target

	If we can't find one, we'll unmount to floor before moving
*/
/datum/extension/wallrun/proc/on_premove(var/atom/mover, var/curloc, var/newloc)
	.=TRUE
	if (!mountpoint)
		return	//If we aren't already mounted to something, we don't care

	//Try to find something new to mount to
	var/atom/next = find_mountpoint(newloc)

	//If that fails, lets see if we'll still be able to hang onto the current mountpoint
	if (!next)
		if (get_dist(mountpoint, newloc) <= 1)
			next = mountpoint

	//Alright the moment of truth. Are we going to remain mounted after the next movement?
	if (next)
		next_mountpoint = next
	else
		unmount_to_floor()


/datum/extension/wallrun/proc/on_move(var/atom/mover, var/oldloc, var/newloc)
	var/mounted = FALSE
	//We have a next target? Try mounting to it
	if (next_mountpoint)

		//First of all, if we're trying to hang onto our existing point, check that its still valid
		if (next_mountpoint == mountpoint)
			mounted = is_valid_mount_target(mountpoint, TRUE)	//Pass in true to ignore selfchecking
			mount_animation()	//Do the mount animation without changing anything, this will re-orient us to the wall from our new angle
		else if(mountpoint)
			mounted = attempt_connect(next_mountpoint)

		next_mountpoint = null

	//Did we successfully connect to a new mountpoint? (or remain connected to the current one?)
	if(!mounted)


		//If we get here, one of the following has happened
			//1. We had no next mountpoint set
			//2. We failed to connect to the one we had set
			//3. We failed to hang onto our existing point

		//In any case, we must now find and connect to a new point, or drop to floor
		var/atom/next = find_mountpoint(newloc)
		if (next && attempt_connect(next))
			mounted = TRUE

		//Alright that failed, lets try hanging onto the existing
		else if (mountpoint && is_valid_mount_target(mountpoint, TRUE))
			mounted = TRUE

		//We are out of options, we can no longer maintain a hold on the wall
		else
			unmount_to_floor()


	if (mounted && user)
		user.play_species_audio(user, SOUND_CLIMB, VOLUME_LOW, 1)

		//Since the native behaviour of Move causes the mob to change direction, we must compensate and fix their direction by attempting to turn towards the cached visual dir
		dir_set(user, visual_dir, visual_dir)

//An attempt to make directional facings meaningful
/datum/extension/wallrun/proc/dir_set(var/atom/mover, var/old_dir, var/new_dir)
	if (mountpoint)
		//We get the normal direction of the wall
		var/vector2/current_wall_normal = get_new_vector(mover.x - mountpoint.x, mover.y - mountpoint.y)

		//Lets get the direction of the target now
		var/vector2/desired_dir = Vector2.NewFromDir(new_dir)	//This is working with a preexisting global, should NOT be released

		//Alright next up, we get the angle between these two
		var/desired_angle = desired_dir.AngleFrom(current_wall_normal)

		//We only want cardinal directions, round it off
		desired_angle = round(desired_angle, 90)

		var/actual_dir = turn(SOUTH, desired_angle)
		A.dir = actual_dir
		release_vector(desired_dir)
		release_vector(current_wall_normal)
	visual_dir = new_dir



/*--------------------
	Helpers
---------------------*/
/atom/proc/is_on_wall()
	var/datum/extension/wallrun/W = get_extension(src, /datum/extension/wallrun)
	if (W && W.mountpoint)
		return W
	return FALSE

/atom/proc/unmount_from_wall()
	var/datum/extension/wallrun/W = get_extension(src, /datum/extension/wallrun)
	if (W && W.mountpoint)
		W.unmount_silent()

//Returns what direction this atom -appears- to be facing
/atom/proc/get_visual_dir()
	var/datum/extension/wallrun/W = is_on_wall()
	if (W)
		return W.visual_dir
	else
		return dir