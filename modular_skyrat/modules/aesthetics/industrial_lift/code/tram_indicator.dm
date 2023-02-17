/obj/machinery/destination_sign/indicator
	icon = 'modular_skyrat/modules/aesthetics/industrial_lift/icons/industrial_lift.dmi'
	light_range = 1
	light_power = 1
	light_color = LIGHT_COLOR_DARK_BLUE
	var/light_mask = "indicator_light_mask"
	luminosity = 1

/obj/machinery/destination_sign/indicator/update_sign()
	var/datum/lift_master/tram/tram = tram_ref?.resolve()

	if(!tram || !tram.is_operational)
		icon_state = "[base_icon_state][DESTINATION_NOT_IN_SERVICE]"
		update_appearance()
		return PROCESS_KILL

	use_power(active_power_usage)

	if(!tram.travelling)
		if(istype(tram.from_where, /obj/effect/landmark/tram/left_part))
			icon_state = "[base_icon_state][DESTINATION_WEST_IDLE]"
			previous_destination = tram.from_where
			update_appearance()
			return PROCESS_KILL

		if(istype(tram.from_where, /obj/effect/landmark/tram/middle_part))
			icon_state = "[base_icon_state][DESTINATION_CENTRAL_IDLE]"
			previous_destination = tram.from_where
			update_appearance()
			return PROCESS_KILL

		if(istype(tram.from_where, /obj/effect/landmark/tram/right_part))
			icon_state = "[base_icon_state][DESTINATION_EAST_IDLE]"
			previous_destination = tram.from_where
			update_appearance()
			return PROCESS_KILL

	if(istype(tram.from_where, /obj/effect/landmark/tram/left_part))
		icon_state = "[base_icon_state][DESTINATION_WEST_ACTIVE]"
		update_appearance()
		return PROCESS_KILL

	if(istype(tram.from_where, /obj/effect/landmark/tram/middle_part))
		if(istype(previous_destination, /obj/effect/landmark/tram/left_part))
			icon_state = "[base_icon_state][DESTINATION_CENTRAL_EASTBOUND_ACTIVE]"
		if(istype(previous_destination, /obj/effect/landmark/tram/right_part))
			icon_state = "[base_icon_state][DESTINATION_CENTRAL_WESTBOUND_ACTIVE]"
		update_appearance()
		return PROCESS_KILL

	if(istype(tram.from_where, /obj/effect/landmark/tram/right_part))
		icon_state = "[base_icon_state][DESTINATION_EAST_ACTIVE]"

		update_appearance()
		return PROCESS_KILL

/obj/machinery/destination_sign/indicator/update_appearance(updates)
	. = ..()
	if(!light_mask)
		return

	. += emissive_appearance(icon, light_mask, src, alpha = alpha)

/obj/machinery/button/tram
	icon_state = "tramctrl"
	skin = "tramctrl"
	light_color = LIGHT_COLOR_DARK_BLUE
	light_mask = "tram-light-mask"

/obj/machinery/button/tram/update_overlays()
	. = ..()
	if(!light_mask)
		return

	if(!(machine_stat & (NOPOWER|BROKEN)) && !panel_open)
		. += emissive_appearance(icon, light_mask, src, alpha = alpha)
