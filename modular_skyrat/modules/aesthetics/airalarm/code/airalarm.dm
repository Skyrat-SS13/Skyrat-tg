/obj/machinery/airalarm
	icon = 'modular_skyrat/modules/aesthetics/airalarm/icons/airalarm.dmi'

/obj/machinery/airalarm/update_appearance(updates)
	. = ..()

	if(panel_open || (machine_stat & (NOPOWER|BROKEN)) || shorted)
		set_light(0)
		return FALSE

	var/color = LIGHT_COLOR_ELECTRIC_CYAN
	if(danger_level == AIR_ALARM_ALERT_HAZARD)
		color = LIGHT_COLOR_INTENSE_RED
	else if(danger_level == AIR_ALARM_ALERT_WARNING || my_area.active_alarms[ALARM_ATMOS])
		color = LIGHT_COLOR_ORANGE

	set_light(1.5, 1, color)

/obj/item/wallframe/airalarm
	icon = 'modular_skyrat/modules/aesthetics/airalarm/icons/airalarm.dmi'
