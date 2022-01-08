/*
	High leap, a long distance attack ability.
	The user jumps into the air, briefly going offscreen and untargetable, before landing at the target point

	A jump happens in four stages:
		Windup: We compress and push off from the ground. Sleep and then immediately call launch
		Launch: We leave the ground and start travelling to the destination. Calculate when we should land and schedule for then
		Landing: We drop in from above and land on the ground. Sleep and then immediately call wind down
		Wind down: We recover from landing
*/
/datum/extension/high_leap
	name = "High Leap"
	base_type = /datum/extension/high_leap
	expected_type = /atom/movable
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/power = 1
	var/cooldown = 1 SECOND

	var/started_at
	var/stopped_at

	var/ongoing_timer

	var/turf/start_location

	//Must travel at least this far
	var/minimum_range = 3

	//Metres per second, while in the air. Note that this speed is not guaranteed, short-ranged jumps may go slower than this to make the animation look right
	var/travel_speed = 8

	//Time between giving command and actually taking off
	var/windup_time = 1 SECOND

	//Recovery time after landing
	var/winddown_time = 1 SECOND

	//How long does the launching animation take? We'll start travel during this animation, so this is a minimum rather than an addition
	var/launch_time = 4
	//Like above, at the landing end
	var/land_time = 4

	var/turf/target_loc

	//If not null, this is the thing we collided with while jumping
	var/obstacle = null

	var/distance = 0

	//Temporary vars stored while travelling
	var/cached_density = TRUE

	statmods = list(STATMOD_EVASION, 200)
	auto_register_statmods = FALSE

/datum/extension/high_leap/New(var/atom/movable/user, var/target, var/windup_time, var/winddown_time, var/cooldown, var/minimum_range = 3, var/travel_speed = 6)
	.=..()
	if (isliving(user))
		src.user = user
		windup_time /= user.get_attack_speed_factor() //Factor in attackspeed
		winddown_time /= user.get_attack_speed_factor()
		cooldown /= user.get_attack_speed_factor() //Factor in attackspeed
	target_loc = get_turf(target)
	src.cooldown = cooldown
	src.windup_time = windup_time
	src.winddown_time = winddown_time
	src.minimum_range = minimum_range
	src.travel_speed = travel_speed
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/high_leap/proc/windup), 0, TIMER_STOPPABLE)



/*----------------------------------
	Windup
-----------------------------------*/
/datum/extension/high_leap/proc/windup()



	var/atom/A = holder
	started_at	=	world.time

	//First of all lets find our landing point. We have our desired target loc, but it may not be valid

	//We have a minimum range. If its not far enough, we extend out
	distance = get_dist(holder, target_loc)
	if (distance < minimum_range)
		var/vector2/direction = Vector2.DirectionBetween(A, target_loc)
		direction *= minimum_range
		distance = minimum_range

		target_loc = locate(A.x + direction.x, A.y + direction.y, A.z)
	user.face_atom(target_loc)

	if (user)
		user.disable(windup_time)


	//Alright now secondly, lets look for obstacles that might block us
	var/list/results = check_trajectory_verbose(target_loc, holder, pass_flags=PASS_FLAG_TABLE|PASS_FLAG_FLYING|PASS_FLAG_NOMOB)
	if (results[3] != target_loc)
		//Uh oh, there's an obstacle here
		obstacle = results[3]	//We will crash into this later


	target_loc = results[2]	//We'll set our target to wherever the projectile reached

	windup_animation()
	sleep(windup_time)

	//Launch immediately after animation
	launch()

/datum/extension/high_leap/proc/windup_animation()
	var/atom/A = holder
	var/matrix/M = A.get_default_transform()
	M = M.Scale(1, 0.8)	//Squish vertically

	animate(A, transform = M, time = windup_time * 0.665, pixel_y = A.default_pixel_y - 16, easing = QUAD_EASING, flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE)

	M = A.get_default_transform()
	animate(transform = M, pixel_y = A.default_pixel_y, time = windup_time * 0.33)

	//Animation


