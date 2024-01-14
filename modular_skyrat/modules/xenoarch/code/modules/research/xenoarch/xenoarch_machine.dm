// Researcher, Scanner, Recoverer, and Digger

/obj/machinery/xenoarch
	///how long between each process
	var/process_speed = 10 SECONDS
	COOLDOWN_DECLARE(process_delay)

/obj/machinery/xenoarch/RefreshParts()
	. = ..()
	var/efficiency = -1 //to allow t1 parts to not change the base speed
	for(var/datum/stock_part/micro_laser/laser_part in component_parts)
		efficiency += laser_part.tier
	process_speed = initial(process_speed) - (6 SECONDS * efficiency)

/obj/machinery/xenoarch/process()
	if(machine_stat & (NOPOWER|BROKEN))
		COOLDOWN_RESET(src, process_delay) //if you are broken or no power, you aren't allowed to progress!
		return
	if(!COOLDOWN_FINISHED(src, process_delay))
		return
	COOLDOWN_START(process_delay)
	xenoarch_process()

/obj/machinery/xenoarch/proc/xenoarch_process()
	return
