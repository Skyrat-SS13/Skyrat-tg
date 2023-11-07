/datum/job
	/// If null, will defer to the mind's opt in level.
	var/minimum_opt_in_level
	var/heretic_sac_target
	/// Is this job targettable by contractors?
	var/contractable

/datum/job/New()
	. = ..()

	if (isnull(minimum_opt_in_level))
		minimum_opt_in_level = get_initial_opt_in_level()
	if (isnull(heretic_sac_target))
		heretic_sac_target = initialize_heretic_target_status()
	if (isnull(contractable))
		contractable = initialize_contractable_status()

/datum/job/proc/get_initial_opt_in_level()
	if (departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY))
		return SECURITY_OPT_IN_LEVEL
	if (departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND))
		return COMMAND_OPT_IN_LEVEL

/datum/job/proc/initialize_heretic_target_status()
	if (departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY))
		return TRUE
	if (departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND))
		return TRUE
	return FALSE

/datum/job/proc/initialize_contractable_status()
	if (departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY))
		return TRUE
	if (departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND))
		return TRUE
	return FALSE
