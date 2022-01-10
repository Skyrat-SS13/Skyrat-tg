/*
	Tailstrike is a delayed, animated, singletarget attack.
*/

/*
	Extension
*/
/datum/extension/tailstrike
	name = "Tail Strike"
	var/verb_name = "Tail Strike"
	expected_type = /atom/movable
	flags = EXTENSION_FLAG_IMMEDIATE
	var/mob/living/carbon/human/user	//The mob or thing doing the slam attack
	var/atom/target
	var/turf/epicentre			//The turf we've targeted with the tailstrike
	var/damage	=	25			//Base damage dealt
	var/winddown_time = 0.5 SECONDS
	var/windup_time	= 0.75 SECONDS	//How long the attack is telegraphed for
	var/cooldown = 8 SECONDS
	var/maxrange = 2

	//Extra runtime vars
	var/vector2/cached_pixels	//Cache the user's pixel offsets so we can revert to them
	var/cached_transform
	var/tailstrike_timer				//Timer handle for tailstrike
	var/x_direction = 0
	var/list/affected_turfs


	var/list/affected_turfs_secondary

	var/stopped_at
	var/attack_verb

/datum/extension/tailstrike/New(var/atom/movable/_user, var/atom/_target, var/_damage, var/_windup_time, var/_winddown_time, var/_cooldown)
	..()
	user = _user
	target = _target //The thing we originally wanted to hit. We will hit them if they were in range and don't move

	//This attack can be dodged. If we target a mob, we'll hit where they were standing at the initiation time, whether they're still there or not
	//We might have clicked on a distant tile, but this attack has a max range of 2, so lets limit it
	if (get_dist(user, target) > maxrange)
		epicentre = Vector2.TurfAtMagnitudeBetween(user, target, maxrange)
	else
		epicentre = get_turf(target)
	damage = _damage
	windup_time = _windup_time /= user.get_attack_speed_factor() //Factor in attackspeed
	winddown_time = _winddown_time /= user.get_attack_speed_factor() //Factor in attackspeed
	cooldown = _cooldown
	if (cooldown)
		cooldown /= user.get_attack_speed_factor() //Factor in attackspeed

	start()

/datum/extension/tailstrike/proc/start()
	if (isliving(user))
		//Lets face the thing
		var/mob/living/L = user
		L.face_atom(epicentre)

		//We'll stun the user so they can't move during the animation
		//The extra number added to windup time is the total of all the little sleeps used throughout the process
		var/stuntime = Ceiling((windup_time + winddown_time) / 10) //Stuntime is in life ticks, so we divide by 10, and round up to the nearest integer
		L.Stun(stuntime, TRUE) //Passing true here bypasses species resistance

	//Here we start the windup.
	cached_pixels = get_new_vector(user.pixel_x, user.pixel_y)
	cached_transform = user.transform


	//We will offseet 16 pixels towards the target
	var/vector2/pixel_offset = Vector2.DirectionBetween(user, epicentre) * 16

	//If the epicentre is offset on our X axis, we'll have an extra factor on the animation
	if (epicentre.x > user.x)
		x_direction = 1
	else if (epicentre.x < user.x)
		x_direction = -1

	//Tailstrike has two variants. One for vertical and one for horizontal
	if (x_direction)
		//We're doing the horizontal version
		attack_verb = "impales"
		//We will frontflip towards the target, then back
		//Do the front section in two steps for more of a kick
		animate(user, transform=turn(user.transform, 85*(x_direction)),pixel_y = user.pixel_y+(pixel_offset.y*0.7)+8, pixel_x = user.pixel_x+(pixel_offset.x * 0.7), time = windup_time * 0.8, easing =SINE_EASING | EASE_IN)
		animate(transform=turn(user.transform, 40*(x_direction)),pixel_y = user.pixel_y+(pixel_offset.y*0.3)+4, pixel_x = user.pixel_x+(pixel_offset.x * 0.3), time = windup_time * 0.2, easing =BACK_EASING | EASE_OUT)

		//And the pull back to normal
		animate(transform=cached_transform,pixel_y = cached_pixels.y, pixel_x = cached_pixels.x, time = winddown_time, easing = SINE_EASING)

	else
		//The vertical version is spinning around a bit more than halfway, then back
		var/direction = pick(list(1, -1))
		attack_verb = "slashes"
		//We have to do each half in two seperate steps. We divide the pixel offset across those two steps as well
		animate(user, transform=turn(user.transform, 140*direction),pixel_y = user.pixel_y+(pixel_offset.y*0.7), pixel_x = user.pixel_x+(pixel_offset.x*0.7), time = windup_time*0.7, easing = SINE_EASING | EASE_IN)
		animate(transform=turn(user.transform, 60*direction),pixel_y = user.pixel_y+(pixel_offset.y*0.3), pixel_x = user.pixel_x+(pixel_offset.x*0.3), time = windup_time*0.3, easing = BACK_EASING | EASE_OUT)

		//Now the return, two steps again
		animate(transform=turn(user.transform, -60*direction),pixel_y = user.pixel_y-(pixel_offset.y*0.3), pixel_x = user.pixel_x-(pixel_offset.x*0.3), time = winddown_time*0.3, easing = SINE_EASING | EASE_IN)
		animate(transform = cached_transform, pixel_y = cached_pixels.y, pixel_x = cached_pixels.x, time = winddown_time*0.7, easing = SINE_EASING | EASE_OUT)

	//Lets play a whiplash sound, just before impact
	spawn(windup_time - 5)
		playsound(user, pick(list('sound/effects/creatures/necromorph/leaper/leaper_tailswing_1.ogg',
		'sound/effects/creatures/necromorph/leaper/leaper_tailswing_2.ogg',
		'sound/effects/creatures/necromorph/leaper/leaper_tailswing_3.ogg',
		'sound/effects/creatures/necromorph/leaper/leaper_tailswing_4.ogg')), 40, 1, -1)

	//Start a timer to do the finishing hit
	tailstrike_timer = addtimer(CALLBACK(src, .proc/finish), windup_time, TIMER_STOPPABLE)

	release_vector(cached_pixels)
	release_vector(pixel_offset)


