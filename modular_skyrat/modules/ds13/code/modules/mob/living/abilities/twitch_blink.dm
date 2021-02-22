/*
	This is a permanant extension used by the necromorph twitcher. It is added to a twitcher on spawning and stays there forever. It handles a few things:

		-Periodic idle twitching animations
		-Shortrange blinks from charging and reactive
		-Actively used shortrange blink

	Its purposes are highly specialised for the twitcher and it shouldn't be used on anyone else
*/

/datum/extension/twitch
	name = "Twitch"
	expected_type = /mob/living/carbon/human
	flags = EXTENSION_FLAG_IMMEDIATE
	var/mob/living/carbon/human/user

	//Twitcher will periodically do idle jerking animations
	var/idle_delay_min = 3 SECONDS
	var/idle_delay_max = 15 SECONDS

	//Idle twitching animations
	var/list/animations = list("twitcher_anim_1", "twitcher_anim_2")

	//Twitchers will blink to an adjacent tile when damaged, this effect has a cooldown
	var/defensive_displace_cooldown = 3 SECONDS

	//Small chance to randomly displace each step taken. This does not trigger the defensive cooldown
	var/movement_displace_chance = 4




	//Runtime data
	var/last_defensive_displace = 0
	var/idle_twitch_timer

/datum/extension/twitch/New(var/mob/living/carbon/human/_user)
	..()
	user = _user
	GLOB.moved_event.register(user, src, /datum/extension/twitch/proc/moved)
	set_next_idle_twitch()


//This is called after every twitch, idle or active
/datum/extension/twitch/proc/set_next_idle_twitch()
	if (idle_twitch_timer)	//Cancel any queued idle
		deltimer(idle_twitch_timer)

	. = rand_between(idle_delay_min, idle_delay_max)
	idle_twitch_timer = addtimer(CALLBACK(src, .proc/twitch_animation), ., TIMER_STOPPABLE)


//Does an animation. Only if the user is standing up
	//Can be done while stunned, as part of special abilities
/datum/extension/twitch/proc/twitch_animation()
	if (!user.lying)
		flick(pick(animations), user)

	//Make random sounds sometimes when we twitch.
	//I originally tested this without a prob call, and it got annoying real fast
	if (prob(20))
		var/sound_type = pickweight(list(SOUND_SPEECH = 6, SOUND_ATTACK  = 2, SOUND_PAIN = 1.5, SOUND_SHOUT = 1))
		user.play_species_audio(user, sound_type, VOLUME_QUIET, 1, -1)

	set_next_idle_twitch()


/datum/extension/twitch/proc/moved(var/atom/mover, var/oldloc, var/newloc)
	//Sometimes blink around while walking
	if(prob(movement_displace_chance))
		displace(FALSE)

/datum/extension/twitch/proc/move_to(var/atom/target, var/speed = 10)
	if (!turf_clear(get_turf(target)))
		return FALSE

	animate_movement(user, target, speed, client_lag = 0.4)
	twitch_animation()
	return TRUE


/datum/extension/twitch/proc/displace(var/defensive = FALSE)
	if (defensive)
		if (last_defensive_displace + (defensive_displace_cooldown / user.get_attack_speed_factor()) >= world.time)
			return FALSE //Too soon since last one


	var/list/possible = list()
	for (var/turf/simulated/floor/F in orange(user, 1))
		if (turf_clear(F))
			possible.Add(F)

	if (possible.len)
		if (defensive)
			last_defensive_displace = world.time
		move_to(pick(possible), speed = 8)
		return TRUE

	return FALSE