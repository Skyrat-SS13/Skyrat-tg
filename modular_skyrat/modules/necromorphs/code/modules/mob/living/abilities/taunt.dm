/*
	Taunt is an ability used by the hunter

	It has two parts:
		1. This extension, applied to the user. Buffs the user's movespeed and damage resist. Gives the user a red outline to mark them
			Applies the companion extension to everyone on the user's team who can see them, each tick

		2. The companion, applied to people who see the user. Buffs the subject's damage resist and evasion]

	Taunt lasts a long time potentially. But it ends early under two conditions:
		1. The user is knocked down

		2. Six seconds pass without seeing a valid enemy
*/
/datum/extension/taunt
	name = "Taunt"
	base_type = /datum/extension/taunt
	expected_type = /mob
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/cooldown = 20 SECONDS
	var/duration = 5 MINUTES
	var/tick_interval = 1 SECOND

	var/started_at
	var/stopped_at

	var/ongoing_timer
	var/tick_timer

	var/time_without_enemy = 0
	var/max_time_without_enemy = 6 SECONDS



	//These stats apply to self
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = 0.15,
	STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = 0.85)

	var/dm_filter/outline



/datum/extension/taunt/New(var/mob/user, var/duration, var/cooldown)
	.=..()
	if (isliving(user))
		src.user = user
	if (duration)
		src.duration = duration
	if (cooldown)
		src.cooldown = cooldown


	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/taunt/proc/start), 0, TIMER_STOPPABLE)



/datum/extension/taunt/proc/start()
	started_at	=	world.time
	if (!outline)
		var/newfilter = filter(type="outline", size = 1, color = rgb(255,0,0,128))
		user.filters.Add(newfilter)
		outline = user.filters[user.filters.len]
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/taunt/proc/stop), duration, TIMER_STOPPABLE)
	if (tick_interval)
		tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)

/datum/extension/taunt/proc/stop()
	deltimer(ongoing_timer)
	deltimer(tick_timer)
	stopped_at = world.time
	if (outline)
		user.filters.Remove(outline)
		outline = null
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/taunt/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/taunt/proc/finish_cooldown()
	to_chat(user, SPAN_NOTICE("You are ready to [name] again"))
	deltimer(ongoing_timer)
	remove_self()


/datum/extension/taunt/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed


/datum/extension/taunt/proc/tick()

	tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)
	//Check if we're ending early
	if (user.lying)
		to_chat(user, SPAN_DANGER("You are a crumpled heap on the floor, taunt is ended"))
		stop()

	else if (!user.enemy_in_view(require_standing = TRUE))

		time_without_enemy += tick_interval
		if (time_without_enemy >= max_time_without_enemy)
			to_chat(user, SPAN_DANGER("There are no more enemies in sight, taunt is ended"))
			stop()

	else
		time_without_enemy = 0
		//Lets apply the effect to other necros
		for (var/mob/living/carbon/human/H in view(user, 10))
			if (!H.is_necromorph())
				continue

			//They already have it?
			if (get_extension(H, /datum/extension/taunt_companion))
				continue

			//Two hunters can't cover each other with taunt
			if (get_extension(H, /datum/extension/taunt))
				continue

			//Go!
			set_extension(H, /datum/extension/taunt_companion, user)

/***********************
	Safety Checks
************************/
//Access Proc
/mob/proc/can_taunt(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	if (lying)
		to_chat(src, SPAN_DANGER("You must be standing to use taunt!"))
		return FALSE

	var/datum/extension/taunt/E = get_extension(src, /datum/extension/taunt)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already taunting"))
		return FALSE


	//Taunt requires a visible enemy
	if (!enemy_in_view(require_standing = TRUE))
		to_chat(src, SPAN_DANGER("You need a standing enemy in view to use taunt!"))
		return FALSE

	return TRUE




/*
	Companion effect
	Applied to others who see the taunt user (referrred to as shield)
	Ticks regularly and removes itself if the shield is no longer in view
*/
/datum/extension/taunt_companion
	flags = EXTENSION_FLAG_IMMEDIATE
	statmods = list(STATMOD_EVASION = 10,
	STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = 0.7)
	var/mob/living/user
	var/tick_timer
	var/mob/shield

	var/tick_interval = 1 SECOND

/datum/extension/taunt_companion/New(var/datum/holder, var/mob/shield)
	.=..()
	user = holder
	src.shield = shield
	tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)

/datum/extension/taunt_companion/proc/tick()
	//Check we can still see the shield
	if (QDELETED(shield) || !(shield in (view(user, user.view_range))))
		end()
		return

	//Check that he's still taunting
	var/datum/extension/taunt/T = get_extension(shield, /datum/extension/taunt)
	if (T.stopped_at)
		end()
		return


	tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)

/datum/extension/taunt_companion/proc/end()
	deltimer(tick_timer)
	remove_self()