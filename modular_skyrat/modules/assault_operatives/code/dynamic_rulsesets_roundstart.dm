/*
*	ASSAULT OPERATIVES
*/

#define ASSAULT_OPERATIVES_COUNT 6

/datum/dynamic_ruleset/roundstart/assault_operatives
	name = "Assault Operatives"
	antag_flag = ROLE_ASSAULT_OPERATIVE
	antag_datum = /datum/antagonist/assault_operative
	minimum_required_age = 14
	restricted_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_HEAD_OF_SECURITY,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_CHIEF_ENGINEER,
	)
	required_candidates = 5
	weight = 3
	cost = 20
	requirements = list(90, 90, 90, 80, 60, 40, 30, 20, 10, 10)
	flags = HIGH_IMPACT_RULESET
	antag_cap = list("denominator" = 18, "offset" = 1)
	var/datum/team/assault_operatives/assault_operatives_team

/datum/dynamic_ruleset/roundstart/assault_operatives/ready(population, forced = FALSE)
	required_candidates = get_antag_cap(population)
	. = ..()

/datum/dynamic_ruleset/roundstart/assault_operatives/pre_execute(population)
	. = ..()
	// If ready() did its job, candidates should have 5 or more members in it
	for(var/operatives_number in 1 to ASSAULT_OPERATIVES_COUNT)
		if(candidates.len <= 0)
			break
		var/mob/candidate = pick_n_take(candidates)
		assigned += candidate.mind
		candidate.mind.set_assigned_role(SSjob.GetJobType(/datum/job/assault_operative))
		candidate.mind.special_role = ROLE_ASSAULT_OPERATIVE
		GLOB.pre_setup_antags += candidate.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/assault_operatives/execute()
	assault_operatives_team = new()
	for(var/datum/mind/iterating_mind in assigned)
		GLOB.pre_setup_antags -= iterating_mind
		var/datum/antagonist/assault_operative/new_op = new antag_datum()
		iterating_mind.add_antag_datum(new_op, assault_operatives_team)
	if(assault_operatives_team.members.len)
		assault_operatives_team.update_objectives()
		SSgoldeneye.required_keys = get_goldeneye_key_count()
		return TRUE
	log_game("DYNAMIC: [ruletype] [name] failed to get any eligible assault operatives. Refunding [cost] threat.")
	return FALSE

/// Returns the required goldeneye keys for activation. This is to make sure we don't have an impossible to achieve goal. However, there has to be at least one key.
/datum/dynamic_ruleset/roundstart/assault_operatives/proc/get_goldeneye_key_count()
	return clamp(LAZYLEN(SSjob.get_all_heads()), 1, GOLDENEYE_REQUIRED_KEYS_MAXIMUM)
