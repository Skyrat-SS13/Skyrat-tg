/obj/effect/immovablerod/Bump(atom/clong)
	var/should_self_destroy = FALSE
	if(istype(clong, /obj/machinery/rodstopper))
		should_self_destroy = TRUE
	. = ..()
	if(should_self_destroy)
		visible_message("<span class='boldwarning'>The rod tears into the rodstopper with an earth-shattering screech!</span>")
		explosion(src, heavy_impact_range = 1, light_impact_range = 5, flame_range = 5)
		qdel(src)
