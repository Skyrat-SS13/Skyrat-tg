/// Adds "neuter" (it/its) to the list of possible gender choices.
/datum/preference/choiced/gender/init_possible_values()
	return list(MALE, FEMALE, PLURAL, NEUTER)
