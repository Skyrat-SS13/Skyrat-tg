/// Fired when there are no valid candidates. Try another roll after a delay.
/datum/dynamic_ruleset/midround/from_ghosts/attempt_replacement()
	SSdynamic.alternate_midround_injection()
	return
