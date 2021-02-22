/datum/signal_ability/succ
	name = "Absorb"
	id = "succ"
	desc = "Absorbs all pieces of biological matter within a two tile radius of the target location. Only works on or near corruption, or in sight of the marker"
	target_string = "A severed organ, an organic stain, or a piece of food"
	energy_cost = 10
	autotarget_range = 0


	targeting_method	=	TARGET_CLICK



/datum/signal_ability/succ/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/obj/machinery/marker/M	= get_marker()
	if (!M)
		refund(user)
		return

	var/near_marker = FALSE
	if ((M in dview(10, target)))
		near_marker = TRUE

	var/total_gain  = 0
	var/total_objects = 0
	var/list/absorbing = list()
	for (var/turf/T in trange(2, target))
		if (!near_marker && !turf_near_corrupted(T, 3))
			continue
		for (var/obj/O in T)
			var/biomass_gain = O.get_biomass()
			if (isnum(biomass_gain) && biomass_gain > 0)
				absorbing[O] = biomass_gain


	for (var/obj/O as anything in absorbing)
		total_gain += absorbing[O]
		total_objects++
		spawn()
			O.layer = EYE_GLOW_LAYER
			O.plane = EFFECTS_ABOVE_LIGHTING_PLANE
			O.filters += filter(type="outline", size=1, color=COLOR_NECRO_YELLOW)
			sleep(rand_between(4,7))
			var/vector2/offset = O.get_global_pixel_offset(target)
			animate(O, pixel_x = O.pixel_x - offset.x, pixel_y = O.pixel_y - offset.y, transform = O.transform.Scale(0.0), time = 4)
			sleep(4)
			M.biomass += absorbing[O]
			to_chat(user, SPAN_NOTICE("	Gained [absorbing[O]]kg biomass from absorbing [O]!"))
			qdel(O)
		sleep(rand_between(0.5,3))



	if (!total_gain)
		to_chat(user, SPAN_WARNING("No biomass found, energy cost refunded"))
		refund(user)

	else
		sleep(11) //Give it a time to finish suction
		to_chat(user, SPAN_NOTICE("---------------------------------------------------------------------"))
		to_chat(user, SPAN_NOTICE("Gained [total_gain]kg biomass from absorbing [total_objects] things!"))



