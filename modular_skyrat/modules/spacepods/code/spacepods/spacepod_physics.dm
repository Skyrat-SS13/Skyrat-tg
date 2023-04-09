/obj/spacepod/process(time)
	//time /= 2 // fuck off with your deciseconds

	if(world.time > last_slowprocess + 15)
		last_slowprocess = world.time
		slowprocess()

	// Initialization of variables for position and angle calculations
	var/last_offset_x = offset_x
	var/last_offset_y = offset_y
	var/last_angle = angle
	var/desired_angular_velocity = 0

	// Calculate desired angular velocity based on desired angle
	if(isnum(desired_angle))
		// Ensure angles rotate the short way
		while(angle > desired_angle + 180)
			angle -= 360
			last_angle -= 360
		while(angle < desired_angle - 180)
			angle += 360
			last_angle += 360

		// Calculate desired angular velocity based on the desired angle and time
		if(abs(desired_angle - angle) < (max_angular_acceleration * time))
			desired_angular_velocity = (desired_angle - angle) / time
		else if(desired_angle > angle)
			desired_angular_velocity = 2 * sqrt((desired_angle - angle) * max_angular_acceleration * 0.25)
		else
			desired_angular_velocity = -2 * sqrt((angle - desired_angle) * max_angular_acceleration * 0.25)

	// Adjust angular velocity based on desired angular velocity and the battery usage
	var/angular_velocity_adjustment = clamp(desired_angular_velocity - angular_velocity, -max_angular_acceleration * time, max_angular_acceleration * time)
	if(angular_velocity_adjustment && cell && cell.use(abs(angular_velocity_adjustment) * 0.05) && check_has_equipment(/obj/item/spacepod_equipment/thruster) && gyroscope_enabled)
		last_rotate = angular_velocity_adjustment / time
		angular_velocity += angular_velocity_adjustment
	else
		last_rotate = 0
	angle += angular_velocity * time

	// Calculate drag based on the environment and spacepod's velocity
	var/velocity_mag = sqrt(velocity_x * velocity_x + velocity_y * velocity_y) // magnitude
	if(velocity_mag || angular_velocity)
		var/drag = 0
		for(var/turf/iterating_turf in locs)
			if(isspaceturf(iterating_turf))
				continue
			drag += 0.001
			var/floating = FALSE
			if(iterating_turf.has_gravity() && !brakes && velocity_mag > 0.1 && cell && cell.use((is_mining_level(z) ? 3 : 15) * time))
				floating = TRUE // want to fly this shit on the station? Have fun draining your battery.
			if((!floating && iterating_turf.has_gravity()) || brakes) // brakes are a kind of magboots okay?
				drag += is_mining_level(z) ? 0.1 : 0.5 // some serious drag. Damn. Except lavaland, it has less gravity or something
				if(velocity_mag > 5 && prob(velocity_mag * 4) && isfloorturf(iterating_turf))
					var/turf/open/floor/floor = iterating_turf
					floor.make_plating() // pull up some floor tiles. Stop going so fast, ree.
					take_damage(3, BRUTE, "melee", FALSE)
			var/datum/gas_mixture/env = iterating_turf.return_air()
			if(env)
				var/pressure = env.return_pressure()
				drag += velocity_mag * pressure * 0.0001 // 1 atmosphere should shave off 1% of velocity per tile
		if(velocity_mag > 20)
			drag = max(drag, (velocity_mag - 20) / time)
		if(drag)
			if(velocity_mag)
				var/drag_factor = 1 - clamp(drag * time / velocity_mag, 0, 1)
				velocity_x *= drag_factor
				velocity_y *= drag_factor
			if(angular_velocity != 0)
				var/drag_factor_spin = 1 - clamp(drag * 30 * time / abs(angular_velocity), 0, 1)
				angular_velocity *= drag_factor_spin

	// Alright now calculate the THRUST
	var/thrust_x
	var/thrust_y
	var/fx = cos(90 - angle)
	var/fy = sin(90 - angle)
	var/sx = fy
	var/sy = -fx
	last_thrust_forward = 0
	last_thrust_right = 0

	if(brakes || check_has_equipment(/obj/item/spacepod_equipment/rcs_upgrade))
		if(user_thrust_dir && !check_has_equipment(/obj/item/spacepod_equipment/rcs_upgrade))
			to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("Vector thrust locked!"))
		// basically calculates how much we can brake using the thrust
		var/forward_thrust = -((fx * velocity_x) + (fy * velocity_y)) / time
		var/right_thrust = -((sx * velocity_x) + (sy * velocity_y)) / time
		forward_thrust = clamp(forward_thrust, -backward_maxthrust, forward_maxthrust)
		right_thrust = clamp(right_thrust, -side_maxthrust, side_maxthrust)
		thrust_x += forward_thrust * fx + right_thrust * sx;
		thrust_y += forward_thrust * fy + right_thrust * sy;
		last_thrust_forward = forward_thrust
		last_thrust_right = right_thrust
	if(!brakes) // want some sort of help piloting the ship? Haha no fuck you do it yourself or make rcs vector upgrade
		if(user_thrust_dir & NORTH)
			thrust_x += fx * forward_maxthrust
			thrust_y += fy * forward_maxthrust
			last_thrust_forward = forward_maxthrust
		if(user_thrust_dir & SOUTH)
			thrust_x -= fx * backward_maxthrust
			thrust_y -= fy * backward_maxthrust
			last_thrust_forward = -backward_maxthrust
		if(user_thrust_dir & EAST)
			thrust_x += sx * side_maxthrust
			thrust_y += sy * side_maxthrust
			last_thrust_right = side_maxthrust
		if(user_thrust_dir & WEST)
			thrust_x -= sx * side_maxthrust
			thrust_y -= sy * side_maxthrust
			last_thrust_right = -side_maxthrust

	if(cell && cell.use(10 * sqrt((thrust_x * thrust_x) + (thrust_y * thrust_y)) * time) && !thrust_lockout && check_has_equipment(/obj/item/spacepod_equipment/thruster))
		velocity_x += thrust_x * time
		velocity_y += thrust_y * time
	else
		last_thrust_forward = 0
		last_thrust_right = 0
		if(!brakes && user_thrust_dir)
			if(!check_has_equipment(/obj/item/spacepod_equipment/thruster))
				to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("No thrusters installed!"))
			else if(thrust_lockout)
				to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("Thrust lockout active!"))
			else
				to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("Out of power!"))


	offset_x += velocity_x * time
	offset_y += velocity_y * time
	// alright so now we reconcile the offsets with the in-world position.
	while((offset_x > 0 && velocity_x > 0) || (offset_y > 0 && velocity_y > 0) || (offset_x < 0 && velocity_x < 0) || (offset_y < 0 && velocity_y < 0))
		var/failed_x = FALSE
		var/failed_y = FALSE
		if(offset_x > 0 && velocity_x > 0)
			dir = EAST
			if(!Move(get_step(src, EAST)))
				offset_x = 0
				failed_x = TRUE
				velocity_x *= -bounce_factor
				velocity_y *= lateral_bounce_factor
			else
				offset_x--
				last_offset_x--
		else if(offset_x < 0 && velocity_x < 0)
			dir = WEST
			if(!Move(get_step(src, WEST)))
				offset_x = 0
				failed_x = TRUE
				velocity_x *= -bounce_factor
				velocity_y *= lateral_bounce_factor
			else
				offset_x++
				last_offset_x++
		else
			failed_x = TRUE
		if(offset_y > 0 && velocity_y > 0)
			dir = NORTH
			if(!Move(get_step(src, NORTH)))
				offset_y = 0
				failed_y = TRUE
				velocity_y *= -bounce_factor
				velocity_x *= lateral_bounce_factor
			else
				offset_y--
				last_offset_y--
		else if(offset_y < 0 && velocity_y < 0)
			dir = SOUTH
			if(!Move(get_step(src, SOUTH)))
				offset_y = 0
				failed_y = TRUE
				velocity_y *= -bounce_factor
				velocity_x *= lateral_bounce_factor
			else
				offset_y++
				last_offset_y++
		else
			failed_y = TRUE
		if(failed_x && failed_y)
			break
	// prevents situations where you go "wtf I'm clearly right next to it" as you enter a stationary spacepod
	if(velocity_x == 0)
		if(offset_x > 0.5)
			if(Move(get_step(src, EAST)))
				offset_x--
				last_offset_x--
			else
				offset_x = 0
		if(offset_x < -0.5)
			if(Move(get_step(src, WEST)))
				offset_x++
				last_offset_x++
			else
				offset_x = 0
	if(velocity_y == 0)
		if(offset_y > 0.5)
			if(Move(get_step(src, NORTH)))
				offset_y--
				last_offset_y--
			else
				offset_y = 0
		if(offset_y < -0.5)
			if(Move(get_step(src, SOUTH)))
				offset_y++
				last_offset_y++
			else
				offset_y = 0
	dir = NORTH

	var/matrix/mat_from = new()
	var/matrix/mat_to = new()
	if(icon_dir_num == 1)
		mat_from.Turn(last_angle)
		mat_to.Turn(angle)
	else
		dir = angle2dir(angle)

	transform = mat_from
	pixel_x = base_pixel_x + last_offset_x*32
	pixel_y = base_pixel_y + last_offset_y*32
	animate(src, transform = mat_to, pixel_x = base_pixel_x + offset_x * 32, pixel_y = base_pixel_y + offset_y * 32, time = time * 10, flags = ANIMATION_END_NOW)
	var/list/possible_smooth_viewers = contents | src | get_all_orbiters()
	for(var/mob/iterating_mob in possible_smooth_viewers)
		var/client/mob_client = iterating_mob.client
		if(!mob_client)
			continue
		mob_client.pixel_x = last_offset_x * 32
		mob_client.pixel_y = last_offset_y * 32
		animate(mob_client, pixel_x = offset_x * 32, pixel_y = offset_y * 32, time = time * 10, flags = ANIMATION_END_NOW)
	user_thrust_dir = 0
	update_icon()

