/**
 * ICES - Intensity Credit Events System
 *
 * This is called by events to check/change security level.
 */

///
/// Checks if the station security level is at least minimum_level, and if not, sets it to that level.
/// If orange, also sends the engineering override signal to airlocks to enable additional access.
/// Arguments: min_level: number, eng_access: boolean, maint_access: boolean
/datum/round_event/proc/event_minimum_security_level(min_level = SEC_LEVEL_ORANGE, eng_access = TRUE, maint_access = FALSE)
	var/sec_level = SSsecurity_level.get_current_level_as_number()
	if(sec_level < min_level)
		SSsecurity_level.set_level(min_level)

	if(eng_access)
		GLOB.force_eng_override = TRUE
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, TRUE)

	if(maint_access)
		make_maint_all_access()
