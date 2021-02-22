
/*
	Code for generic charge attack:

	A charge attack makes the mob move rapidly towards a target, and then call a proc when the mob either bumps into the target (if dense)
	or enters the same tile as it.

	Generally charging is made for mobs, but it could be used for projectiles too, so i'm leaving it open for all movable atoms


	Charge takes several variables:

		Target: Must be an atom with a non-null location on the same zlevel. Required
		Speed: How fast to move this mob towards the target, in metres (tiles) per second. Required
		Time: Maximum time in deciseconds we will spend attempting to reach the target. If this much time elapses, the charge is aborted
			A time is needed, default is 2 seconds
		Range: Maximum number of tiles we will cross while chasing the target. If we meet this range the charge is aborted
			Optional, the default value of 0 disables range limits
		Homing: If true, we will keep moving towards the target even when they move.
			If false, we will aim at the spot they were standing when we started, and miss them if they aren't in it
			Optional, Default True
		Inertia: Only used if homing is false.
			If inertia is true, and we miss the target, we will keep going until we meet maximum range, maximum time, or crash into something dense
			optional, default false
		Power: Used for breaking obstacles mid-charge, this should be a value in the range -3 to 3.
			In most cases, leave it at 0 unless you're doing something special and understand what you're doing
			This will be combined with the size of the charging mob to determine the effect on obstacles in the way
			An ordinary humanoid will have a power of 1
			optional, default 0
*/

#define CHARGE_TARGET_PRIMARY	"primary"
#define CHARGE_TARGET_SECONDARY	"secondary"
#define CHARGE_DAMAGE_BASE	15	//Basic damage of charges dealt to mobs, per power point
#define CHARGE_DAMAGE_DIST	2	//Extra damage dealt by charge per tile travelled while charging



//States of a charge
#define CHARGE_STATE_WINDUP		"windup"	//We're preparing to charge, maybe screaming a bit
#define CHARGE_STATE_CHARGING	"charging"	//We're running towards a target
#define CHARGE_STATE_COOLDOWN	"cooldown"	//We're cooling after a charge
/*
	The charge extension is attached to a mob and acts as a puppeteer to move it
*/
/datum/extension/charge
	name = "Charge"
	var/verb_name = "Charging"
	var/verb_action = "charges"
	base_type = /datum/extension/charge
	expected_type = /atom/movable
	flags = EXTENSION_FLAG_IMMEDIATE
	var/status = CHARGE_STATE_WINDUP

	var/atom/target = null //What we want to hit
	var/atom/move_target = null //What we're actually running towards, may not be the same
	var/speed = 5
	var/lifespan = 0
	var/homing = TRUE
	var/inertia = FALSE
	var/power = 0
	var/force_multiplier = 1	//A multiplier on the physical force applied to shove victims away. Set to 0 to disable
	var/cooldown = 20 SECONDS	//After the charge completes, it will stay on the user and block additional charges for this long
	var/continue_check = TRUE	//Check for incapacitated status every step
	var/delay
	var/nomove_timeout	=	0.75 SECONDS	//After the charge starts, if we go this long without taking a step, end the charge
	var/nomove_timer

	//Runtime data
	var/distance_travelled = 0
	var/list/atoms_hit = list()//Bumped observation may make duplicate calls. We'll use this to filter them out
	var/lifespan_timer
	var/start_timer
	var/atom/movable/user
	var/mob/living/L
	var/started_at = 0
	var/stopped_at
	var/range_left = null //Null value means we're not using range limits

	var/step_interval = 1	//Replaces the user's step interval for the duration of the charge
	var/cached_step_interval

	var/blur_filter_strength = 2
	var/dm_filter/blur
	var/starting_locomotion_limbs = 0	//How many legs or similar appendages we had when we started. We will abort the charge if this value decreases

	var/atom/last_obstacle
	var/last_target_type
	var/do_winddown_animation = TRUE	//If false, we will not animate back to normal. Only set it false when something else will handle it


