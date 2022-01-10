
//A swing is an area-of-effect melee attack which strikes in a multistage cone, hitting each subcone in succession over some time period
/datum/extension/swing
	name = "Swing"
	base_type = /datum/extension/swing
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/power = 1


	var/started_at
	var/stopped_at

	var/ongoing_timer

	var/atom/source
	var/vector2/target_direction
	var/angle
	var/range
	var/windup
	var/effect_type
	var/damage
	var/damage_flags
	var/stages
	var/swing_direction
	var/cooldown = 1 SECOND
	var/duration = 1 SECOND



	//Authortime
	//------------------
	//After the attack finishes, leave the effect there for this time before deleting it
	var/effect_cleanup_delay = 	0.75 SECONDS

	var/hitsound = 'sound/weapons/slice.ogg'

	//IF true, this attack hits where the user is aiming
	//Default behaviour targets a random bodypart
	var/precise = TRUE


	var/obj/effect/effect/swing/effect
	var/current_stage
	var/list/cones
	var/rotation_step
	var/step_delay

	var/progress

	var/raytrace = TRUE



/datum/extension/swing/New(var/atom/user, var/atom/source, var/atom/target, var/angle = 90, var/range = 3, var/duration = 1 SECOND, var/windup = 0, var/cooldown = 0,  var/effect_type, var/damage = 1, var/damage_flags = 0, var/stages = 8, var/swing_direction = CLOCKWISE)
	.=..()
	if (isliving(user))
		src.user = user

	//Target could be an atom to aim at, or a direction to swing in
	if (isatom(target))
		if ((get_turf(source) == get_turf(target)))
			//If source and target are on the same turf, we cant aim at the target
			target_direction = Vector2.NewFromDir(user.dir)
		else
			target_direction = Vector2.DirectionBetween(holder, target)
			if (src.user)
				src.user.face_atom(target)
	else
		target_direction = Vector2.NewFromDir(target)

	if (!source)
		src.source = get_turf(holder)

	else
		src.source = source
	src.angle = angle
	src.range = range
	src.duration = duration
	src.windup = windup
	src.cooldown = cooldown
	src.effect_type = effect_type
	src.damage = damage
	src.damage_flags = damage_flags
	src.stages = stages
	src.swing_direction = swing_direction
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/swing/proc/start), 0, TIMER_STOPPABLE)


/datum/extension/swing/Destroy()
	release_vector(target_direction)
	.=..()

/datum/extension/swing/proc/start()
	started_at	=	world.time
	windup_animation()

	if (user)
		user.disable(duration)

	//Alright lets get our cone
	var/list/cones = get_multistage_cone(source, target_direction, range, angle, stages, swing_direction)

	//Lets correct the number of stages now, it may be less than originally specified
	stages = cones.len


	//How long are we going to sleep between each stage?
	step_delay = duration / stages

	setup_effect()



	//Alright lets begin!
	var/continue_swing = TRUE
	for (current_stage in 1 to stages)
		var/list/cone = cones[current_stage]

		for (var/turf/T as anything in cone)
			//debug_mark_turf(T)
			continue_swing = hit_turf(T)
			if (!continue_swing)
				interrupt_effect()
				effect.shake_animation(30)
				break //Something stopped us!
		if (!continue_swing)
			break
		sleep(step_delay)

	stop()


/datum/extension/swing/proc/windup_animation()
	sleep(windup)


/datum/extension/swing/proc/get_effect_starting_direction()
	return target_direction.Turn((angle*0.6)*(-1 * swing_direction))


/datum/extension/swing/proc/setup_effect()
	rotation_step = angle / stages

	var/turn_angle = angle * 1.1 * swing_direction	//We want to overshoot a little for dramatic effect


	var/vector2/starting_direction = get_effect_starting_direction()

	//TODO: Create the arm effect
	effect = new effect_type(get_turf(source), source, starting_direction.Rotation())
	release_vector(starting_direction)
	var/atom/A = holder
	if (effect.inherit_order)
		effect.layer = A.layer+0.1
		effect.plane = A.plane+0.1

	animate(effect, transform = effect.transform.Turn(turn_angle), time = duration, easing = CIRCULAR_EASING)


