/obj/machinery/door/firedoor
	name = "Emergency Shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor_glass.dmi'
	var/door_open_sound = 'modular_skyrat/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	var/door_close_sound = 'modular_skyrat/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	var/hot_or_cold = FALSE //True for hot, false for cold
	var/list/firealarms = list()

/obj/machinery/door/firedoor/heavy
	name = "Heavy Emergency Shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor.dmi'

/obj/structure/firelock_frame
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor.dmi'

/obj/machinery/door/firedoor/open()
	playsound(loc, door_open_sound, 90, TRUE)
	. = ..()
/obj/machinery/door/firedoor/close()
	playsound(loc, door_close_sound, 90, TRUE)
	. = ..()

/obj/machinery/door/firedoor/proc/atmos_changed(datum/source, datum/gas_mixture/air, exposed_temperature)
	if(density)
		return
	var/pressure = air.return_pressure()
	if(exposed_temperature < BODYTEMP_COLD_DAMAGE_LIMIT || pressure < WARNING_LOW_PRESSURE)
		hot_or_cold = FALSE
		close()
	else if(exposed_temperature > BODYTEMP_HEAT_DAMAGE_LIMIT || pressure > WARNING_HIGH_PRESSURE)
		hot_or_cold = TRUE
		trigger_alarms()
		close()

/obj/machinery/door/firedoor/proc/trigger_alarms()
	if(firealarms)
		var/obj/machinery/firealarm/our_alarm = firealarms[1] //Just get the first item in the list, no point in iterating through them all.
		our_alarm.alarm(FALSE)

/obj/machinery/door/firedoor/Destroy()
	for(var/obj/machinery/firealarm/iterating_alarm in firealarms)
		iterating_alarm.firedoors -= src
	firealarms = null
	return ..()

/obj/machinery/door/firedoor/update_icon_state()
	. = ..()
	if(density)
		icon_state = "[base_icon_state]_closed_[hot_or_cold ? "hot" : "cold"]"
	else
		icon_state = "[base_icon_state]_open"