/datum/extension/charge/New(var/datum/holder, var/atom/_target, var/_speed , var/_lifespan, var/_maxrange, var/_homing, var/_inertia = FALSE, var/_power, var/_cooldown, var/_delay)
	.=..()
	user = holder



	target = _target
	speed = _speed * user.get_move_speed_factor()
	lifespan = _lifespan
	range_left = _maxrange
	homing = _homing
	inertia = _inertia
	if (inertia)	//Inertia and homing are mutually exclusive
		homing = FALSE
	power = _power
	cooldown = _cooldown
	if (cooldown)
		cooldown /= user.get_attack_speed_factor() //Factor in attackspeed

	delay = _delay

	if (isliving(user))
		L = user
		L.face_atom(target)
		L.disable(max_lifespan())
		starting_locomotion_limbs = length(L.get_locomotion_limbs(FALSE))
	//Delay handling
	if (!delay)
		//If no delay, start immediately
		start()
	else if (isnum(delay) && delay > 0)
		delay /= user.get_attack_speed_factor() //Factor in attackspeed

		//If positive delay, wait that long before starting
		start_timer = addtimer(CALLBACK(src, .proc/start), _delay, TIMER_STOPPABLE)

/datum/extension/charge/proc/check_limbs(var/trip = FALSE)
	if (L)
		var/num_legs = length(L.get_locomotion_limbs(FALSE))
		if (num_legs < starting_locomotion_limbs)
			if (trip)
				L.trip()
			return FALSE

	return TRUE

/datum/extension/charge/proc/start()

	//If we are currently wallcrawling, stop it
	user.unmount_from_wall()
	if (ishuman(user))
		var/mob/living/carbon/human/H = user
		cached_step_interval = H.step_interval
		H.step_interval = src.step_interval
	if (start_timer)
		deltimer(start_timer)

	if (!check_limbs(TRUE))
		stop()
		return FALSE

	//Something may have disabled us between windup and starting
	if (!user || (continue_check && !user.can_continue_charge(target)))
		stop()
		return FALSE

	status = CHARGE_STATE_CHARGING
	GLOB.bump_event.register(holder, src, /datum/extension/charge/proc/bump)
	GLOB.moved_event.register(holder, src, /datum/extension/charge/proc/moved)

	started_at = world.time

	if (homing)
		//If homing, we aim straight for the thing
		move_target = target
	else if (!inertia)
		//If no homing or inertia, we aim for the tile the thing is on
		move_target = get_turf(target)
	else
		//Note: This may fail near the map edge, if it overshoots world bounds. Tricky to fix, probably won't be a problem
		var/vector2/delta = new(target.x - user.x, target.y - user.y)
		delta.SelfToMagnitude(max_range()+1)
		var/turf/target_turf = locate(user.x + delta.x, user.y + delta.y, user.z)
		if (target_turf)
			move_target = target_turf
		else
			move_target = get_turf(target) //fallback incase of failure

	if (isnum(lifespan) && lifespan > 0)
		lifespan_timer = addtimer(CALLBACK(src, .proc/stop_peter_out), lifespan, TIMER_STOPPABLE)

	user.visible_message(SPAN_DANGER("[user] [verb_action] at [target]!"))

	walk_towards(holder, move_target, SPEED_TO_DELAY(speed))
	user.charge_started(src)

	nomove_timer = addtimer(CALLBACK(src, .proc/stop_peter_out), nomove_timeout, TIMER_STOPPABLE)



