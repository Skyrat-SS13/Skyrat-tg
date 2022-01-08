//DO NOT INCLUDE THIS FILE
//ITs here as a template for abilites to copypaste

//<name>
//<visible>
//<verb>
///mob
/datum/extension/<name>
	name = "<visible>"
	base_type = /datum/extension/<name>
	expected_type = /mob
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/power = 1
	var/cooldown = 1 SECOND
	var/duration = 1 SECOND
	var/tick_interval = 0	//Set this to a positive number to enable ticking

	var/started_at
	var/stopped_at

	var/ongoing_timer
	var/tick_timer



/datum/extension/<name>/New(var/mob/user, var/duration, var/cooldown)
	.=..()
	if (isliving(user))
		src.user = user
	if (duration)
		src.duration = duration
	if (cooldown)
		src.cooldown = cooldown


	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/<name>/proc/start), 0, TIMER_STOPPABLE)



/datum/extension/<name>/proc/start()
	started_at	=	world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/<name>/proc/stop), duration, TIMER_STOPPABLE)

	if (tick_interval)
		tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)

/datum/extension/<name>/proc/stop()
	deltimer(ongoing_timer)
	deltimer(tick_timer)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/<name>/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/<name>/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_self()


/datum/extension/<name>/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed


/datum/extension/<name>/proc/tick()
	tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)



/***********************
	Safety Checks
************************/
//Access Proc
/mob/proc/can_taunt(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	var/datum/extension/<name>/E = get_extension(src, /datum/extension/<name>)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already <verb>"))
		return FALSE

	return TRUE