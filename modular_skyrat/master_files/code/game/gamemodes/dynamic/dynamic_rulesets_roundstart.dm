/datum/dynamic_ruleset/roundstart/quiet
	name = "Quiet"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	enemy_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
	)
	required_candidates = 1
	weight = 1
	cost = 0
	flags = LONE_RULESET

/datum/dynamic_ruleset/roundstart/quiet/pre_execute(population)
	. = ..()
	var/num_candidates = rand(1, 4) * (scaled_times + 1)
	for (var/i in 1 to num_candidates)
		if(length(candidates) <= 0)
			break
		var/mob/candidate = pick_n_take(candidates)
		assigned += candidate.mind
		candidate.mind.special_role = ROLE_OPFOR_CANDIDATE
		candidate.mind.restricted_roles = restricted_roles
		GLOB.pre_setup_antags += candidate.mind
		candidate.mind.add_antag_datum(/datum/antagonist/opfor_candidate)
	return TRUE

/datum/dynamic_ruleset/roundstart/quiet/trim_candidates()
	for(var/mob/dead/new_player/candidate_player in candidates)
		var/client/candidate_client = GET_CLIENT(candidate_player)
		if (!candidate_client || !candidate_player.mind) // Are they connected?
			candidates.Remove(candidate_player)
			continue

		if(candidate_client.get_remaining_days(minimum_required_age) > 0)
			candidates.Remove(candidate_player)
			continue

		if(candidate_player.mind.special_role) // We really don't want to give antag to an antag.
			candidates.Remove(candidate_player)
			continue

		if (is_banned_from(candidate_player.ckey, BAN_OPFOR))
			candidates.Remove(candidate_player)
			continue
