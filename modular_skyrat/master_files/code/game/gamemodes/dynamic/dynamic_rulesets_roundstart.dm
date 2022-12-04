/datum/dynamic_ruleset/roundstart/quiet
	name = "Quiet"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	required_candidates = 0
	weight = 0
	cost = 0
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	flags = LONE_RULESET

/datum/dynamic_ruleset/roundstart/quiet/pre_execute()
	. = ..()
	log_game("Starting a round without roundstart antagonists.")
	return TRUE
