#define SENSORS_UPDATE_PERIOD 10 SECONDS //Why is this not a global define, why do I have to define it again


/obj/machinery/computer/crew
	luminosity = 1
	light_power = 3

/obj/machinery/computer/crew/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	alarm()

/obj/machinery/computer/crew/proc/alarm()
	var/canalarm = FALSE

	for(var/list/player_record as anything in GLOB.crewmonitor.update_data(src.z))
		if(player_record["health"] <= HEALTH_THRESHOLD_CRIT)

			canalarm = TRUE

	if(canalarm)
		playsound(src, 'sound/machines/twobeep.ogg', 50, TRUE)
		set_light((initial(light_range) + 3), 3, CIRCUIT_COLOR_SECURITY, TRUE)

	else
		set_light((initial(light_range)), initial(light_power), initial(light_color), TRUE)
	addtimer(CALLBACK(src, .proc/alarm), SENSORS_UPDATE_PERIOD)
	return canalarm
