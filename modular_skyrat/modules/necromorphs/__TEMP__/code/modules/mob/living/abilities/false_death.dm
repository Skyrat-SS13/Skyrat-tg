//DO NOT INCLUDE THIS FILE
//ITs here as a template for abilites to copypaste

//false_death
//False Death
//dying
///mob/living
/datum/extension/false_death
	name = "False Death"
	base_type = /datum/extension/false_death
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/carbon/human/user
	var/power = 1
	var/cooldown = 2 MINUTES
	var/duration = 30 SECONDS

	var/started_at
	var/stopped_at

	var/ongoing_timer

	var/regen_type = /datum/extension/regenerate/hunter_passive



/datum/extension/false_death/New(var/mob/living/user, var/duration, var/cooldown)
	.=..()
	if (isliving(user))
		src.user = user
	if (duration)
		src.duration = duration
	if (cooldown)
		src.cooldown = cooldown


	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/false_death/proc/start), 0, TIMER_STOPPABLE)



/datum/extension/false_death/proc/start()
	started_at	=	world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/false_death/proc/stop), duration, TIMER_STOPPABLE)

	//This must be an integer, and we do -2 since it takes a tick or two to stand up, after awaking
	var/paralyse_duration = Floor(duration / (MOB_PROCESS_INTERVAL))-2
	user.Paralyse(paralyse_duration	)

	//Lets schedule the regen
	var/datum/extension/regenerate/R = regen_type
	var/regen_time = initial(R.duration)

	addtimer(CALLBACK(src, /datum/extension/false_death/proc/do_regen), (duration-regen_time))

/datum/extension/false_death/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/false_death/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/false_death/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)


/datum/extension/false_death/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed


/datum/extension/false_death/proc/do_regen()
	set_extension(user, regen_type)


/***********************
	Safety Checks
************************/
//Access Proc
/mob/living/proc/can_false_death()
	var/datum/extension/false_death/E = get_extension(src, /datum/extension/false_death)
	if(istype(E))
		return FALSE

	return TRUE