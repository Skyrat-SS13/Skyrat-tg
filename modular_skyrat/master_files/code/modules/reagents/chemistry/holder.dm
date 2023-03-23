/**
 * Check if this holder contains a reagent with a `chemical_flags_skyrat` containing this flag.
 *
 * Arguments:
 * * chemical_flag - The bitflag to search for.
 * * min_volume - Checks for having a specific amount of reagents matching that `chemical_flag`
 */
/datum/reagents/proc/has_chemical_flag_skyrat(chemical_flag, min_volume = 0)
	var/found_amount = 0
	var/list/cached_reagents = reagent_list
	for(var/datum/reagent/holder_reagent as anything in cached_reagents)
		if (holder_reagent.chemical_flags_skyrat & chemical_flag)
			found_amount += holder_reagent.volume
			if(found_amount >= min_volume)
				return TRUE

	return FALSE
