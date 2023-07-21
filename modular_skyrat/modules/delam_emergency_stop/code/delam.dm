/obj/machinery/power/supermatter_crystal
	/// If admins and the station have been notified according to the delam suppression function
	var/station_notified = FALSE

/datum/sm_delam/proc/notify_delam_suppression(obj/machinery/power/supermatter_crystal/sm)
	if(!sm.is_main_engine)
		return

	if(sm.station_notified)
		return

	if(world.time - SSticker.round_start_time > 30 MINUTES)
		return

	sm.station_notified = TRUE
	log_admin("DELAM: Round timer under 30 minutes! Supermatter will perform an automatic delam suppression at strength 0%.")
	message_admins(span_adminnotice("DELAM: Round timer under 30 minutes! [ADMIN_VERBOSEJMP(sm)] will perform an automatic delam suppression once integrity reaches 0%. To cancel this, press the 'Toggle Delam Suppression' verb on the EVENTS status tab."))

	if(!SSjob.is_skeleton_engineering(3)) // Don't bother if there's command or a well staffed department, they -should- be paying attention.
		return

	SSsecurity_level.minimum_security_level(SEC_LEVEL_ORANGE, TRUE, FALSE) // Give the skeleton crew a warning

/**
 * Check if the station manifest has at least a certain amount of this staff type
 *
 * Arguments:
 * * crew_threshold - amount of crew before it's no longer considered a skeleton crew
 *
*/
/datum/controller/subsystem/job/proc/is_skeleton_engineering(crew_threshold)
	var/engineers = 0
	for(var/datum/record/crew/target in GLOB.manifest.general)
		if(target.trim == JOB_CHIEF_ENGINEER)
			return FALSE

		if(target.trim == JOB_STATION_ENGINEER)
			engineers++

		if(target.trim == JOB_ATMOSPHERIC_TECHNICIAN)
			engineers++

	if(engineers > crew_threshold)
		return FALSE

	return TRUE
