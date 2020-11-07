/obj/machinery/firealarm/examine(mob/user)
	. = ..()
	if(GLOB.security_level == SEC_LEVEL_GREEN)
		. += "The current alert level is green."
	if(GLOB.security_level == SEC_LEVEL_BLUE)
		. += "The current alert level is blue."
	if(GLOB.security_level == SEC_LEVEL_AMBER)
		. += "The current alert level is amber."
	if(GLOB.security_level == SEC_LEVEL_ORANGE)
		. += "The current alert level is orange."
	if(GLOB.security_level == SEC_LEVEL_VIOLET)
		. += "The current alert level is violet."
	if(GLOB.security_level == SEC_LEVEL_RED)
		. += "The current alert level is red!"
	if(GLOB.security_level == SEC_LEVEL_DELTA)
		. += "The current alert level is delta! Evacuate!"
