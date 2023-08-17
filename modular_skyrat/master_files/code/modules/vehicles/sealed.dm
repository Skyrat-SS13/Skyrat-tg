/obj/vehicle/sealed/proc/mob_try_enter(mob/rider)
	if(!istype(rider))
		return FALSE
	if(HAS_TRAIT(M, TRAIT_OVERSIZED))
		to_chat(M, span_warning("You are far too big for this!"))
		return FALSE

	return ..()
