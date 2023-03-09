/// Called by events to check/change security level.
/// Checks if the station security level is at least minimum_level, and if not, sets it to that level.
/// If orange, also sends the engineering override signal to airlocks to enable additional access.
/datum/round_event/proc/event_minimum_security_level(minimum_level = SEC_LEVEL_ORANGE, doors_override = TRUE)
	var/sec_level = SSsecurity_level.get_current_level_as_number()
	if(sec_level < minimum_level)
		SSsecurity_level.set_level(minimum_level)

	if(doors_override)
		GLOB.force_eng_override = TRUE
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, TRUE)
