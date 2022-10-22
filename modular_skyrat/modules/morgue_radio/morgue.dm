/obj/structure/bodycontainer/morgue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/morgue_radio)

/obj/structure/bodycontainer
	var/obj/item/radio/radio // The internal radio in the morgue trays.

/datum/component/morgue_radio
	var/obj/structure/bodycontainer/morgue/morgue // Typecasted reference to the current tray.


/datum/component/morgue_radio/RegisterWithParent()
	morgue = parent
	morgue.radio = new /obj/item/radio(morgue) // Initialize the radio in the morgue tray
	morgue.radio.set_listening(FALSE)
	RegisterSignal(morgue, COMSIG_MORGUE_ALARM, .proc/morgue_revivable)

/datum/component/morgue_radio/UnregisterFromParent()
	QDEL_NULL(morgue.radio)
	UnregisterSignal(morgue, COMSIG_MORGUE_ALARM)

/datum/component/morgue_radio/proc/morgue_revivable(mob/living/cadaver)
	morgue.radio.set_frequency(FREQ_MEDICAL)
	morgue.radio.talk_into(
		morgue,
		pick(
			"Electrical activity detected in morgue tray at [get_area_name(morgue)]. Please call technical support.",
			"Unexpected body in bagging area. Please scan unexpected body before placing in bagging area.",
			"Abnormal activity detected in [get_area_name(morgue)]. Please check [get_area_name(morgue)] for errors.",
			"ERROR. Brainwave activity detected in [cadaver]. This incident has been reported.  Please consult malpractice attorneys.",
		)
		,
		RADIO_CHANNEL_MEDICAL,
		)
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
		morgue.radio.talk_into(cadaver, "Help... Me...", RADIO_CHANNEL_MEDICAL)
