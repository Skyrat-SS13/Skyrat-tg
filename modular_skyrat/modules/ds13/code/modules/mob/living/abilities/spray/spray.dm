/atom/proc/spray_ability(var/subtype = /datum/extension/spray,  var/atom/target, var/angle, var/length, var/stun, var/duration, var/cooldown, var/windup, var/mob/override_user = null, var/list/extra_data)
	if (!can_spray())
		return null
	var/list/arguments = list(src, subtype, target, angle, length, stun, duration, cooldown, override_user, extra_data)
	var/datum/extension/spray/S = set_extension(arglist(arguments))
	spawn(windup)
		S.start()
	return S


/*
	Code below
*/
/datum/extension/spray
	name = "Spray"
	base_type = /datum/extension/spray
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE
	var/atom/source
	var/status
	var/mob/living/user
	var/vector2/target
	var/atom/target_atom
	var/angle
	var/length

	var/stun
	var/duration
	var/cooldown

	var/started_at
	var/stopped_at

	var/ongoing_timer

	var/list/affected_turfs = list()
	var/vector2/direction


	//Registry:
	var/datum/click_handler/spray/spray_handler	//Click handler for aiming the spray
	var/obj/effect/particle_system/spray/fx	//Particle system for chem particles
	var/fx_type = /obj/effect/particle_system/spray


	var/particle_color = "#FFFFFF"

/*
Vars/
	User:		Who or what is spraying chems
	Target:		Where are we spraying? This should be a turf, only used for direction
	Angle:		Angle of Cone
	Length:		How long is cone, in tiles
	Stun:		If true, user cant move for duration
	Duration:	How long to spray for
	Cooldown:	Starts after duration
*/
/datum/extension/spray/New(var/atom/source, var/atom/target, var/angle, var/length, var/stun, var/duration, var/cooldown, var/mob/override_user = null, var/list/extra_data)
	.=..()
	src.source = source
	if (override_user)
		user = override_user
	else if (isliving(source))
		user = source

	if (user && user.client)
		spray_handler = user.PushClickHandler(/datum/click_handler/spray)
		spray_handler.host = src

	//If no target is supplied, pick a spot infront of the source
	if (!target)
		var/vector2/sourcedir = Vector2.NewFromDir(source.dir)
		sourcedir.SelfMultiply(length)
		var/turf/sourceturf = get_turf(source)
		target = locate(sourceturf.x + sourcedir.x, sourceturf.y + sourcedir.y, sourceturf.z)

	set_target_loc(target.get_global_pixel_loc())
	src.angle = angle
	src.length = length


	src.stun	=	stun
	src.duration = duration
	src.cooldown = cooldown

	handle_extra_data(extra_data)
	//ongoing_timer = addtimer(CALLBACK(src, /datum/extension/spray/proc/start), 0)

/datum/extension/spray/proc/handle_extra_data(var/list/data)
	.=..()

/datum/extension/spray/proc/set_target_loc(var/vector2/newloc, var/target_object)
	target = newloc
	if (target_object)
		target_atom = target_object
		if (isliving(user))
			user.face_atom(target_object)
	else if (source)
		target_atom = get_turf_at_pixel_coords(target, source.z)
	recalculate_cone()

/datum/extension/spray/proc/get_direction()
	//As long as we're not on the same turf, we can do this easily
	var/vector2/ourloc
	if (isturf(source.loc))
		ourloc = source.get_global_pixel_loc()
	else
		var/atom/A = source.get_toplevel_atom()
		ourloc = A.get_global_pixel_loc()
	if (!(ourloc ~= target))

		.=Vector2.VecDirectionBetween(ourloc, target)
		release_vector(ourloc)
		return

	else
		//User and target are on same turf? Lets try basing it on direction
		var/spraydir = SOUTH
		if (source)
			spraydir = source.dir
		release_vector(ourloc)
		return Vector2.NewFromDir(spraydir)

/datum/extension/spray/proc/recalculate_cone()
	var/list/previous_turfs = affected_turfs.Copy()
	affected_turfs = list()
	if (direction)
		release_vector(direction)
	direction = get_direction()
	affected_turfs = get_view_cone(source, direction, length, angle)
	affected_turfs -= get_turf(source)

	//We will do raytrace testing to see which turfs we actually have line of sight to
	var/list/new_turfs = affected_turfs - previous_turfs
	if (LAZYLEN(new_turfs))
		//Check trajectory returns an assoc list with true/false as value of whether the tile is reachable
		new_turfs = check_trajectory_mass(new_turfs, source, PASS_FLAG_TABLE)
		for (var/turf in new_turfs)
			//If the value is false, LOS was blockd, so we remove it from affected turfs
			if (!new_turfs[turf])
				affected_turfs -= turf

	if (fx)
		fx.set_direction(direction)

/datum/extension/spray/proc/start()
	if (!started_at)
		started_at	=	world.time
		//A duration of 0 lasts indefinitely, until something stops it
		if (duration)
			ongoing_timer = addtimer(CALLBACK(src, /datum/extension/spray/proc/stop), duration, TIMER_STOPPABLE)

		recalculate_cone()

		//Lets create the chemspray fx
		fx = new fx_type(source, direction, duration, length, angle)
		fx.particle_color = particle_color
		fx.start()

		if (stun && isliving(user))
			user.set_move_cooldown(duration)

		START_PROCESSING(SSfastprocess, src)

/datum/extension/spray/proc/stop()
	STOP_PROCESSING(SSfastprocess, src)
	deltimer(ongoing_timer)
	if (spray_handler && user)
		user.RemoveClickHandlersByType(/datum/click_handler/spray)
		spray_handler = null
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/spray/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)
	QDEL_NULL(fx)



/datum/extension/spray/Process()
	if (stopped_at)
		return PROCESS_KILL


/datum/extension/spray/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)


/datum/extension/spray/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
/atom/proc/can_spray(var/error_messages = TRUE)
	var/datum/extension/spray/E = get_extension(src, /datum/extension/spray)
	if(istype(E))
		if (error_messages)
			if (E.stopped_at)
				to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
			else
				to_chat(src, SPAN_NOTICE("You're already Spraying"))
		return FALSE

	return TRUE

/mob/living/can_spray(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE
	.=..()



/atom/proc/stop_spraying()
	var/datum/extension/spray/S = get_extension(src, /datum/extension/spray)
	if (S)
		S.stop()



/***********************
	Spray visual effect
************************/
/*
	Particle System
	Sprays particles in a cone
*/
/obj/effect/particle_system/spray
	particle_type = /obj/effect/particle/spray
	autostart = FALSE
	particles_per_tick = 6
	randpixel = 12




/obj/effect/particle/spray
	name = "spray"
	icon = 'icons/effects/effects.dmi'
	icon_state = "spray"
	scale_x_end = 2
	scale_y_end = 4
	color = "#FF0000"




/*-----------------------
	Click Handler
-----------------------*/
/datum/click_handler/spray
	var/datum/extension/spray/host
	has_mousemove = TRUE

	var/reagent_type = /datum/reagent/acid/necromorph

/datum/click_handler/spray/MouseMove(object,location,control,params)
	if (host && user && user.client)
		var/vector2/mouseloc = get_global_pixel_click_location(params, user.client)
		host.set_target_loc(mouseloc, object)



