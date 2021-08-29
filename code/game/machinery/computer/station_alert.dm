/obj/machinery/computer/station_alert
	name = "station alert console"
	desc = "Used to access the station's automated alert system."
	icon_screen = "alert:0"
	icon_keyboard = "atmos_key"
	circuit = /obj/item/circuitboard/computer/stationalert
	light_color = LIGHT_COLOR_CYAN
	/// Station alert datum for showing alerts UI
	var/datum/station_alert/alert_control

/obj/machinery/computer/station_alert/Initialize()
	alert_control = new(src, list(ALARM_ATMOS, ALARM_FIRE, ALARM_POWER), list(z), title = name)
	return ..()

/obj/machinery/computer/station_alert/Destroy()
	QDEL_NULL(alert_control)
	return ..()

<<<<<<< HEAD
/obj/machinery/computer/station_alert/ui_interact(mob/user, datum/tgui/ui)
	//SKYRAT EDIT ADDITON BEGIN - AESTHETICS
	if(clicksound && world.time > next_clicksound && isliving(user))
		next_clicksound = world.time + rand(50, 100)
		playsound(src, get_sfx_skyrat(clicksound), clickvol)
	//SKYRAT EDIT END
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "StationAlertConsole", name)
		ui.open()

/obj/machinery/computer/station_alert/ui_data(mob/user)
	var/list/data = list()

	data["alarms"] = list()
	var/list/alarms = listener.alarms
	for(var/alarm_type in alarms)
		data["alarms"][alarm_type] = list()
		for(var/area_name in alarms[alarm_type])
			data["alarms"][alarm_type] += area_name

	return data
=======
/obj/machinery/computer/station_alert/ui_interact(mob/user)
	alert_control.ui_interact(user)
>>>>>>> ccfa0fba7d7 (tgui: Silicon Station Alerts (#61070))

/obj/machinery/computer/station_alert/on_set_machine_stat(old_value)
	if(machine_stat & BROKEN)
		alert_control.listener.prevent_alarm_changes()
	else
		alert_control.listener.allow_alarm_changes()

/obj/machinery/computer/station_alert/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return
<<<<<<< HEAD
	if(listener && length(listener.alarms)) //skyrat edit: fix createanddestroy
=======
	if(length(alert_control.listener.alarms))
>>>>>>> ccfa0fba7d7 (tgui: Silicon Station Alerts (#61070))
		. += "alert:2"
