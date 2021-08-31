/datum/round_event_control/apc_failure
	name = "APC Failure"
	typepath = /datum/round_event/apc_failure
	weight = 20
	max_occurrences = 5 // want this to be rare, so as to not piss off engies
	alert_observers = FALSE

/datum/round_event/apc_failure
	fakeable = FALSE

/datum/round_event/apc_failure/start()
	var/iterations = 1
	var/list/apcs = GLOB.apcs_list.Copy()
	while(prob(round(100/iterations)))
		var/obj/machinery/power/apc/target_apc = pick_n_take(apcs)
		if(!target_apc)
			break
		if(!(is_station_level(target_apc.z)))
			continue
		if(!(target_apc.obj_flags & EMAGGED))
			flick("apc-spark", target_apc)
			playsound(target_apc, "sparks", 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
			target_apc.obj_flags |= EMAGGED
			if(prob(75)) // Give malfies a chance, too, but most likely to be unlocked so as to not hinder controlling said APC
				target_apc.locked = FALSE
			target_apc.update_appearance()
		iterations *= 2.5








