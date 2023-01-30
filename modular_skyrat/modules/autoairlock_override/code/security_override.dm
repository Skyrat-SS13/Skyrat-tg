// This module sets airlocks in certain areas to be able to have a Security Override on red+ alert.
// Crew with ID cards with the security flag will be able to access these areas during those times.

/area
	/// Is this area eligible for security override?
	var/security_override_eligible = FALSE

// Set the areas that will receive expanded access for security on red+ alert

/area/station/ai_monitored/turret_protected/ai
	security_override_eligible = TRUE

/area/station/ai_monitored/turret_protected/aisat_interior
	security_override_eligible = TRUE

/area/station/ai_monitored/turret_protected/ai_upload
	security_override_eligible = TRUE

/area/station/ai_monitored/security/armory
	security_override_eligible = TRUE

/area/station/ai_monitored/command/storage/eva
	security_override_eligible = TRUE

/area/station/cargo
	security_override_eligible = TRUE

/area/station/command/bridge
	security_override_eligible = TRUE

/area/station/command/heads_quarters
	security_override_eligible = TRUE

/area/station/command/teleporter
	security_override_eligible = TRUE

/area/station/command/gateway
	security_override_eligible = TRUE

/area/station/construction/storage_wing
	security_override_eligible = TRUE

/area/station/engineering
	security_override_eligible = TRUE

/area/station/engineering/storage/tcomms
	security_override_eligible = TRUE

/area/station/hallway/secondary/service
	security_override_eligible = TRUE

/area/station/hallway/secondary/command
	security_override_eligible = TRUE

/area/station/maintenance
	security_override_eligible = TRUE

/area/station/medical
	security_override_eligible = TRUE

/area/station/service
	security_override_eligible = TRUE

/area/station/science
	security_override_eligible = TRUE

/area/station/security
	security_override_eligible = TRUE

/area/station/tcommsat
	security_override_eligible = TRUE

/obj/machinery/door/airlock
	/// Determines if security get access to this door on red+ alert
	var/security_override = FALSE

/obj/machinery/door/airlock/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_FORCE_SEC_OVERRIDE, PROC_REF(force_sec_override))

// When the signal is received of a changed security level, check if it's red or higher.
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

// Manual override for when it's not red alert.
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
		minor_announce("Expanded security access has been disabled.", "Security Emergency")
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
