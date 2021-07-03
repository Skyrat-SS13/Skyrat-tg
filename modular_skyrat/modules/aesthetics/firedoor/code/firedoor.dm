/obj/machinery/door/firedoor
	name = "Emergency Shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor_glass.dmi'
	var/door_open_sound = 'modular_skyrat/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	var/door_close_sound = 'modular_skyrat/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	var/hot_or_cold = FALSE //True for hot, false for cold

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
		trigger_hot()
		close()

/obj/machinery/door/firedoor/proc/firealarm_on()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/close)

/obj/machinery/door/firedoor/proc/firealarm_off()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/open)

/obj/machinery/door/firedoor/proc/trigger_hot()
	SEND_SIGNAL(src, COMSIG_FIREDOOR_CLOSED_FIRE)

/obj/machinery/door/firedoor/proc/CalculateAffectingAreas()
	for(var/turf/adjacent_turf in range(1, src))
		RegisterSignal(adjacent_turf, COMSIG_TURF_EXPOSE, .proc/atmos_changed)

	var/my_area = get_area(src)

	for(var/obj/machinery/firealarm/iterating_alarm in my_area)
		iterating_alarm.RegisterSignal(src, COMSIG_FIREDOOR_CLOSED_FIRE, /obj/machinery/firealarm.proc/trigger_effects, FALSE) //We trigger the alarms automatically.

/obj/machinery/door/firedoor/update_icon_state()
	. = ..()
	if(density)
		icon_state = "[base_icon_state]_closed_[hot_or_cold ? "hot" : "cold"]"
	else
		icon_state = "[base_icon_state]_open"

/obj/machinery/door/firedoor/onetile/CalculateAffectingAreas()
	RegisterSignal(loc, COMSIG_TURF_EXPOSE, .proc/atmos_changed)

	var/my_area = get_area(src)

	for(var/obj/machinery/firealarm/iterating_alarm in my_area)
		iterating_alarm.RegisterSignal(src, COMSIG_FIREDOOR_CLOSED_FIRE, /obj/machinery/firealarm.proc/trigger_effects, FALSE) //We trigger the alarms automatically.

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)
