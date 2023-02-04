/datum/nifsoft/crewmonitor
	name = "Crew Monitor"
	desc = "A link to the local crew monitor sensors. Useful for finding people in trouble."
	list_pos = NIF_MEDMONITOR
	access = access_medical
	cost = 625
	p_drain = 0.025
	var/datum/tgui_module/crew_monitor/nif/arscreen

/datum/nifsoft/crewmonitor/New()
	..()
	arscreen = new(nif)

/datum/nifsoft/crewmonitor/Destroy()
	QDEL_NULL(arscreen)
	return ..()

/datum/nifsoft/crewmonitor/activate()
	if((. = ..()))
		arscreen.tgui_interact(nif.human)
		return TRUE

/datum/nifsoft/crewmonitor/deactivate(var/force = FALSE)
	if((. = ..()))
		return TRUE

/datum/nifsoft/crewmonitor/stat_text()
	return "Show Monitor"

/datum/nifsoft/alarmmonitor
	name = "Alarm Monitor"
	desc = "A link to the local alarm monitors. Useful for detecting alarms in a pinch."
	list_pos = NIF_ENGMONITOR
	access = access_engine
	cost = 625
	p_drain = 0.025
	var/datum/tgui_module/alarm_monitor/engineering/nif/tgarscreen

/datum/nifsoft/alarmmonitor/New()
	..()
	tgarscreen = new(nif)

/datum/nifsoft/alarmmonitor/Destroy()
	QDEL_NULL(tgarscreen)
	return ..()

/datum/nifsoft/alarmmonitor/activate()
	if((. = ..()))
		tgarscreen.tgui_interact(nif.human)
		return TRUE

/datum/nifsoft/alarmmonitor/deactivate(var/force = FALSE)
	if((. = ..()))
		return TRUE

/datum/nifsoft/alarmmonitor/stat_text()
	return "Show Monitor"
