/obj/machinery/power/energy_accumulator/tesla_coil/RefreshParts()
	. = ..()
	var/new_power_multiplier = 0.44
	zap_cooldown = 10 SECONDS
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		new_power_multiplier += capacitor.tier * 0.12
		zap_cooldown -= (capacitor.tier * 2 SECONDS)

	input_power_multiplier = clamp(new_power_multiplier, 0.44, 0.92)
