/obj/machinery/firealarm/examine(mob/user)
	. = ..()
	. += "The current alert level is [SSsecurity_level.get_current_level_as_text()]."
