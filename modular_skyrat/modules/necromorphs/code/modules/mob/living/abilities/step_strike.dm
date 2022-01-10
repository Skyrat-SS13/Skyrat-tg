/datum/extension/step_strike
	name = "Step Strike"
	base_type = /datum/extension/step_strike
	expected_type = /mob/living/carbon/human
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/carbon/human/user
	var/mob/living/target
	var/distance = 1
	var/cooldown = 1 SECOND
	var/duration = 0

	var/started_at
	var/stopped_at

	var/ongoing_timer

	var/turf/target_loc



/datum/extension/step_strike/New(var/mob/living/carbon/human/_user, var/mob/living/_target, var/_distance, var/_cooldown)
	.=..()
	user = _user
	target = _target
	distance = _distance
	cooldown = _cooldown
	start()


/mob/living/carbon/human/proc/step_strike_ability(var/mob/living/target, var/_distance, var/_cooldown)
	//First of all, lets check if we're currently able to step
	if (!can_step_strike())
		return FALSE

	if (!istype(target))
		target = null
		//If no target was passed, lets find one
		//Also applies in the more likely scenario where the passed target is not a living mob
		for (var/mob/living/L in orange(_distance+1, src))	//We search in distance+1 range since we'll be able to strike adjacent tiles after moving
			if (L == src)
				continue	//Don't hit yourself
			if (src.is_allied(L))
				continue	//Don't hit our friends

			if (L.stat == DEAD)
				continue	//Don't waste time on the dead

			target = L

	if (!target)
		return FALSE	//No target? too bad

	//Ok we've passed all safety checks, let's commence charging!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, /datum/extension/step_strike, target, _distance, _cooldown)
	return TRUE


/datum/extension/step_strike/proc/start()
	started_at	=	world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/step_strike/proc/stop), duration, TIMER_STOPPABLE)

	//First of all, lets pick a target location.
	//This must be a tile adjacent to the target mob, which is within distance tiles of the user
	var/list/candidates = list()
	for (var/turf/T in orange(1, target))
		if (get_dist(user, T) <= distance)
			candidates += T

	if (candidates.len)

		if (candidates.len >= 2)
			//If possible, remove the user's current turf so the options only contain places they arent, and they will always take a step before attacking
			candidates.Remove(get_turf(user))

		target_loc = pick(candidates)

		var/sfat = TRUE //search_for_avalaibe_turfs
		while(sfat)
			if(!check_trajectory(target_loc, user, user.pass_flags|PASS_FLAG_TABLE|PASS_FLAG_NOMOB))
				if(!candidates.len)
					return //An obstacle prevents you from step striking. There is no reason to check the closest possible place to teleport since step strike can be used only if target is 2 tiles away or closer
				else
					candidates -= target_loc
					target_loc = pick(candidates)
			else
				sfat = FALSE

		animate_movement(user, target_loc, 6, client_lag = 0.4)
		user.face_atom(target)

		//And make the user hit the target
		//We need to be in harm intent for this, set it if its not already
		if (user.a_intent != I_HURT)
			user.set_attack_intent(I_HURT)

		//We'll set the user's last attack to some time in the past so they can attack again
		user.last_attack = 0
		user.UnarmedAttack(target)


/datum/extension/step_strike/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/step_strike/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/step_strike/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)


/datum/extension/step_strike/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
/mob/living/carbon/human/proc/can_step_strike(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	var/datum/extension/step_strike/E = get_extension(src, /datum/extension/step_strike)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already striking"))
		return FALSE

	return TRUE