/obj/spacepod/Bumped(atom/movable/bumped_atom)
	if(bumped_atom.dir & NORTH)
		velocity_y += bump_impulse
	if(bumped_atom.dir & SOUTH)
		velocity_y -= bump_impulse
	if(bumped_atom.dir & EAST)
		velocity_x += bump_impulse
	if(bumped_atom.dir & WEST)
		velocity_x -= bump_impulse
	return ..()

/obj/spacepod/Bump(atom/bumped_atom)
	var/bump_velocity = 0
	if(dir & (NORTH|SOUTH))
		bump_velocity = abs(velocity_y) + (abs(velocity_x) / 15)
	else
		bump_velocity = abs(velocity_x) + (abs(velocity_y) / 15)

	if(istype(bumped_atom, /obj/machinery/door/airlock)) // try to open doors
		var/obj/machinery/door/bumped_door = bumped_atom
		if(!bumped_door.operating)
			var/door_opened = FALSE
			for(var/mob/living/iterating_pilot as anything in get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT))
				if(bumped_door.allowed(bumped_door.requiresID() ? iterating_pilot : null))
					spawn(0)
					bumped_door.open()
					door_opened = TRUE
					break
			if(!door_opened)
				bumped_door.do_animate("deny")

	var/atom/movable/bumped_movable_atom = bumped_atom

	if(istype(bumped_movable_atom) && !bumped_movable_atom.anchored && bump_velocity > 1)
		step(bumped_movable_atom, dir)

	if(bump_velocity > 5)
		playsound(src, pick(list('modular_skyrat/modules/spacepods/sound/hit_hull_1.ogg', 'modular_skyrat/modules/spacepods/sound/hit_hull_2.ogg', 'modular_skyrat/modules/spacepods/sound/hit_hull_3.ogg')), 70)
	// if a bump is that fast then it's not a bump. It's a collision.
	if(bump_velocity > 10 && !ismob(bumped_atom))
		var/strength = bump_velocity / 10
		strength = strength * strength
		strength = min(strength, 5) // don't want the explosions *too* big
		// wew lad, might wanna slow down there
		explosion(bumped_atom, -1, round((strength - 1) / 2), round(strength))
		message_admins("[key_name_admin(pick(get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT)))] has impacted a spacepod into [bumped_atom] with velocity [bump_velocity]")
		take_damage(strength*10, BRUTE, "melee", TRUE)
		log_game("[key_name(pick(get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT)))] has impacted a spacepod into [bumped_atom] with velocity [bump_velocity]")
		visible_message(span_danger("The force of the impact causes a shockwave"))
	else if(isliving(bumped_atom) && bump_velocity > 5)
		var/mob/living/smashed_mob = bumped_atom
		smashed_mob.apply_damage(bump_velocity * 2)
		take_damage(bump_velocity, BRUTE, "melee", FALSE)
		playsound(smashed_mob.loc, "swing_hit", 100, 1, -1)
		smashed_mob.Knockdown(bump_velocity * 2)
		smashed_mob.visible_message(span_warning("The force of the impact knocks [smashed_mob] down!"), span_userdanger("The force of the impact knocks you down!"))
		log_combat(pick(get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT)), smashed_mob, "impacted", src, "with velocity of [bump_velocity]")
	return ..()

