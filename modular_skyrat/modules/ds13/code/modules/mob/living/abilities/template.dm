//DO NOT INCLUDE THIS FILE
//ITs here as a template for abilites to copypaste

//<name>
//<visible_name>
//<visible_verb>
//<expected_type>
/datum/extension/<name>
	name = "<visible_name>"
	base_type = /datum/extension/<name>
	expected_type = <expected_type>
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/power = 1
	var/cooldown = 1 SECONDS
	var/duration = 1 SECONDS

	var/started_at
	var/stopped_at

	var/ongoing_timer



/datum/extension/<name>/New(var<expected_type>/user, var/duration, var/cooldown)
	.=..()
	if (isliving(user))
		src.user = user
	src.duration = duration
	src.cooldown = cooldown


	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/<name>/proc/start), 0, TIMER_STOPPABLE)



/datum/extension/<name>/proc/start()
	started_at	=	world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/<name>/proc/stop), duration, TIMER_STOPPABLE)


/datum/extension/<name>/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/<name>/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/<name>/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)


/datum/extension/<name>/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
<expected_type>/proc/can_<name>(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	var/datum/extension/<name>/E = get_extension(src, /datum/extension/<name>)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already <visible_verb>"))
		return FALSE

	return TRUE