//The swing has stopped midway. But since animate technically jumps to the end, we can't just stop the animation and expect the
//swing effect to be stopped at the right place, it would be at the end.
//So instead we have to figure out where it should be, and put it there
/datum/extension/swing/proc/interrupt_effect()
	//First of all, we figure out how far along we are from start to finish
	var/timepercent = current_stage / stages

	//Stop the ongoing animation
	animate(effect)

	//Get the direction it started at
	var/vector2/starting_direction = get_effect_starting_direction()


	//Figure out how far it should be rotated, and do so
	var/turn_angle = angle * 1.1 * swing_direction * timepercent
	starting_direction.SelfTurn(turn_angle*0.8)	//We'll do 80% of this instantly, and animate the last 20%


	//Setup the transform
	var/matrix/M = starting_direction.Rotation()
	release_vector(starting_direction)
	M.Scale(effect.default_scale)

	//And apply it
	effect.transform = M

	//Now lastly, lets animate that last 20%
	animate(effect, transform = effect.transform.Turn(turn_angle*0.2), time = step_delay)

/datum/extension/swing/proc/cleanup_effect()
	QDEL_NULL(effect)



/*
	Hitting procs
*/
//Hits a turf and the mobs in it
/datum/extension/swing/proc/hit_turf(var/turf/T)
	for (var/mob/living/L in T)
		hit_mob(L)

	//Return true to continue the swing
	return TRUE

/datum/extension/swing/proc/hit_mob(var/mob/living/L)

	if (L == user)
		return FALSE
	var/atom/A = effect
	if (raytrace && !check_trajectory(L, source, pass_flags = A.pass_flags))
		return FALSE


	source.launch_strike(L, damage, holder, damage_flags = flags, target_zone = get_target_zone(L))
	playsound(L, hitsound, VOLUME_MID, 1)
	return TRUE

/datum/extension/swing/proc/get_target_zone(var/mob/living/target)
	if (precise && user)
		return get_zone_sel(user)
	else
		return ran_zone()


/datum/extension/swing/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	spawn(effect_cleanup_delay)
		cleanup_effect()
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/swing/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)



/datum/extension/swing/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)


/datum/extension/swing/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
/atom/proc/can_swing(var/swing_type = /datum/extension/swing)

	var/datum/extension/swing/E = get_extension(src, swing_type)
	if(istype(E))
		if (E.stopped_at)
			to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
		else
			to_chat(src, SPAN_NOTICE("You're already swinging"))
		return FALSE

	return TRUE


/mob/living/can_swing(var/swing_type = /datum/extension/swing)
	if (incapacitated())
		return FALSE

	//This is a bit hackish
	if (istype(swing_type, /datum/extension/swing/arm))
		//If this fails, then they have no arms to swing with
		if (!get_swing_dir())
			return FALSE
	.=..()


/atom/proc/swing_attack(var/swing_type = /datum/extension/swing, var/atom/source, var/atom/target, var/angle = 90, var/range = 3, var/duration = 1 SECOND, var/windup = 0, var/cooldown = 0,  var/effect_type, var/damage = 1, var/damage_flags = 0, var/stages = 8, var/swing_direction = CLOCKWISE)
	if (!can_swing(swing_type))
		return FALSE

	set_extension(src, swing_type, source, target, angle, range, duration, windup, cooldown, effect_type, damage, damage_flags, stages, swing_direction)
	return TRUE



//Visuals


/obj/effect/effect/swing
	icon = 'icons/mob/necromorph/swinging_limbs.dmi'
	var/inherit_order = TRUE
	pass_flags = PASS_FLAG_NOMOB | PASS_FLAG_TABLE | PASS_FLAG_FLYING

/obj/effect/effect/swing/New(var/location, var/atom/holder, var/matrix/starting_rotation)
	//TODO: Make the effect move with the holder atom
	starting_rotation = starting_rotation.Scale(default_scale)
	transform = starting_rotation
	pixel_x = holder.pixel_x
	pixel_y = holder.pixel_y
	.=..()











