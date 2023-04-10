/**
 * process_physics_bump
 *
 * When our physics component processes a bump, we handle our interacitons.
 */
/obj/spacepod/proc/process_physics_bump(datum/source, bump_velocity, atom/bumped_atom)
	SIGNAL_HANDLER

	// Try to open airlock doors
	if(istype(bumped_atom, /obj/machinery/door/airlock))
		INVOKE_ASYNC(src, PROC_REF(async_door_bump), bumped_atom)

	// Play collision sound if bump_velocity is greater than 5
	if(bump_velocity > 5)
		playsound(src, pick(list('modular_skyrat/modules/spacepods/sound/hit_hull_1.ogg', 'modular_skyrat/modules/spacepods/sound/hit_hull_2.ogg', 'modular_skyrat/modules/spacepods/sound/hit_hull_3.ogg')), 70)

	// Handle fast collisions
	if(bump_velocity > SPACEPOD_IMPACT_HEAVY && !ismob(bumped_atom))
		var/strength = min((bump_velocity / 10) ** 2, 5) // Calculate and limit the strength of the collision
		explosion(bumped_atom, -1, round((strength - 1) / 2), round(strength))

		// Log and notify admins of the collision
		var/rider = key_name_admin(pick(get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT)))
		message_admins("[rider] has impacted a spacepod into [bumped_atom] with velocity [bump_velocity]")
		take_damage(strength * 10, BRUTE, "melee", TRUE)
		log_game("[rider] has impacted a spacepod into [bumped_atom] with velocity [bump_velocity]")
		visible_message(span_danger("The force of the impact causes a shockwave"))

	// Handle collisions with living entities if bump_velocity is greater than 5
	else if(isliving(bumped_atom) && bump_velocity > SPACEPOD_IMPACT_LIGHT)
		var/mob/living/smashed_mob = bumped_atom
		smashed_mob.apply_damage(bump_velocity * 2)
		take_damage(bump_velocity, BRUTE, "melee", FALSE)
		playsound(smashed_mob.loc, "swing_hit", 100, 1, -1)
		smashed_mob.Knockdown(bump_velocity * 2)
		smashed_mob.visible_message(span_warning("The force of the impact knocks [smashed_mob] down!"), span_userdanger("The force of the impact knocks you down!"))

		// Log the collision with the living entity
		var/pilot = pick(get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT))
		log_combat(pilot, smashed_mob, "impacted", src, "with velocity of [bump_velocity]")

/**
 * async_door_bump
 *
 * Async opens doors and checks ID of the pilot(s)
 */
/obj/spacepod/proc/async_door_bump(obj/machinery/door/bumped_door)
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


/**
 * Fire Projectile
 *
 * Fires a projectile from the spacepod.
 */
/obj/spacepod/proc/fire_projectile(projectile_type, target, override_offset_x, override_offset_y)
	// Calculate the direction factors using the angle of the spacepod
	var/factor_x = cos(90 - component_angle)
	var/factor_y = sin(90 - component_angle)

	// Calculate the shift factors for projectile's starting position
	var/shift_x = factor_y
	var/shift_y = -factor_x

	// Calculate the pixel offset for the projectile's starting position
	var/offset_pixel_x = (component_offset_x * 32)
	var/offset_pixel_y = (component_offset_y * 32)

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
		projectile.fire(component_angle)

/**
 * set_angle
 *
 * Sets the pods angle
 */
/obj/spacepod/proc/set_angle(new_angle)
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_ANGLE, new_angle)
