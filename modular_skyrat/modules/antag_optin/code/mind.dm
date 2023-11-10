/datum/mind
	/// The optin level set by preferences.
	var/ideal_opt_in_level
	/// The actual optin level. Modified by things like job.
	var/opt_in_level

/datum/mind/transfer_to(mob/new_character, force_key_move)
	. = ..()

	update_opt_in()

/datum/mind/proc/update_opt_in()
	var/datum/preferences/preference_instance = GLOB.preferences_datums[lowertext(key)]
	ideal_opt_in_level = preference_instance.read_preference(/datum/preference/choiced/antag_opt_in_status)

/datum/mind/proc/get_effective_opt_in_level()
	return (max(ideal_opt_in_level, get_job_opt_in_level()))

/datum/mind/proc/get_job_opt_in_level()
	return assigned_role?.minimum_opt_in_level || ideal_opt_in_level