/*----------------------------------
	Launch
-----------------------------------*/
//Now we actually take off from the ground
/datum/extension/high_leap/proc/launch()
	var/atom/A = holder
	//Cache some values before we launch
	cached_density = A.density
	A.density = FALSE
	register_statmod(STATMOD_EVASION)

	start_location = get_turf(A)



	//Alright lets calculate when we're going to land. More specifically, we'll calculate when exactly we want landing to -finish- happening
	var/travel_time = (distance / travel_speed) SECONDS	//This is how long it takes us to move from A to B
	if (travel_time < (launch_time + land_time))
		//We have minimum durations for takeoff and land animations, so those place a floor on how long this can take
		//And if we modified the travel time, we must modify the speed to accomodate it too
		travel_time = max(travel_time, launch_time + land_time)
		travel_speed = distance / (travel_time*0.1)


	//Okay now we know when landing will finish, and how long it will take. Lets set the timer to when we should start landing
	addtimer(CALLBACK(src, /datum/extension/high_leap/proc/land), (travel_time - land_time))

	//Also make sure the user isnt moving or clicking stuff while this happens
	user.disable(travel_time)

	//And finally, the most important step of all.
	//ACTUALLY MOVE US TOWARDS THE DESTINATION
	//Animate movement has no collision checks, but thats fine because we already did them before starting
	animate_movement(holder, target_loc, travel_speed)

	spawn(1)
		//We do the launch animation after
		launch_animation()




//The sprite shifts upwards, grows and fades out as we leap up and out of view
/datum/extension/high_leap/proc/launch_animation()

	var/atom/A = holder
	var/matrix/M = A.get_default_transform()
	M = M.Scale(1.5)
	animate(A, transform = M,  pixel_y = 128, alpha = -A.default_alpha, time = launch_time, flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE)


/*----------------------------------
	Land
-----------------------------------*/
//At this point we are almost hovering over our destination, we come in hard
/datum/extension/high_leap/proc/land()
	land_animation()
	unregister_statmods()
	sleep(land_time)

	//TODO: Impact here
	var/atom/movable/A = holder
	A.high_leap_impact(target_loc, distance, start_location)

	//If an obstacle blocked the leap from going its full distance, we crash into that on landing
	if (obstacle)
		A.charge_impact(obstacle, 1, CHARGE_TARGET_SECONDARY, distance)


	//Do the final stage
	winddown()



/datum/extension/high_leap/proc/land_animation()
	var/atom/A = holder
	var/matrix/M = A.get_default_transform()
	animate(A, transform = M,  pixel_y = A.default_pixel_y, alpha = A.default_alpha, time = land_time)


/*----------------------------------
	Wind Down
-----------------------------------*/
/datum/extension/high_leap/proc/winddown()
	//Last disable, you'll be free to move soon
	if (user)
		user.disable(winddown_time)
	winddown_animation()
	sleep(winddown_time)
	stop()


/datum/extension/high_leap/proc/winddown_animation()
	var/atom/A = holder
	var/matrix/M = A.get_default_transform()
	M = M.Scale(1, 0.8)	//Squish vertically
	animate(A, transform = M, time = winddown_time * 0.33, pixel_y = A.default_pixel_y - 16, easing = QUAD_EASING, flags = ANIMATION_PARALLEL|ANIMATION_RELATIVE)
	M = A.get_default_transform()
	animate(transform = M, pixel_y = A.default_pixel_y, time = winddown_time * 0.66)
	sleep(windup_time)
	//Animation



/datum/extension/high_leap/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/high_leap/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/high_leap/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)


/datum/extension/high_leap/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed



/*----------------------------------
	Impact
-----------------------------------*/
/atom/movable/proc/high_leap_impact(var/atom/target, var/distance, var/start_location)
	return

//When a human does it, we call the same proc on their species. This allows various people to do stuff
/mob/living/carbon/human/high_leap_impact(var/atom/target, var/distance, var/start_location)
	shake_camera(src,3,1)
	if (species)
		return species.high_leap_impact(src, target, distance, start_location)
	return ..()


/datum/species/proc/high_leap_impact(var/mob/living/user, var/atom/target, var/distance, var/start_location)
	return

/***********************
	Safety Checks
************************/
//Access Proc


/atom/movable/proc/can_high_leap(var/error_messages = TRUE)
	var/datum/extension/high_leap/E = get_extension(src, /datum/extension/high_leap)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already Leaping"))
		return FALSE

	return TRUE

/mob/living/can_high_leap(var/error_messages = TRUE)
	if (incapacitated(INCAPACITATION_IMMOBILE))
		return FALSE

	.=..()

/atom/movable/proc/high_leap_ability(var/target, var/windup_time, var/winddown_time, var/cooldown, var/minimum_range = 3, var/travel_speed = 4)
	//First of all, lets check if we're currently able to charge
	if (!can_high_leap())
		return FALSE

	//Ok we've passed all safety checks, let's commence charging!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, /datum/extension/high_leap, target, windup_time, winddown_time, cooldown, minimum_range, travel_speed)
	return TRUE