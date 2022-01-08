//DO NOT INCLUDE THIS FILE
//ITs here as a template for abilites to copypaste

//dodge
//Dodge
//dodging
///mob/living
/datum/extension/dodge
	name = "Dodge"
	base_type = /datum/extension/dodge
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/power = 1
	var/cooldown = 1 SECOND
	var/duration = 1 SECOND

	var/started_at
	var/stopped_at

	statmods = list(STATMOD_EVASION = 60)


/***********************
	Access Proc
************************/
/mob/living/proc/dodge_ability(var/_duration, var/_cooldown, var/_power)
	if (can_dodge())
		set_extension(src, /datum/extension/dodge, _duration,_cooldown,_power)

/datum/extension/dodge/New(var/mob/living/_user, var/_duration, var/_cooldown, var/_power)
	.=..()
	user = _user
	duration = _duration
	cooldown = _cooldown
	power = _power
	start()


/datum/extension/dodge/proc/start()
	started_at = world.time

	if (!QDELETED(user))

		var/list/possible_turfs = trange(1, user)
		possible_turfs -= get_turf(user)
		possible_turfs -= get_step(user, user.dir)
		possible_turfs -= get_step(user, GLOB.reverse_dir[user.dir])

		var/turf/target = clear_turf_in_list(possible_turfs, TRUE)
		if (target)
			animate_movement(user, target, 8, client_lag = 0.4)
			user.visible_message(SPAN_DANGER("[user] nimbly dodges to the side!"))
			//Randomly selected sound
			var/sound_type = pickweight(list(SOUND_SPEECH = 6, SOUND_ATTACK  = 2, SOUND_PAIN = 1.5, SOUND_SHOUT = 1))
			user.play_species_audio(user, sound_type, VOLUME_QUIET, 1, -1)
	addtimer(CALLBACK(src, /datum/extension/dodge/proc/stop), duration)


/datum/extension/dodge/proc/stop()
	stopped_at = world.time
	unregister_statmods()

	addtimer(CALLBACK(src, /datum/extension/dodge/proc/finish_cooldown), cooldown)

/datum/extension/dodge/proc/finish_cooldown()
	remove_extension(holder, base_type)


/datum/extension/dodge/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
/mob/living/proc/can_dodge(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	var/datum/extension/dodge/E = get_extension(src, /datum/extension/dodge)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already dodging"))
		return FALSE

	return TRUE