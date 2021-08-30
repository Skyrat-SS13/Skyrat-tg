/datum/round_event_control/apc_failure
	name = "APC Failure"
	typepath = /datum/round_event/apc_failure
	weight = 50
	max_occurrences = 5 // want this to be rare, so as to not piss off engies
	alert_observers = FALSE

/datum/round_event/apc_failure
	fakeable = FALSE

/datum/round_event/apc_failure/start()
	var/obj/machinery/power/apc/target_apc = pick(GLOB.apcs_list)
	if(is_station_level(target_apc.z))
		flick("apc-spark", target_apc)
		playsound(target_apc, "sparks", 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		target_apc.obj_flags |= EMAGGED
		if(prob(75)) // Give malfies a chance, too, but most likely to be unlocked so as to not hinder controlling said APC
			target_apc.locked = FALSE
		target_apc.update_appearance()
		return