/datum/extension/tailstrike/proc/finish()
	//Alright, now lets find the target we will hurt.
	var/atom/victim = find_victim(epicentre)
	strike_victim(victim)
	tailstrike_timer = addtimer(CALLBACK(src, .proc/stop), winddown_time, TIMER_STOPPABLE)

/datum/extension/tailstrike/proc/strike_victim(var/atom/victim)
	victim.shake_animation(damage)
	if (isliving(victim))
		var/mob/living/L = victim
		user.launch_strike(L, damage, user.get_organ(BP_TAIL), damage_flags = DAM_SHARP | DAM_EDGE)

	else
		victim.ex_act(3)

	user.visible_message(SPAN_DANGER("[user] [attack_verb] [victim] with their tail!"))

//This proc figures out which one thing we will hit in the target turf
/datum/extension/tailstrike/proc/find_victim(var/turf/search)
	//Lets start with mobs.
	var/list/possible_standing = list()
	var/list/possible = list()
	for (var/mob/living/L in search)
		//If our originally intended victim is in the target turf, we hit them
		if (L == target)
			return L

		if (L.lying)
			possible += L
		else
			possible_standing += L

	//Lets see if we found any viable mobs
	if (possible_standing.len)
		return pick(possible_standing)

	if (possible.len)
		return pick(possible)

	var/list/possible_dense = list()
	possible = list()

	//No mobs ? Oh well, lets try to hit an atom

	if (search.density)
		possible_dense += search
	else
		possible += search
	for (var/atom/A in search)
		if (ismob(A))
			continue //Lets not hit ghosts

		if (A.density)
			possible_dense += A
		else
			possible += A

	if (possible_dense.len)
		return pick(possible_dense)
	else if (possible.len)
		return pick(possible)

	//We should never get here
	return null

//Stop is called after a successful finish, or on aborting
/datum/extension/tailstrike/proc/stop()
	deltimer(tailstrike_timer)
	stopped_at = world.time
	user.stunned = 0

	//When we finish, we go on cooldown
	if (cooldown && cooldown > 0)
		addtimer(CALLBACK(src, /datum/extension/tailstrike/proc/finish_cooldown), cooldown)
	else
		finish_cooldown() //If there's no cooldown timer call it now


/datum/extension/tailstrike/proc/finish_cooldown()
	remove_extension(holder, /datum/extension/tailstrike)

/datum/extension/tailstrike/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed

//	Triggering
//------------------------
/atom/movable/proc/tailstrike_verb(var/atom/A)
	set name = "Slam"
	set category = "Abilities"

	if (!A)
		A = get_step(src, dir)

	return tailstrike_attack(A)


/atom/movable/proc/can_tailstrike(var/atom/target, var/error_messages = TRUE)
	//Check for an existing charge extension. that means a charge is already in progress or cooling down, don't repeat
	var/datum/extension/tailstrike/ES = get_extension(src, /datum/extension/tailstrike)
	if(istype(ES))
		if (ES.stopped_at)
			if(error_messages) to_chat(src, "[ES.name] is cooling down. You can use it again in [ES.get_cooldown_time() /10] seconds")
			return
		if(error_messages) to_chat(src, "You're already [ES.verb_name]!")
		return FALSE

	if (get_dist(src, target) < 1)
		if(error_messages) to_chat(src, "Target is too close, step back to use your tail!")
		return

	//Can't destroy walls
	if (isturf(target))
		return FALSE

	return TRUE

/mob/living/can_tailstrike(var/atom/target, var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	.=..()

/mob/living/carbon/human/can_tailstrike(var/atom/target, var/error_messages = TRUE)
	var/obj/item/organ/external/E = get_organ(BP_TAIL)
	if(!E || E.is_stump() || (E.status & ORGAN_BROKEN))
		return FALSE
	.=..()

/atom/movable/proc/tailstrike_attack(var/atom/_target, var/_damage = 25, var/_windup_time = 0.75, var/_winddown_time = 0.75, var/_cooldown = 0)
	//First of all, lets check if we're currently able to do the thing
	if (!can_tailstrike(_target, TRUE))
		return FALSE
	//Ok we've passed all safety checks, let's commence strike!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, /datum/extension/tailstrike, _target, _damage,  _windup_time, _winddown_time, _cooldown)
	return TRUE