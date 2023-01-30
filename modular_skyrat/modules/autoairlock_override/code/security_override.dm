// This module sets airlocks in certain areas to be able to have an Engineer Override on orange alert.
// Crew with ID cards with the engineering flag will be able to access these areas during those times.

/area
	/// Is this area eligible for engineer override?
	var/security_override_eligible = FALSE

// Set the areas that will receive expanded access for security on red alert
// exceptions go here
// blah blah blah

/area/station/ai_monitored/command/storage/eva
	security_override_eligible = TRUE

/area/station/medical
	security_override_eligible = TRUE

/obj/machinery/door/airlock
	/// Determines if engineers get access to this door on orange alert
	var/security_override = FALSE

/obj/machinery/door/airlock/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_FORCE_SEC_OVERRIDE, PROC_REF(force_sec_override))

/// Announce the new expanded access when engineer override is enabled.
/datum/controller/subsystem/security_level/announce_security_level(datum/security_level/selected_level)
	..()
	if(selected_level.number_level >= SEC_LEVEL_RED)
		minor_announce("Security staff will have expanded access to areas of the station during the emergency.", "Security Emergency")
		return

/// Check for the three states of open access. Emergency, Unrestricted, and Engineering Override
/obj/machinery/door/airlock/allowed(mob/user)
	if(emergency)
		return TRUE

	if(unrestricted_side(user))
		return TRUE

	if(security_override)
		var/mob/living/carbon/human/interacting_human = user
		if(!istype(interacting_human))
			return ..()

		var/obj/item/card/id/card = interacting_human.get_idcard(TRUE)
		if(ACCESS_SECURITY in card?.access)
			return TRUE

	return ..()

// When the signal is received of a changed security level, check if it's orange.
/obj/machinery/door/airlock/check_security_level(datum/source, level)
	. = ..()
	var/area/source_area = get_area(src)
	if(!source_area.security_override_eligible)
		return

	if(level < SEC_LEVEL_RED && GLOB.force_sec_override)
		return

	if(level >= SEC_LEVEL_RED)
		security_override = TRUE
		update_appearance()
		return

	security_override = FALSE
	update_appearance()
	return

// Manual override for when it's not orange alert.
GLOBAL_VAR_INIT(force_sec_override, FALSE)
/proc/toggle_sec_override()
	if(!GLOB.force_sec_override)
		GLOB.force_sec_override = TRUE
		minor_announce("Security staff will have expanded access to areas of the station during the emergency.", "Security Emergency")
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_SEC_OVERRIDE, TRUE)
		SSblackbox.record_feedback("nested tally", "keycard_auths", 1, list("security override access", "enabled"))
		return
	else
		GLOB.force_eng_override = FALSE
		minor_announce("Expanded engineering access has been disabled.", "Security Emergency")
		var/level = SSsecurity_level.get_current_level_as_number()
		SSblackbox.record_feedback("nested tally", "keycard_auths", 1, list("security override access", "disabled"))
		if(level >= SEC_LEVEL_RED)
			return
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_SEC_OVERRIDE, FALSE)
		return

/obj/machinery/door/airlock/proc/force_sec_override(datum/source, status)
	SIGNAL_HANDLER

	if(!status)
		security_override = FALSE
		update_appearance()
		return

	var/area/source_area = get_area(src)
	if(!source_area.security_override_eligible)
		return

	security_override = TRUE
	update_appearance()


// Pulse to disable emergency access/engineering override and flash the red lights.
/datum/wires/airlock/on_pulse(wire)
	. = ..()
	var/obj/machinery/door/airlock/airlock = holder
	switch(wire)
		if(WIRE_IDSCAN)
			if(airlock.hasPower() && airlock.density)
				airlock.do_animate("deny")
				if(airlock.emergency)
					airlock.emergency = FALSE
					airlock.update_appearance()
				if(airlock.security_override)
					airlock.security_override = FALSE
					airlock.update_appearance()
