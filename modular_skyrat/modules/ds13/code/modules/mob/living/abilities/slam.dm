/*
	Slam is an AOE melee attack, primarily used by the necromorph brute.
	Slam strikes a three-tile arc either side of an epicentre.

	Any mobs in the affected area take heavy damage. This damage is multiplied if the victim is lying down, or otherwise incapacitated
	Any standing mobs in the affected area which are smaller than the attacker, will be knocked down for a time
	Any dense nonmob atoms in the affected area are hit twice
*/

/*
	Extension
*/
/datum/extension/slam
	name = "Slam"
	var/verb_name = "Slamming"
	expected_type = /atom/movable
	flags = EXTENSION_FLAG_IMMEDIATE
	var/atom/movable/user	//The mob or thing doing the slam attack
	var/turf/epicentre			//The turf we've targeted with the slam
	var/damage	=	40			//Base damage dealt
	var/power = 1				//Used for damage to atoms
	var/down_factor = 2			//Base damage is multiplied by this on lying targets
	var/weaken_time = 3			//Number of life ticks victims are weakened (knocked down) for. A life tick is generally 1 second
	var/windup_time	= 2 SECONDS	//How long the attack is telegraphed for
	var/cooldown = 8 SECONDS

	//Extra runtime vars
	var/vector2/cached_pixels	//Cache the user's pixel offsets so we can revert to them
	var/slam_timer				//Timer handle for slam
	var/x_direction = 0
	var/list/affected_turfs
	var/list/affected_turfs_secondary
	var/stopped_at

/datum/extension/slam/New(var/atom/movable/user, var/atom/target, var/_damage, var/_down_factor, var/_weaken_time, var/_power, var/_windup_time, var/_cooldown)
	..()
	src.user = user
	epicentre = get_turf(target) //This attack can be dodged. If we target a mob, we'll hit where they were standing at the initiation time, whether they're still there or not
	damage = _damage
	down_factor = _down_factor
	weaken_time = _weaken_time
	power = _power
	windup_time = _windup_time /= user.get_attack_speed_factor() //Factor in attackspeed
	if (cooldown)
		cooldown = _cooldown /= user.get_attack_speed_factor() //Factor in attackspeed

	start()

/datum/extension/slam/proc/start()
	if (isliving(user))
		//Lets face the thing
		var/mob/living/L = user
		L.face_atom(epicentre)

		//We'll stun the user so they can't move during the animation
		//The extra number added to windup time is the total of all the little sleeps used throughout the process
		var/stuntime = Ceiling((windup_time + 13) / 10) //Stuntime is in life ticks, so we divide by 10, and round up to the nearest integer
		L.Stun(stuntime, TRUE) //Passing true here bypasses species resistance

	//Here we start the windup.
	cached_pixels = get_new_vector(user.pixel_x, user.pixel_y)



	//If the epicentre is offset on our X axis, we'll have an extra factor on the animation
	if (epicentre.x > user.x)
		x_direction = 1
	else if (epicentre.x < user.x)
		x_direction = -1


	//We do the windup animation. This involves the user slowly rising into the air, and tilting back if striking horizontally
	animate(user, transform=turn(matrix(), user.default_rotation + (25*(x_direction*-1))),pixel_y = cached_pixels.y + 16, time = windup_time)

	//Start a timer
	slam_timer = addtimer(CALLBACK(src, .proc/finish), windup_time, TIMER_STOPPABLE)

	//While that's running, lets quickly calculate the affected turfs
	LAZYADD(affected_turfs, epicentre)
	var/dir2centre = get_dir(user, epicentre)
	//We add the turfs that are at + and - 45 degrees from that direction
	LAZYADD(affected_turfs, get_step(user, turn(dir2centre, 45)))
	LAZYADD(affected_turfs, get_step(user, turn(dir2centre, -45)))

	//Next lets add secondary turfs
	for (var/turf/T in affected_turfs)
		var/turf/T2 = get_step(T, dir2centre)
		if (istype(T2))
			LAZYADD(affected_turfs_secondary,T2)

