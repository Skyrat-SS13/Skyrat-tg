/obj/machinery/door/airlock/bronze/clock/try_to_activate_door(mob/user, access_bypass)
	if(!IS_CLOCK(user))
		do_animate("deny")
		return
	return ..()


/obj/machinery/door/airlock/bronze/clock/bumpopen(mob/living/user) //Hey lois don't you love when there's two different procs to open a door?
	. = ..()
	if(!IS_CLOCK(user))
		do_animate("deny")
		return FALSE
	return ..()


/obj/machinery/door/airlock/bronze/seethru/clock/try_to_activate_door(mob/user, access_bypass)
	if(!IS_CLOCK(user))
		do_animate("deny")
		return
	return ..()


/obj/machinery/door/airlock/bronze/seethru/clock/bumpopen(mob/living/user)
	. = ..()
	if(!IS_CLOCK(user))
		do_animate("deny")
		return FALSE
	return ..()


/obj/structure/door_assembly/door_assembly_bronze/clock
	airlock_type = /obj/machinery/door/airlock/bronze/clock


/obj/structure/door_assembly/door_assembly_bronze/seethru/clock
	airlock_type = /obj/machinery/door/airlock/bronze/seethru/clock
