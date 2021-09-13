/obj/effect/immovablerod/Bump(atom/clong)
	var/should_self_destroy = FALSE
	if(istype(clong, /obj/machinery/rodstopper))
		should_self_destroy = TRUE
	. = ..()
	if(should_self_destroy)

		visible_message("<span class='boldwarning'>The rod tears into the rodstopper with a reality-rending screech!</span>")
		playsound(src.loc,'sound/effects/supermatter.ogg', 200, TRUE)

		new/obj/boh_tear(src.loc)
		qdel(src)
