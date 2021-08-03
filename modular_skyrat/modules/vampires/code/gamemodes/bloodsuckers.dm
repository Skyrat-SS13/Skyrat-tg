/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "Bloodsuckers"
	config_tag = "bloodsucker"
	antag_flag = ROLE_BLOODSUCKER
	antag_datum = ANTAG_DATUM_BLOODSUCKER
	minimum_required_age = 0
	protected_roles = list("Chaplain", "Security Officer", "Warden", "Detective", "Brig Physician", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	restricted_roles = list("Cyborg", "AI")
	required_candidates = 1
	weight = 2
	cost = 15
	scaling_cost = 10
	property_weights = list("story_potential" = 1, "extended" = 1, "trust" = -2, "valid" = 1)
	requirements = list(70,65,60,55,50,50,50,50,50,50)
	high_population_requirement = 50
	antag_cap = list(1,1,1,1,1,2,2,2,2,2)

/datum/dynamic_ruleset/roundstart/bloodsucker/pre_execute()
	var/num_bloodsuckers = antag_cap[indice_pop] * (scaled_times + 1)
	for (var/i = 1 to num_bloodsuckers)
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.special_role = ROLE_BLOODSUCKER
		M.mind.restricted_roles = restricted_roles
	return TRUE

/datum/dynamic_ruleset/roundstart/bloodsucker/execute()
	mode.check_start_sunlight()
	for(var/datum/mind/M in assigned)
		if(mode.make_bloodsucker(M))
			mode.bloodsuckers += M
	return TRUE
