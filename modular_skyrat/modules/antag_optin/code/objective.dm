/datum/objective
	var/default_opt_in_level = OPT_IN_YES_KILL

/datum/objective/proc/get_opt_in_level()
	return default_opt_in_level

/datum/objective/proc/opt_in_valid(datum/mind/target_mind)
	return (get_opt_in_level() >= target_mind.get_effective_opt_in_level())

/datum/objective/capture
	default_opt_in_level = OPT_IN_YES_ROUND_REMOVE

/datum/objective/mutiny
	default_opt_in_level = OPT_IN_YES_KILL

/datum/objective/maroon
	default_opt_in_level = OPT_IN_YES_TEMP

/datum/objective/debrain
	default_opt_in_level = OPT_IN_YES_ROUND_REMOVE

/datum/objective/protect
	default_opt_in_level = OPT_IN_YES_TEMP

/datum/objective/protect/nonhuman
	default_opt_in_level = OPT_IN_YES_TEMP

/datum/objective/steal_n_of_type
	default_opt_in_level = OPT_IN_YES_TEMP

/datum/objective/steal
	default_opt_in_level = OPT_IN_YES_TEMP

/datum/objective/assassinate
	default_opt_in_level = OPT_IN_YES_KILL

/datum/objective/destroy
	default_opt_in_level = OPT_IN_YES_KILL

/datum/objective/absorb
	default_opt_in_level = OPT_IN_YES_ROUND_REMOVE

/datum/objective/absorb_changeling
	default_opt_in_level = OPT_IN_YES_ROUND_REMOVE

/datum/objective/sacrifice
	default_opt_in_level = OPT_IN_YES_ROUND_REMOVE

/datum/objective/escape/escape_with_identity
	default_opt_in_level = OPT_IN_YES_TEMP

/datum/objective/contract
	default_opt_in_level = OPT_IN_YES_TEMP

/datum/objective/contract/opt_in_valid(datum/mind/target_mind)
	var/datum/job/target_job = target_mind.assigned_role
	if (!target_job?.contractable)
		return FALSE

	return ..()
