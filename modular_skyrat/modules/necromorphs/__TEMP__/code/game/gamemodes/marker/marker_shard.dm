/*
	A small chunk taken from the marker. When left alone (and active) for a while, it will begin spreading corruption

	It activates at the same time as the marker
*/

/obj/item/marker_shard
	name = "strange rock"
	desc = "It's covered in odd writing."
	icon = 'icons/obj/marker_shard.dmi'
	icon_state = "marker_shard_dormant"
	randpixel = 0

	var/mass_active = 30 //It gets heavier when active

	resistance = 40
	max_health = 1000

	var/active = FALSE

	//How long does the shard have to remain in one spot before it starts spreading corruption?
	var/deploy_time = 2 MINUTES
	var/deploy_timer
	var/deployed = FALSE	//Are we currently spreading corruption?

	//Thing we're usign to manage our corruption
	var/datum/extension/corruption_source/CS

	//Last place we were
	var/last_known_location
	var/last_moved = 0 //Last time we were moved

	var/corruption_range = 9
	var/corruption_speed = 0.8
	var/corruption_falloff = 0.8
	var/corruption_limit = 100

	//When dug into corruption, it fades a little
	var/alpha_sunk = 200

	visualnet_range = 3

	var/tool_cut_multiplier = 0.015

/obj/item/marker_shard/Initialize()
	.=..()
	last_known_location = loc
	var/obj/machinery/marker/M = get_marker()
	if (M && M.active)
		activate()

	SSnecromorph.register_shard(src)
	GLOB.necrovision.add_source(src)


/obj/item/marker_shard/Destroy()
	SSnecromorph.unregister_shard(src)
	.=..()

/obj/item/marker_shard/examine(var/mob/user)
	.=..()
	if (anchored)
		to_chat(user, "It's stuck fast in those growths, you'd need a bladed implement to cut it out.")


/obj/item/marker_shard/attackby(var/obj/item/C, var/mob/user)
	if (anchored)
		var/quality = C.get_tool_type(user, list(QUALITY_CUTTING, QUALITY_SAWING), src)

		if (quality)
			//The worktime taken depends on the health of the local corruption vine, assuming there is one
			var/strength = C.get_tool_quality(quality) * tool_cut_multiplier
			var/obj/effect/vine/corruption/CO = locate() in loc
			if(!CO || (strength && C.use_tool(user = user, target = src, base_time = (((CO.health*1.2) / strength) SECONDS), required_quality = quality, fail_chance = 0, progress_proc = CALLBACK(src, /obj/item/marker_shard/proc/erode_corruption, strength))))
				//If we get here, it has been cut free
				undeploy()
				if (user)
					user.visible_message("[user] cuts the [src] free from the grasp of the corrupted tendrils")
					user.put_in_hands(src)
				return TRUE

	.=..()



/obj/item/marker_shard/proc/erode_corruption(var/strength)
	for (var/obj/effect/vine/corruption/C in loc)
		C.adjust_health(-strength)

/obj/item/marker_shard/update_icon()
	if (active)
		icon_state = "marker_shard_active"
		set_light(1, 1, 8, 2, COLOR_MARKER_RED)
	else
		icon_state = "marker_shard_dormant"
		set_light(0)


//The shard reveals an area around it, seeing through walls
/obj/item/marker_shard/get_visualnet_tiles(var/datum/visualnet/network)
	return trange(visualnet_range, get_turf(src))

/*
	Activation and timer
*/
/obj/item/marker_shard/proc/activate()
	active = TRUE
	last_known_location = loc
	GLOB.moved_event.register(src, src, .proc/moved)
	attempt_deploy()
	mass = mass_active
	update_icon()

/obj/item/marker_shard/proc/deactivate()
	active = FALSE
	mass = initial(mass)
	GLOB.moved_event.unregister(src, src, .proc/moved)
	update_icon()

/obj/item/marker_shard/proc/set_deploy_timer()
	deltimer(deploy_timer)
	if (active)
		deploy_timer = addtimer(CALLBACK(src, /obj/item/marker_shard/proc/attempt_deploy),  deploy_time, TIMER_STOPPABLE)

//Whenever we move, reset the timer
/obj/item/marker_shard/moved(mob/user as mob, old_loc as turf)
	last_moved = world.time
	undeploy()
	last_known_location = loc
	set_deploy_timer()
	try_sink()
	if (!isturf(loc))
		apply_debuff()
	.=..()

/*
	Any crewman who picks up the shard recieves significant penalties
*/
/obj/item/marker_shard/proc/apply_debuff()
	var/mob/M = get_toplevel_atom()
	if (istype(M) && !M.is_necromorph() && !M.is_unitologist() && !get_extension(M, /datum/extension/shard_resistance))
		set_extension(M, /datum/extension/shard_resistance)
/*
	Deployment
*/
/obj/item/marker_shard/proc/undeploy()
	anchored = FALSE
	alpha = 255
	//Remove our source, this will cause any vines we spread to lose their source
	//They will attempt to connect to another source in range, and if that fails, will start dying off
	remove_extension(src, /datum/extension/corruption_source)


//This should never fail, do safety checks first
/obj/item/marker_shard/proc/deploy()

	deployed = TRUE
	sink()
	CS = set_extension(src, /datum/extension/corruption_source, corruption_range, corruption_speed, corruption_falloff, corruption_limit)
	link_necromorphs_to("A marker shard has started growing corruption at LINK", src)


