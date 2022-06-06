/datum/config_entry/number/prisoners_per_security // How many prisoners are spawned per security member? Set to 0 to disable this.
	default = 2
	min_val = 0

/datum/config_entry/number/max_prisoners_per_security // What's the maximum amount of prisoners to scale to? Set to 0 to disable. Doesn't apply if scaling is off.
	default = 12
	min_val = 0

/datum/job/proc/skyrat_precheck()
	SHOULD_CALL_PARENT(TRUE)
	pre_check_ran = TRUE

/datum/job/prisoner/skyrat_precheck()
	var/security_count = 0
	for(var/datum/job/potential_security in SSjob.all_occupations)
		if(potential_security.departments_bitflags & DEPARTMENT_BITFLAG_SECURITY)
			security_count += potential_security.current_positions
	var/prisoners_per = CONFIG_GET(number/prisoners_per_security)
	var/max_prisoners = CONFIG_GET(number/max_prisoners_per_security)
	if(prisoners_per > 0)
		var/prisoner_positions = round(prisoners_per * security_count)
		if(max_prisoners)
			prisoner_positions = min(prisoner_positions, max_prisoners)
		SSjob.JobDebug("Setting open prisoner positions to [prisoner_positions], due to [security_count] filled security positions. Maximum prisoners is set to [max_prisoners].")
		total_positions = prisoner_positions
		spawn_positions = prisoner_positions
	..()
