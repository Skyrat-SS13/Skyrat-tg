/datum/signal_ability/lock
	name = "Lock"
	id = "lock"
	desc = "Triggers localised biohazard sensors in a door, causing it to bolt shut for two minutes.  This is quite visible and audible, sure to cause a panic. <br>\
	The door will unbolt again after that period, though it can also be opened manually through wire hacking or excessive damage.<br>\
	<br>\
	After it wears off, the same door cannot be affected again for four minutes"
	target_string = "Any airlock with a bolting or locking mechanism"
	energy_cost = 70
	cooldown = 60 SECONDS
	autotarget_range = 1
	target_types = list(/obj/machinery/door/airlock)

	targeting_method	=	TARGET_CLICK


/datum/signal_ability/lock/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/obj/machinery/door/airlock/A = target
	if (!A.can_lockdown(user, 1))
		refund(user)
		return

	var/datum/extension/lockdown/lock = set_extension(target, /datum/extension/lockdown, 2 MINUTES, 1)
	if (!lock.start())
		remove_extension(target, /datum/extension/lockdown)
		refund(user)


/datum/signal_ability/lockdown
	name = "Biohazard Lockdown"
	id = "lockdown"
	desc = "Triggers a biohazard alert in the targeted area, causing an automated isolation lockdown. <br>\
	All the doors in and out of the target room will be bolted shut, trapping anyone in there.<br>\
	<br>\
	Best used to combine with a necromorph assault, preventing the escape of human victims, and forcing them to fight to the death.<br>\
	This effect lasts for three minutes, but only if there is a live necromorph in the room. If there are none, the lockdown duration is halved."
	target_string = "A tile in the target area or room"
	energy_cost = 1000
	cooldown = 300 SECONDS
	target_types = list(/turf)
	marker_only = TRUE

	targeting_method	=	TARGET_CLICK

/datum/signal_ability/lockdown/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/duration = 1.5 MINUTES
	var/area/A = get_area(target)
	if (istype(A) && A.bordering_doors.len)

		//Lets check if we have necromorphs here
		var/necromorph_found = FALSE
		for (var/mob/living/L in A)
			if (L.is_necromorph() && L.stat != DEAD)
				necromorph_found = TRUE
				break

		if (necromorph_found)
			duration = 3 MINUTES
			to_chat(user, SPAN_NOTICE("A live necromorph is present in the target area, lockdown will be 3 minutes"))
		else
			to_chat(user, SPAN_DANGER("No necromorphs found in the target area, lockdown duration reduced to 1.5 minutes"))

		for (var/obj/machinery/door/airlock/AL in A.bordering_doors)
			if (AL.can_lockdown(null, 2))
				var/datum/extension/lockdown/lock = set_extension(AL, /datum/extension/lockdown, duration, 2)
				if (!lock.start())
					remove_extension(target, /datum/extension/lockdown)
			//Its more dramatic if they're not all simultaneous
			sleep(4)

		return TRUE
	else
		refund(user)


//DO NOT INCLUDE THIS FILE
//ITs here as a template for abilites to copypaste

//lockdown
//Lockdown
//Locked
///obj/machinery/door/airlock
/datum/extension/lockdown
	name = "Lockdown"
	base_type = /datum/extension/lockdown
	expected_type = /obj/machinery/door/airlock
	flags = EXTENSION_FLAG_IMMEDIATE

	var/obj/machinery/door/airlock/airlock
	var/duration = 2 MINUTES
	var/cooldown = 4 MINUTES
	var/ongoing_timer
	var/started_at
	var/stopped_at
	var/priority


/datum/extension/lockdown/New(var/obj/machinery/door/airlock/A, var/duration = 2 MINUTES, var/priority = 1)
	.=..()
	src.duration = duration
	src.priority = priority
	airlock = A
	//We don't autostart, it will be done manually


/datum/extension/lockdown/proc/start()
	.=FALSE

	if (istype(airlock))
		var/was_safe = airlock.safe
		airlock.safe = FALSE
		airlock.close(TRUE)
		.=airlock.lock(TRUE)
		airlock.safe = was_safe
		if (.)
			ongoing_timer = addtimer(CALLBACK(src, /datum/extension/lockdown/proc/stop), duration, TIMER_STOPPABLE)
	started_at	=	world.time



/datum/extension/lockdown/proc/stop()
	deltimer(ongoing_timer)
	.=airlock.unlock(TRUE)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/lockdown/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/lockdown/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)


/datum/extension/lockdown/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
/obj/machinery/door/airlock/proc/can_lockdown(var/user, var/priority)
	var/datum/extension/lockdown/E = get_extension(src, /datum/extension/lockdown)
	if(istype(E) && E.priority >= priority)

		if (user)
			if (E.stopped_at)
				to_chat(user, SPAN_NOTICE("This door was recently locked down, it can't be affected again for another [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(user, SPAN_NOTICE("This door is already locked"))
		return FALSE

	return TRUE