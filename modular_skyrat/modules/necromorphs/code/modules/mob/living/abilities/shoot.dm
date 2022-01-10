#define SHOOT_STATUS_READY	0
#define	SHOOT_STATUS_PREFIRE	1
#define	SHOOT_STATUS_FIRING	2
#define	SHOOT_STATUS_COOLING	3
/*
	Generic Shoot Extension. Make subtypes for things which shouldn't share a cooldown
*/
/datum/extension/shoot
	name = "Shoot"
	base_type = /datum/extension/shoot
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE


	var/status = SHOOT_STATUS_READY
	var/atom/user
	var/atom/target
	var/projectile_type
	var/base_accuracy
	var/list/dispersion
	var/total_shots
	var/windup_time
	var/fire_sound
	var/power = 1
	var/cooldown = 1 SECOND
	var/nomove	=	0

	var/started_at
	var/stopped_at

	var/ongoing_timer

	//Data generated during runtime
	var/shot_num = 1

	//When false, this extension is deleted when cooldown finishes
	//If true, the extension will remain, and can be used to fire repeqatedly without remaking it
	var/persist = FALSE


	var/vector2/starting_pixel_offset = null

/*
	Vars expected:
	user: What/who is firing the projectiles
	target: What are projectiles being fired at
	projectile_type: What type of projectile we will spawn.
	accuracy: Base accuracy of the shot, default 100, optional
	dispersion: maximum deviation, one point = 9 degrees default 0, optional. Can also be a list of values
	num: How many projectiles to fire, default 1, optional
	windup: windup time before firing, default 0, optional. Note, no windup sound feature, play that in the caller
	fire sound: fire sound used when projectile is launched, optional. If not supplied, one will be taken from the projectile
	nomove: optional, default false. If true, the user can't move during windup. If a number, the user can't move during windup and for that long after firing
*/

/datum/extension/shoot/New(var/atom/user, var/atom/target, var/projectile_type, var/accuracy = 0, var/dispersion = 0, var/num = 1, var/windup_time = 0, var/fire_sound = null, var/nomove = FALSE, var/cooldown = 0,var/vector2/_starting_pixel_offset)
	.=..()
	src.user = user
	src.target = target
	src.projectile_type = projectile_type
	src.base_accuracy = accuracy
	src.dispersion = dispersion
	src.total_shots = num
	src.windup_time = windup_time
	src.fire_sound = fire_sound
	src.nomove = nomove
	src.cooldown = cooldown

	if (_starting_pixel_offset)
		starting_pixel_offset = _starting_pixel_offset

	if (!persist)
		status = SHOOT_STATUS_PREFIRE
		spawn()
			start()






//The repeat subtype is designed to not be deleted after firing and cooling down. instead the extension remains
//Call fire repeatedly to make it fire again
/datum/extension/shoot/repeat
	persist = TRUE

/datum/extension/shoot/repeat/proc/fire(var/atom/newtarget)
	if (!can_fire())
		return FALSE

	status = SHOOT_STATUS_PREFIRE
	target = newtarget
	spawn()
		start()

	return TRUE




/datum/extension/shoot/proc/start()
	status = SHOOT_STATUS_PREFIRE
	started_at	=	world.time

	var/mob/living/L
	var/target_zone = BP_CHEST
	if (isliving(user))
		L = user
		target_zone = L.hud_used.zone_sel.selecting
	else
		target_zone = ran_zone()

	//First of all, if nomove is set, lets paralyse the user
	if (nomove && L)
		var/stoptime = windup_time
		if (isnum(nomove))
			stoptime += nomove

		if (stoptime)
			L.set_move_cooldown(stoptime)

	//Now lets windup the shot(s)
	if (windup_time)

		windup_animation()

	fire_animation()

	//And start the main event
	var/turf/targloc = get_turf(target)
	status = SHOOT_STATUS_FIRING
	for(shot_num in 1 to total_shots)
		var/obj/item/projectile/P = new projectile_type(user.loc)
		if (starting_pixel_offset)
			P.pixel_x += starting_pixel_offset.x
			P.pixel_y += starting_pixel_offset.y
		P.accuracy += base_accuracy
		P.dispersion = get_dispersion()
		P.firer = user
		P.shot_from = user

		if (QDELETED(target))
			P.launch(targloc, target_zone)
		else
			P.launch(target, target_zone)

		if (fire_sound)
			if (islist(fire_sound))
				playsound(user, pick(fire_sound), VOLUME_MID, 1)
			else
				playsound(user, fire_sound, VOLUME_MID, 1)

	stop()

//If its a single number, just return that
/datum/extension/shoot/proc/get_dispersion()
	if (isnum(dispersion))
		return dispersion

	if (islist(dispersion))
		return dispersion[shot_num]


/datum/extension/shoot/proc/windup_animation()
	sleep(windup_time)

/datum/extension/shoot/proc/fire_animation()
	return

/datum/extension/shoot/proc/stop()
	status = SHOOT_STATUS_COOLING
	deltimer(ongoing_timer)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/shoot/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/shoot/proc/finish_cooldown()
	status = SHOOT_STATUS_READY
	deltimer(ongoing_timer)
	if (!persist)
		remove_extension(holder, base_type)


/datum/extension/shoot/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
/atom/proc/can_shoot(var/error_messages = TRUE, var/subtype = /datum/extension/shoot)
	if (isliving(src))
		var/mob/living/L = src
		if (L.incapacitated())
			return FALSE

	var/datum/extension/shoot/E = get_extension(src, subtype)

	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already shooting"))
		return FALSE

	return TRUE


//Only used for repeat shooting
/datum/extension/shoot/proc/can_fire()
	if (status != SHOOT_STATUS_READY)
		return FALSE

	return TRUE

/***********************
	Using
************************/
/atom/movable/proc/shoot_ability(var/subtype = /datum/extension/shoot, var/atom/target, var/projectile_type, var/accuracy = 100, var/dispersion = 0, var/num = 1, var/windup_time = 0, var/fire_sound = null, var/nomove = FALSE, var/cooldown = 0, var/vector2/starting_pixel_offset)
	//First of all, lets check if we're currently able to shoot
	if (!can_shoot(TRUE, subtype))
		return FALSE

	//Can't shoot yourself
	if (target == src)
		return FALSE

	//Ok we've passed all safety checks, let's commence charging!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, subtype, target, projectile_type, accuracy, dispersion, num, windup_time, fire_sound, nomove, cooldown, starting_pixel_offset)

	return TRUE