/datum/extension/charge/proc/stop()
	if (isliving(user))
		if (ishuman(user))
			var/mob/living/carbon/human/H = user
			H.step_interval = cached_step_interval
		L.enable()

	GLOB.bump_event.unregister(holder, src, /datum/extension/charge/proc/bump)
	GLOB.moved_event.unregister(holder, src, /datum/extension/charge/proc/moved)
	walk(holder, 0)
	stopped_at = world.time
	if (lifespan_timer)
		deltimer(lifespan_timer)

	deltimer(nomove_timer)

	if (blur)
		user.filters.Remove(blur)
		blur = null

	user.charge_ended(src)

	//When we finish, we go on cooldown
	if (cooldown && cooldown > 0)
		status = CHARGE_STATE_COOLDOWN
		addtimer(CALLBACK(src, /datum/extension/charge/proc/finish_cooldown), cooldown)
	else
		finish_cooldown() //If there's no cooldown timer call it now


/datum/extension/charge/proc/finish_cooldown()
	to_chat(user, SPAN_NOTICE("You are ready to [name] again")) //Use name here so i can reuse this for leaping
	if (holder) //Apparently holder can be null here
		remove_extension(holder, src.base_type)
	else
		qdel(src)



/datum/extension/charge/proc/bump(var/atom/movable/user, var/atom/obstacle, var/crossed = FALSE)
	if (obstacle in atoms_hit)
		return //Don't hit the same atom more than once

	//Cache this, other things will check it
	last_obstacle = obstacle

	var/obstacle_oldloc = obstacle.loc//Cache where the obstacle is

	last_target_type = CHARGE_TARGET_SECONDARY
	if (obstacle == target)
		last_target_type = CHARGE_TARGET_PRIMARY


	if(!user.charge_impact(src))
		stop_success()
		return FALSE
	atoms_hit += obstacle


	//If that was our intended target, then we win
	if (last_target_type == CHARGE_TARGET_PRIMARY)
		//However, there's an exception here.
		//If this charge has inertia, we don't stop until we ARE stopped.
		if (!inertia)
			stop_success()
			return FALSE

	//We stop if:
	//the obstacle still exists, it still will not give way, and it hasn't moved
	//In other words, we continue if the obstacle was destroyed, or entered some kind of state where it now lets us through, or was moved out of its position
	if ((obstacle && !QDELETED(obstacle)) && !obstacle.CanPass(user, get_turf(obstacle), 1))

		//Position checking is more complex

		//If its not a movable atom, then it can never move
		var/atom/movable/AM = obstacle
		if (!istype(AM))
			stop_obstacle(obstacle)
			return FALSE


		//If the object hasn't moved, it may be blocking us.
		//Buuuut it may also just be waiting to move
		if (AM.loc == obstacle_oldloc)
			//If it's anchored it'll never move
			if (AM.anchored)
				stop_obstacle(obstacle)
				return FALSE
			else
				//If unanchored, it might move. We're going to spawn, and then redo all the checks
				spawn(1)
					if ((obstacle && !QDELETED(obstacle)) && !obstacle.CanPass(user, get_turf(obstacle), 1) && obstacle.loc == obstacle_oldloc)
						stop_obstacle(obstacle)
						return FALSE

	//Return true if we have not stopped, and will keep going
	return TRUE




/datum/extension/charge/proc/moved(var/atom/mover, var/oldloc, var/newloc)
	.=TRUE





	//First of all, make us fall over if we lost a limb
	if (!check_limbs(TRUE))
		stop_peter_out()
		return FALSE


	//When we move, deplete the remaining range, and abort if we run out
	distance_travelled++
	if (isnum(range_left))
		range_left --
		if (range_left <= 0)
			stop_peter_out()
			return FALSE




	//If we have entered the same turf as our target then it must have been nondense. Let's hit it
	if (user.loc == target.loc)
		.=bump(user, target, TRUE) //Passing true here indicates we crossed over the target rather than crashing into them. This affects whether we'll stop in inertia mode
	else
		//Light shake with each step
		shake_camera(src,1.5,0.5)


	//We allow the above to happen first cuz momentum
	//Now we'll check if we're able to continue
	if (!user || (continue_check && !user.can_continue_charge(target)))
		stop_peter_out()
		return FALSE

	//Update the nomove timer when we move
	deltimer(nomove_timer)
	nomove_timer = addtimer(CALLBACK(src, .proc/stop_peter_out), nomove_timeout, TIMER_STOPPABLE)
	update_blur_filter(mover,oldloc,newloc)

