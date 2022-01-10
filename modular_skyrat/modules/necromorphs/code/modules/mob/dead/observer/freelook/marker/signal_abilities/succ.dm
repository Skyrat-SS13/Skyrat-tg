/**
Blank extension used to mark an object as being biomass absorbed.
*/
/datum/extension/biomass_being_absorbed
/datum/signal_ability/succ
	name = "Absorb"
	id = "succ"
	desc = "Absorbs all pieces of biological matter within a two tile radius of the target location. Only works on or near corruption, or in sight of the marker"
	target_string = "A severed organ, an organic stain, or a piece of food"
	energy_cost = 10
	autotarget_range = 0
	targeting_method	=	TARGET_CLICK

/**
	Method to animate a target's biomass being absorbed.
*/
/datum/signal_ability/proc/take_biomass(mob/user, atom/target, obj/O, obj/machinery/marker/M)
	set waitfor = FALSE //Animation proc, don't hold up the thread.
	var/biomass_gain = O.get_biomass()
	set_extension(O, /datum/extension/biomass_being_absorbed)
	O.layer = EYE_GLOW_LAYER
	O.plane = EFFECTS_ABOVE_LIGHTING_PLANE
	O.filters += filter(type="outline", size=1, color=COLOR_NECRO_YELLOW)
	sleep(rand_between(0.4 SECONDS, 0.7 SECONDS))
	var/vector2/offset = O.get_global_pixel_offset(target)
	animate(O, pixel_x = O.pixel_x - offset.x, pixel_y = O.pixel_y - offset.y, transform = O.transform.Scale(0.0), time = 4)
	sleep(0.4 SECONDS)
	M.biomass += biomass_gain
	to_chat(user, SPAN_NOTICE("Gained [biomass_gain]kg biomass from absorbing [O]!"))
	remove_extension(O, /datum/extension/biomass_being_absorbed)
	qdel(O)

/datum/signal_ability/succ/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/obj/machinery/marker/M	= get_marker()
	if (!M)
		refund(user)
		return FALSE

	var/near_marker = (get_dist(M, target) <= 10)

	var/total_gain = 0
	var/total_objects = 0
	for (var/turf/T in trange(2, target))
		if (!near_marker && !turf_near_corrupted(T, 3))
			continue
		for (var/obj/O in T)
			var/biomass_gain = O.get_biomass()
			if (get_extension(O, /datum/extension/biomass_being_absorbed) || !isnum(biomass_gain) || biomass_gain <= 0)
				continue
			total_gain += biomass_gain
			total_objects ++
			take_biomass(user, target, O, M)

	if (!total_gain)
		to_chat(user, SPAN_WARNING("No biomass found, energy cost refunded. Biomass may only be claimed when the target is <b>near the marker, or corruption weeds</b>."))
		refund(user)
		return FALSE
	sleep(1.1 SECONDS) //Give it a time to finish suction - Yeah this use of sleep isn't great, but it's short enough that we don't really have to worry about it.
	to_chat(user, SPAN_NOTICE("---------------------------------------------------------------------"))
	to_chat(user, SPAN_NOTICE("Gained [total_gain]kg biomass from absorbing [total_objects] things!"))
	return TRUE



