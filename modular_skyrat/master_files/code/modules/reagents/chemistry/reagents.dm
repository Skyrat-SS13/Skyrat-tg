/datum/reagent
	/// Modular version of `chemical_flags`, so we don't have to worry about
	/// it causing conflicts in the future.
	var/chemical_flags_skyrat = NONE

/datum/reagent/drug/nicotine
	addiction_types = list(/datum/addiction/nicotine = 4) // 1.6 per 2 seconds
