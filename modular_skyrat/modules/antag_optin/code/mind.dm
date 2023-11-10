/datum/mind
	/// The optin level set by preferences.
	var/ideal_opt_in_level

/datum/mind/transfer_to(mob/new_character, force_key_move)
	. = ..()

	update_opt_in()

/// Refreshes our ideal opt in level by accessing preferences.
/datum/mind/proc/update_opt_in()
	var/datum/preferences/preference_instance = GLOB.preferences_datums[lowertext(key)]
	ideal_opt_in_level = preference_instance.read_preference(/datum/preference/choiced/antag_opt_in_status)

/// Gets the actual opt-in level used for determining targets.
/datum/mind/proc/get_effective_opt_in_level()
	return (max(ideal_opt_in_level, get_job_opt_in_level()))

/// Returns the opt in level of our job, deferring to our ideal if there is no level.
/datum/mind/proc/get_job_opt_in_level()
	return assigned_role?.minimum_opt_in_level || ideal_opt_in_level
