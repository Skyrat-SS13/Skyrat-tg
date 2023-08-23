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

	if(SSjob.is_skeleton_engineering(3)) // Don't bother if there's command or a well staffed department, they -should- be paying attention.
		var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
		SSsecurity_level.minimum_security_level(SEC_LEVEL_ORANGE, TRUE, FALSE) // Give the skeleton crew a warning
		system.broadcast("The supermatter delamination early warning system has been triggered due to anomalous conditions. Please investigate the engine as soon as possible.", list(RADIO_CHANNEL_COMMAND))
		system.broadcast("In the event of uncontrolled delamination, please consult the documentation packet regarding usage of the supermatter emergency stop button.", list(RADIO_CHANNEL_COMMAND))
		system.broadcast("Failure to stabilise the engine may result in an automatic deployment of the suppression system.", list(RADIO_CHANNEL_COMMAND))

	log_admin("DELAM: Round timer under 30 minutes! Supermatter will perform an automatic delam suppression at strength 0%.")
	for(var/client/staff as anything in GLOB.admins)
		if(staff?.prefs.read_preference(/datum/preference/toggle/comms_notification))
			SEND_SOUND(staff, sound('sound/misc/server-ready.ogg'))
	message_admins("<font color='[COLOR_ADMIN_PINK]'>DELAM: Round timer under 30 minutes! [ADMIN_VERBOSEJMP(sm)] will perform an automatic delam suppression once integrity reaches 0%. (<a href='?src=[REF(src)];togglesuppression=yes'>TOGGLE AUTOMATIC INTERVENTION)</a>)</font>")
	sm.station_notified = TRUE

/datum/sm_delam/Topic(href, href_list)
	if(..())
		return

	if(!check_rights(R_FUN))
		return

	if(href_list["togglesuppression"])
		usr.client?.toggle_delam_suppression()

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