/datum/extension/charge/proc/get_total_power()
	var/total = power
	if (ismob(holder))
		var/mob/M = holder
		if (M.mob_size >= MOB_LARGE)
			total += 2
		else if (M.mob_size >= MOB_MEDIUM)
			total += 1
		else if (M.mob_size >= MOB_SMALL)
			total += 0
		else if (M.mob_size >= MOB_TINY)
			total += -1
		else
			total += -2
	return total

/datum/extension/charge/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed


//Figures out how far this charge could feasibly go if not blocked.
/datum/extension/charge/proc/max_range()
	if (!lifespan)
		return range_left

	var/lifemax = round((lifespan*0.1) * speed) //Lifespan is in deciseconds so we change it to seconds,
	//and then multiply by speed which is in tiles per second
	//We also round off, because can't go part of a tile

	if (!range_left)
		return lifemax

	return min(range_left, lifemax)

//Figures out how long this charge could feasibly endure for, if not blocked
/datum/extension/charge/proc/max_lifespan()
	.= lifespan
	if (!range_left)
		return

	var/rangemax = (range_left / speed) SECONDS
	return min(lifespan, rangemax)

//Stop Wrappers:
//-------------------
//Various methods of stopping that do an additional effect and then call stop


//Called when we run into something we can't break through.
/datum/extension/charge/proc/stop_obstacle(var/atom/obstacle)
	var/TP = get_total_power()

	//Screenshake everyone near the impact site
	for (var/mob/M in range(TP, obstacle))
		shake_camera(M,10*TP,2)

	obstacle.shake_animation(8*TP)
	if (isliving(holder))
		//Damage the user and stun them

		var/mob/living/L = holder
		var/selfdamage = CHARGE_DAMAGE_BASE*TP + CHARGE_DAMAGE_DIST*distance_travelled
		if (L.max_health)
			selfdamage = min(L.max_health*0.15, selfdamage)
		L.stunned = 0
		L.take_overall_damage(selfdamage, 0,0,0, obstacle)
		L.Stun(2*TP)
	stop()

//Called when we reach max time or range
//Drain the user's stamina?
/datum/extension/charge/proc/stop_peter_out()
	if (isliving(holder))
		var/mob/living/L = holder
		L.stunned = 0
	stop()


//We have ended the charge by successfully reaching our intended target. This is ideal
/datum/extension/charge/proc/stop_success()
	if (isliving(holder))
		var/mob/living/L = holder
		L.stunned = 0
	var/TP = get_total_power()
	//Screenshake everyone near the impact site
	for (var/mob/M in range(TP))
		shake_camera(M,10*TP,2)
	stop()






//Visual Filters
//------------------------
/datum/extension/charge/proc/update_blur_filter(var/atom/mover,	var/atom/oldloc,	var/atom/newloc)
	if (stopped_at || !blur_filter_strength)
		return

	if (!blur)
		var/newfilter = filter(type="motion_blur", x=1,y=1)
		mover.filters.Add(newfilter)
		blur = mover.filters[mover.filters.len]

	var/vector2/direction = Vector2.DirectionBetween(oldloc, newloc)
	direction *= blur_filter_strength

	blur.x = direction.x
	blur.y = direction.y







//Extra procs
//---------------------------

///Called when this atom is hit by a charging mob
//Return false if you want to stop the charge for some special reason.
//Note that the reason of: "We are dense and not broken so you can't get past" is already checked for. It's gotta be something other than that
/atom/proc/charge_act(var/datum/extension/charge/charge)
	if (charge.power > 0)
		ex_act(max(4-charge.power, 1)) //Ex act has tons of interactions already, we'll use it

	return TRUE


