/// Check for the four states of open access. Emergency, Unrestricted, Security, and Engineering Override
/obj/machinery/door/airlock/allowed(mob/user)
	if(emergency)
		return TRUE

	if(unrestricted_side(user))
		return TRUE

	if(security_override)
		var/mob/living/carbon/human/interacting_human = user
		if(!istype(interacting_human))
			return ..()

		var/obj/item/card/id/card = interacting_human.get_idcard(TRUE)
		if(ACCESS_SECURITY in card?.access)
			return TRUE

	if(engineering_override)
		var/mob/living/carbon/human/interacting_human = user
		if(!istype(interacting_human))
			return ..()

		var/obj/item/card/id/card = interacting_human.get_idcard(TRUE)
		if(ACCESS_ENGINEERING in card?.access)
			return TRUE

	return ..()

// Pulse to disable emergency access/security/engineering override and flash the red lights.
/datum/wires/airlock/on_pulse(wire)
	. = ..()
	var/obj/machinery/door/airlock/airlock = holder
	switch(wire)
		if(WIRE_IDSCAN)
			if(airlock.hasPower() && airlock.density)
				airlock.do_animate("deny")
				if(airlock.emergency)
					airlock.emergency = FALSE
					airlock.update_appearance()
				if(airlock.security_override)
					airlock.security_override = FALSE
					airlock.update_appearance()
				if(airlock.engineering_override)
					airlock.engineering_override = FALSE
					airlock.update_appearance()
