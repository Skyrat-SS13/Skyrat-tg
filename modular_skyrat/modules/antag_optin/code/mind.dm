/datum/mind
	/// The optin level set by preferences.
	var/ideal_opt_in_level
	/// The actual optin level. Modified by things like job.
	var/opt_in_level

/datum/mind/proc/get_effective_opt_in_level()
	return (max(ideal_opt_in_level, get_job_opt_in_level()))

/datum/mind/proc/get_job_opt_in_level()
	return assigned_role?.minimum_opt_in_level || ideal_opt_in_level