//Mobs take some damage and get stunned
/mob/living/charge_act(var/datum/extension/charge/charge)
	shake_camera(src,10*charge.power,1)
	var/charge_power = charge.get_total_power()
	shake_camera(src,10*charge_power,1)
	if (isliving(charge.user))
		var/mob/living/L = charge.user
		//We can't be hurt by things smaller than ourselves. they bounce off
		if (L.mob_size < mob_size)
			return FALSE



		L.launch_strike(src, CHARGE_DAMAGE_BASE*charge.power, L)
		L.launch_strike(src, CHARGE_DAMAGE_BASE*charge_power, L)
		//take_overall_damage((CHARGE_DAMAGE_BASE*power), 0,0,0, mover)
	apply_effect(3*charge_power, STUN)
	apply_push_impulse_from(charge.user, charge.user.mass*charge.force_multiplier, 0)
	return TRUE


//Called when this atom hits something while charging
//target type will either be primary or secondary
	//Primary = The thing our charge was aimed at
	//Secondary = Something that got in the way while enroute to the primary target
/atom/movable/proc/charge_impact(var/datum/extension/charge/charge)
	shake_camera(src,3,1)
	return charge.last_obstacle.charge_act(charge)


//When a human does it, we call the same proc on their species. This allows various people to do stuff
/mob/living/carbon/human/charge_impact(var/datum/extension/charge/charge)
	shake_camera(src,3,1)
	if (species)
		return species.charge_impact(charge)
	return ..()



/datum/species/proc/charge_impact(var/datum/extension/charge/charge)
	return charge.last_obstacle.charge_act(charge)


//Called when this atom starts charging at another, just before taking the first step
/atom/proc/charge_started(var/datum/extension/charge/charge)

//Called when this atom starts finishes a charge, called after everything, just before the cooldown timer starts
/atom/proc/charge_ended(var/datum/extension/charge/charge)

//	Triggering
//------------------------
/atom/movable/proc/charge_verb(var/atom/A)
	set name = "Charge"
	set category = "Abilities"


	return charge_attack(A)


/atom/movable/proc/can_charge(var/atom/target, var/error_messages = TRUE)
	//Check for an existing charge extension. that means a charge is already in progress or cooling down, don't repeat
	var/datum/extension/charge/EC = get_extension(src, /datum/extension/charge)
	if(istype(EC))
		if (EC.status == CHARGE_STATE_COOLDOWN)
			if(error_messages) to_chat(src, "[EC.name] is cooling down. You can use it again in [EC.get_cooldown_time() /10] seconds")
			return
		if(error_messages) to_chat(src, "You're already [EC.verb_name]!")
		return FALSE

	var/dist = get_dist(src, target)
	if (dist <= 1)
		if(error_messages) to_chat(src, "You are too close to [target], get some distance first!")
		return FALSE


	return TRUE

/mob/living/can_charge(var/atom/target, var/error_messages = TRUE)
	if (incapacitated(INCAPACITATION_IMMOBILE))
		return FALSE

	.=..()


//Called periodically to check if we can keep charging
/atom/movable/proc/can_continue_charge(var/atom/target)
	if (QDELETED(src))
		return FALSE
	return TRUE

/mob/living/can_continue_charge(var/atom/target)
	if (incapacitated(INCAPACITATION_IMMOBILE))
		return FALSE

	return ..()

/atom/movable/proc/charge_attack(var/atom/_target, var/_speed = 7, var/_lifespan = 2 SECONDS, var/_maxrange = null, var/_homing = TRUE, var/_inertia = FALSE, var/_power = 0, var/_cooldown = 20 SECONDS, var/_delay = 0)
	//First of all, lets check if we're currently able to charge
	if (!can_charge(_target, TRUE))
		return FALSE


	//Ok we've passed all safety checks, let's commence charging!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, /datum/extension/charge, _target, _speed, _lifespan, _maxrange, _homing, _inertia, _power, _cooldown, _delay)

	return TRUE

