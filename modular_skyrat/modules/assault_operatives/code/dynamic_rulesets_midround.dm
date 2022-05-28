//////////////////////////////////////////////
//                                          //
//          ASSAULT OPERATIVES              //
//                                          //
//////////////////////////////////////////////


/datum/dynamic_ruleset/midround/from_ghosts/assault_operatives
	name = "Assault Operatives"
	antag_flag = ROLE_ASSAULT_OPERATIVE
	antag_flag_override = ROLE_ASSAULT_OPERATIVE
	antag_datum = /datum/antagonist/assault_operative
	minimum_required_age = 0
	enemy_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_RESEARCH_DIRECTOR,
		JOB_NT_REP,
		JOB_BLUESHIELD,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_HEAD_OF_PERSONNEL,
	)
	required_candidates = 4 // Minimum team is a bit smaller for midrounds
	weight = 5
	cost = 20
	flags = HIGH_IMPACT_RULESET
	antag_cap = list("denominator" = 18, "offset" = 1)
	var/datum/team/assault_operatives/assault_operatives_team
	var/list/operative_cap = list(2,2,3,3,4,5,5,6,6,6)

/datum/dynamic_ruleset/midround/from_ghosts/assault_operatives/ready(population, forced = FALSE)
	if (required_candidates > (length(dead_players) + length(list_observers)))
		return FALSE
	. = ..()

/datum/dynamic_ruleset/midround/from_ghosts/assault_operatives/acceptable(population=0, threat=0)
	if (locate(/datum/dynamic_ruleset/roundstart/assault_operatives) in mode.executed_rules)
		return FALSE // Unavailable if nuke ops were already sent at roundstart
	indice_pop = min(length(operative_cap), round(length(living_players) / 5) + 1)
	required_candidates = operative_cap[indice_pop]
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/assault_operatives/pre_execute(population)
	. = ..()
	// If ready() did its job, candidates should have 5 or more members in it
	for(var/operatives_number in 1 to ASSAULT_OPERATIVES_COUNT)
		if(length(candidates) <= 0)
			break
		var/mob/candidate = pick_n_take(candidates)
		assigned += candidate.mind
		candidate.mind.set_assigned_role(SSjob.GetJobType(/datum/job/assault_operative))
		candidate.mind.special_role = ROLE_ASSAULT_OPERATIVE
		GLOB.pre_setup_antags += candidate.mind
	return TRUE

/datum/dynamic_ruleset/midround/from_ghosts/assault_operatives/execute()
	assault_operatives_team = new()
	for(var/datum/mind/iterating_mind in assigned)
		GLOB.pre_setup_antags -= iterating_mind
		var/datum/antagonist/assault_operative/new_op = new antag_datum()
		iterating_mind.add_antag_datum(new_op, assault_operatives_team)
	if(length(assault_operatives_team.members))
		assault_operatives_team.update_objectives()
		SSgoldeneye.required_keys = get_goldeneye_key_count()
		return TRUE
	log_game("DYNAMIC: [ruletype] [name] failed to get any eligible assault operatives. Refunding [cost] threat.")
	return FALSE

/// Returns the required goldeneye keys for activation. This is to make sure we don't have an impossible to achieve goal. However, there has to be at least one key.
/datum/dynamic_ruleset/midround/from_ghosts/assault_operatives/proc/get_goldeneye_key_count()
	return clamp(LAZYLEN(SSjob.get_all_heads()), 1, GOLDENEYE_REQUIRED_KEYS_MAXIMUM)
