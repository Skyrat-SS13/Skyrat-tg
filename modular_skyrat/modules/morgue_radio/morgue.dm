#define MORGUE_RADIO_COOLDOWN 1 MINUTES

/obj/structure/bodycontainer/morgue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/morgue_radio)

/obj/structure/bodycontainer/morgue
	/// reference to internal radio in the morgue trays.
	var/obj/item/radio/headset/headset_med/radio

/datum/component/morgue_radio
	/// Typecasted reference to the current tray.
	var/obj/structure/bodycontainer/morgue/morgue
	/// Tracker for the morgue radio cooldown.
	COOLDOWN_DECLARE(radio_cooldown)

/datum/component/morgue_radio/Initialize(...)
	. = ..()
	morgue = parent
	if(!istype(morgue))
		return COMPONENT_INCOMPATIBLE

/datum/component/morgue_radio/RegisterWithParent()
	// Initialize the radio in the morgue tray.
	// Put it in the connected tray because ironically that makes it not pop out when the morgue is opened.
	morgue.radio = new /obj/item/radio/headset/headset_med(morgue.connected)
	morgue.radio.set_listening(FALSE)
	RegisterSignal(morgue, COMSIG_MORGUE_ALARM, .proc/morgue_revivable)

/datum/component/morgue_radio/UnregisterFromParent()
	QDEL_NULL(morgue.radio)
	UnregisterSignal(morgue, COMSIG_MORGUE_ALARM)

/// Proc that runs code to speak into the morgues internal radio.
/datum/component/morgue_radio/proc/morgue_revivable(cadaver)
	SIGNAL_HANDLER
	if(!morgue?.radio) // Runtime prevention
		return
	if(!COOLDOWN_FINISHED(src, radio_cooldown))
		return
	morgue.radio.talk_into(
		morgue,
		pick(
			"Electrical activity detected in morgue tray at [get_area_name(morgue)]. Please call technical support.",
			"Unexpected body in bagging area. Please scan unexpected body before placing in bagging area.",
			"Abnormal activity detected in [get_area_name(morgue)]. Please check [get_area_name(morgue)] for errors.",
			"ERROR. Brainwave activity detected in [cadaver]. This incident has been reported.  Please consult malpractice attorneys.",
		),
		RADIO_CHANNEL_MEDICAL,
	)

	COOLDOWN_START(src, radio_cooldown, MORGUE_RADIO_COOLDOWN)

#undef MORGUE_RADIO_COOLDOWN