/**
 * Fire Projectile
 *
 * Fires a projectile from the spacepod.
 */
/obj/spacepod/proc/fire_projectile(projectile_type, target, override_offset_x, override_offset_y)
    // Calculate the direction factors using the angle of the spacepod
    var/factor_x = cos(90 - angle)
    var/factor_y = sin(90 - angle)

    // Calculate the shift factors for projectile's starting position
    var/shift_x = factor_y
    var/shift_y = -factor_x

    // Calculate the pixel offset for the projectile's starting position
    var/offset_pixel_x = (offset_x * 32)
    var/offset_pixel_y = (offset_y * 32)

    // Calculate the projectile's starting position based on the spacepod's position
    var/calculated_x = offset_pixel_x + factor_x * override_offset_x + shift_x * override_offset_x
    var/calculated_y = offset_pixel_y + factor_y * override_offset_y + shift_y * override_offset_y

    // Get the turf where the spacepod is currently located
    var/turf/iterating_turf = get_turf(src)

    // Adjust the iterating_turf in the EAST/WEST direction based on calculated_x
    while(calculated_x > 16)
        iterating_turf = get_step(iterating_turf, EAST)
        calculated_x -= 32
    while(calculated_x < -16)
        iterating_turf = get_step(iterating_turf, WEST)
        calculated_x += 32

    // Adjust the iterating_turf in the NORTH/SOUTH direction based on calculated_y
    while(calculated_y > 16)
        iterating_turf = get_step(iterating_turf, NORTH)
        calculated_y -= 32
    while(calculated_y < -16)
        iterating_turf = get_step(iterating_turf, SOUTH)
        calculated_y += 32

    // If iterating_turf is valid, create and fire the projectile
    if(iterating_turf)
        // Create the projectile object
        var/obj/projectile/projectile = new projectile_type(iterating_turf)

        // Set the projectile's properties
        projectile.starting = iterating_turf
        projectile.firer = src
        projectile.def_zone = "chest"
        projectile.original = target
        projectile.pixel_x = round(calculated_x)
        projectile.pixel_y = round(calculated_y)

        // Fire the projectile at the given angle
        projectile.fire(angle)
