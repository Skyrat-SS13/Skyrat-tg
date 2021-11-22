#define FIREDOOR_CLOSE_OVERRIDE_RESET_TIME 3 MINUTES

/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor_glass.dmi'

	req_access = list(ACCESS_ATMOSPHERICS)

	var/door_open_sound = 'modular_skyrat/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	var/door_close_sound = 'modular_skyrat/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	var/hot_or_cold = FALSE //True for hot, false for cold

	var/stay_open = FALSE // Do we stay open? Triggered via atmos techs using their ID on it.
	var/has_hotcold_sprite = TRUE //does it actually have the sprites needed

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor.dmi'

/obj/structure/firelock_frame
	icon = 'modular_skyrat/modules/aesthetics/firedoor/icons/firedoor.dmi'

/obj/machinery/door/firedoor/border_only
	has_hotcold_sprite = FALSE

/obj/machinery/door/firedoor/open()
	playsound(loc, door_open_sound, 90, TRUE)
	. = ..()

/obj/machinery/door/firedoor/close()
	if(stay_open)
		return
	playsound(loc, door_close_sound, 90, TRUE)
	return ..()

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
		RegisterSignal(adjacent_turf, COMSIG_TURF_EXPOSE, .proc/atmos_changed, override = TRUE)

	var/my_area = get_area(src)

	for(var/obj/machinery/firealarm/iterating_alarm in my_area)
		iterating_alarm.RegisterSignal(src, COMSIG_FIREDOOR_CLOSED_FIRE, /obj/machinery/firealarm.proc/trigger_effects, override = TRUE) //We trigger the alarms automatically.

/obj/machinery/door/firedoor/update_icon_state()
	. = ..()
	if(density)
		icon_state = "[base_icon_state]_closed[has_hotcold_sprite ? (hot_or_cold ? "_hot" : "_cold") : ""]"
	else
		icon_state = "[base_icon_state]_open"

/obj/machinery/door/firedoor/onetile/CalculateAffectingAreas()
	RegisterSignal(loc, COMSIG_TURF_EXPOSE, .proc/atmos_changed, override = TRUE)

	var/my_area = get_area(src)

	for(var/obj/machinery/firealarm/iterating_alarm in my_area)
		iterating_alarm.RegisterSignal(src, COMSIG_FIREDOOR_CLOSED_FIRE, /obj/machinery/firealarm.proc/trigger_effects, override = TRUE) //We trigger the alarms automatically.

/obj/machinery/door/firedoor/attackby(obj/item/C, mob/user, params)
	if(C.GetID())
		if(allowed(user))
			toggle_close_override(user)
	return ..()


/obj/machinery/door/firedoor/CtrlClick(mob/user)
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	toggle_close_override(user)

/obj/machinery/door/firedoor/proc/toggle_close_override(mob/user)
	stay_open = !stay_open
	balloon_alert(user, "close override [stay_open ? "engaged" : "disengaged"]")
	addtimer(CALLBACK(src, .proc/close_override_reset), FIREDOOR_CLOSE_OVERRIDE_RESET_TIME)

/obj/machinery/door/firedoor/proc/close_override_reset()
	stay_open = FALSE

/obj/machinery/door/firedoor/examine(mob/user)
	. = ..()
	if(issilicon(user))
		. += span_notice("You can override the closing mechanism by Ctrl+Clicking on the firelock.")
	else
		. += span_notice("You can override the closing mechanism by swiping your ID on it, providing it has Atmospherics Access.")
	. += span_notice("It's close override mechanism is [stay_open ? "engaged" : "disengaged"].")

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)

#undef FIREDOOR_CLOSE_OVERRIDE_RESET_TIME
