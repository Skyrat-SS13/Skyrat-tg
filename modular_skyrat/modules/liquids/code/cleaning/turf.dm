/turf/wash(clean_types)
	. = ..()
	if(clean_types & CLEAN_TYPE_LIQUIDS)
		var/obj/effect/abstract/liquid_turf/liquid = src.liquids
		if(liquid?.liquid_state == LIQUID_STATE_PUDDLE)
			qdel(liquid, 1) // Just straight up call Destroy() on the liquid