/*
	Called whenever the shard is moved, it attempts to lodge itself in corruption
*/
/obj/item/marker_shard/proc/try_sink()
	//Doesnt happen if held or in containers
	if (isturf(loc))


		var/turf/T = loc
		//Can only sink into corruption which is 25% health or more
		if (!turf_corrupted(T, FALSE, 0.25))
			return

		//Don't sink while being thrown or moved with kinesis
		if (pass_flags & PASS_FLAG_FLYING)
			return

		sink()

	//To prevent exploiting, if the shard is inside something being pulled around (locker, backpack, etc) by a non unitologist, it tumbles out
	else
		var/atom/A = get_toplevel_atom()
		if (A != src && isobj(A) && prob(20))
			tumble()
			var/turf/T = get_turf(src)
			T.visible_message(SPAN_NOTICE("\The [src] tumbles out of \the [A]"))

/obj/item/marker_shard/proc/sink()
	if (istype(loc, /turf))
		anchored = TRUE
		alpha = alpha_sunk
		loc.visible_message("The corruption closes tight around [src]")


//Here we check if we've stayed still since our location was last updated
/obj/item/marker_shard/proc/attempt_deploy()
	deltimer(deploy_timer)
	if (!active)
		return

	if (loc == last_known_location && (world.time - last_moved) >= deploy_time)
		//Yes!
		deploy()
	else
		last_known_location = loc
		set_deploy_timer()	//Nop, update the location and wait another 3 mins



/*
	Verb
*/
/mob/proc/jump_to_shard()
	set name = "Jump to Shard"
	set desc = "Cycles between marker shards active in the world"
	set category = "Necromorph"

	if (!LAZYLEN(SSnecromorph.shards))
		to_chat(src, SPAN_WARNING("There are no marker shards in the world."))
		return

	//This lets us use the verb repeatedly to cycle through shards

	SSnecromorph.last_shard_jumped_to = Wrap(SSnecromorph.last_shard_jumped_to+1, 1, SSnecromorph.shards.len+1)	//We must do +1 on the length because wrap is exclusive at the max point
	to_chat(src, SPAN_NOTICE("Jumping to shard [SSnecromorph.last_shard_jumped_to] of [SSnecromorph.shards.len]"))
	var/obj/item/marker_shard/MS = SSnecromorph.shards[SSnecromorph.last_shard_jumped_to]
	if (MS)
		jumpTo(get_turf(MS))



/*
	Interactions
*/

//If you attempt to put a marker shard into a disposal, it hurts you and escapes your grasp!
/obj/item/marker_shard/attempt_dispose(var/obj/machinery/disposal/D, var/mob/living/user)
	if (istype(user))
		to_chat(user, span("necromarker", "You are punished for your hubris!"))

		user.stun_effect_act(6, 60, BP_CHEST, src)
		user.Paralyse(10)
		user.take_overall_damage(0, 30, src)

	var/list/turfs = clear_turfs_in_view(world.view)
	if (turfs.len)
		if (loc == user)
			user.drop_from_inventory(src, pick(turfs))
		else
			forceMove(pick(turfs))

	//Returning false prevents it from entering disposals
	return FALSE



/*
	Helpers
*/

/*
	This finds the number of viable shards which can probably help the necromorphs
	A shard in space, or in the posession of a non-unitologist, is considered not viable
*/
/proc/get_viable_shards()
	var/list/shards = list()


	for (var/obj/item/marker_shard/MS in SSnecromorph.shards)
		var/atom/holder = MS.get_toplevel_atom()
		var/turf/T = get_turf(MS)

		//Its not aboard ishimura? not viable
		if (!is_station_turf(T))
			continue

		if (ismob(holder))
			var/mob/M = holder
			//Non unitologist holding the shard
			if (!M.is_unitologist())
				continue

		else
			if (isturf(holder))
				//In this case, holder == T
				if (T.is_hole)
					continue

			//If nothing is stopping it, it should have spread corruption by now.
			else if (marker_active() && !turf_corrupted(T))
				//If no corruption, we'll assume someone is screwing around. Maybe dragging around a backpack with the shard inside
				//Either way its not viable
				continue

		shards |= MS

	return shards



/*
	Debuff Extension
	Carrying a marker shard is harmful to your health
*/
/datum/extension/shard_resistance
	statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE  = 0.35, STATMOD_VIEW_RANGE = -2, STATMOD_EVASION = -30)
	var/tick_interval = 5
	var/mob/living/victim
	var/tick_count = 0

/datum/extension/shard_resistance/New(var/mob/holder)
	.=..()
	victim = holder
	START_PROCESSING(SSprocessing, src)
	to_chat(victim, SPAN_DANGER("As you pickup the shard, you feel a burning sense of dread wash over you"))


/datum/extension/shard_resistance/Process()
	tick_count++
	if (tick_count % tick_interval)
		return


	if (!victim || victim.stat == DEAD)
		remove_self()
		return

	//We'll pause when they're unconscious
	if (victim.stat)
		return

	var/list/things = victim.get_inventory()
	var/shards = 0
	for (var/obj/item/marker_shard/MS in things)
		shards++
		victim.take_overall_damage(0, 7.5)

	if (!shards)
		remove_self()
		return

/datum/extension/shard_resistance/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	to_chat(victim, "A great weight is lifted off you.")
	victim = null
	.=..()