/datum/extension/slam/proc/finish()
	//Lets finish the slamming animation. We drop sharply back to the floor
	//And, if we had an x offset, we'll also strike there
	animate(user, transform=turn(matrix(), user.default_rotation + (35*x_direction)), pixel_y = cached_pixels.y-8, pixel_x = cached_pixels.x + 24*x_direction, time = 3, easing = BACK_EASING)

	sleep(2)
	//Wait a little, then we strike

	//The heavier the damage, the louder the sound. This is a fancy trick i learned
	//Playing a sound several times slightly overlapping, makes, it MUCH louder
	playsound(epicentre, 'sound/weapons/heavysmash.ogg', 100, 1, 20,20)
	if (damage > 15)
		spawn(1)
			playsound(epicentre, 'sound/weapons/heavysmash.ogg', 100, 1, 20,20)
	if (damage > 30)
		spawn(2)
			playsound(epicentre, 'sound/weapons/heavysmash.ogg', 100, 1, 20,20)


	//Now lets damage all the things
	for (var/turf/T in affected_turfs)

		for (var/atom/A in T.contents)
			A.shake_animation(damage)	//Shake things!

			//Mobs take damage, with more if they're lying down
			if (isliving(A))
				var/mob/living/L = A
				var/tempdamage = damage
				if (L.lying)
					tempdamage *= down_factor
				L.Weaken(weaken_time)
				L.take_overall_damage(tempdamage, 0,0,0, user)
				shake_camera(L, 3, damage/10) //Shake camera of mobs too
			else
				//Atoms get ex_acted
				var/effective_power = power
				if (A.density)
					effective_power++
				if (effective_power)
					A.ex_act(4-effective_power, user)


		var/effective_power = power
		if (T.density)
			effective_power++
		if (effective_power)
			T.shake_animation(damage)	//Shake the turf itself
			T.ex_act(4-effective_power, user)
			if (!QDELETED(T) && T.density)
				//If the turf is dense (walls, but not floors) then it gets hit a second time
				T.ex_act(4-power, user)


	//Now we weaken these values for the next round
	damage *= 0.5
	weaken_time = round(weaken_time*0.5, 1)
	power = min(power-1, 0)

	//Secondary turfs damage, copypaste of above
	for (var/turf/T in affected_turfs_secondary)

		for (var/atom/A in T.contents)
			A.shake_animation(damage)	//Shake things!

			//Mobs take damage, with more if they're lying down
			if (isliving(A))
				var/mob/living/L = A
				var/tempdamage = damage
				if (L.lying)
					tempdamage *= down_factor
				L.Weaken(weaken_time)
				user.launch_strike(L, damage, user, target_zone = BP_CHEST)//Slam is too big to be precisely targeted, always aims center mass
				//L.take_overall_damage(tempdamage, 0,0,0, user)
				shake_camera(L, 3, damage/10) //Shake camera of mobs too
			else
				//Atoms get ex_acted
				var/effective_power = power
				if (A.density)
					effective_power++
				if (effective_power)
					A.ex_act(4-effective_power, user)

		var/effective_power = power
		if (T.density)
			effective_power++
		if (effective_power)
			T.shake_animation(damage)	//Shake the turf itself
			T.ex_act(4-effective_power, user)


	//Wait a bit longer before we return to neutral
	sleep(3)
	stop()



//Stop is called after a successful finish, or on aborting
/datum/extension/slam/proc/stop()
	deltimer(slam_timer)
	stopped_at = world.time

	//Lets smoothly slide back to a normal stance
	animate(user, transform=matrix(), pixel_y = cached_pixels.y, pixel_x = cached_pixels.x, time = 7)
	spawn(7)
		var/mob/living/L = user
		if (istype(L))
			L.stunned = 0

	//When we finish, we go on cooldown
	if (cooldown && cooldown > 0)
		addtimer(CALLBACK(src, /datum/extension/slam/proc/finish_cooldown), cooldown)
	else
		finish_cooldown() //If there's no cooldown timer call it now


/datum/extension/slam/proc/finish_cooldown()
	to_chat(user, SPAN_NOTICE("You are ready to [name] again")) //Use name here so i can reuse this for leaping
	remove_extension(holder, /datum/extension/slam)



/datum/extension/slam/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed

//	Triggering
//------------------------
/atom/movable/proc/slam_verb()
	set name = "Slam"
	set category = "Abilities"

	var/A = LAZYACCESS(args, 1)
	if (!A)
		A = get_step(src, dir)

	return slam_attack(A)


/atom/movable/proc/can_slam(var/atom/target, var/error_messages = TRUE)
	//Check for an existing charge extension. that means a charge is already in progress or cooling down, don't repeat
	var/datum/extension/slam/ES = get_extension(src, /datum/extension/slam)
	if(istype(ES))
		if (ES.stopped_at)
			if(error_messages) to_chat(src, "[ES.name] is cooling down. You can use it again in [ES.get_cooldown_time() /10] seconds")
			return
		if(error_messages) to_chat(src, "You're already [ES.verb_name]!")
		return FALSE

	if (!target)
		target = get_step(src, dir)

	var/dist = get_dist(src, target)
	if (dist > 1)
		if(error_messages) to_chat(src, "You are too far away from [target], get closer first!")
		return FALSE
	if (dist < 1)
		if(error_messages) to_chat(src, "You can't slam yourself!")
		return FALSE


	return TRUE

/mob/living/can_slam(var/atom/target, var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	.=..()


/atom/movable/proc/slam_attack(var/atom/_target, var/_damage = 40, var/_down_factor = 2, var/_weaken_time = 3, var/_power = 0, var/_windup_time = 1.75 SECONDS, var/_cooldown = 10 SECONDS)
	//First of all, lets check if we're currently able to charge
	if (!can_slam(_target, TRUE))
		return FALSE

	//Ok we've passed all safety checks, let's commence charging!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, /datum/extension/slam, _target, _damage, _down_factor, _weaken_time, _power, _windup_time, _cooldown)
	return TRUE