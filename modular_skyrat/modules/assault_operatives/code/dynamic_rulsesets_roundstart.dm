//////////////////////////////////////////////
//                                          //
//          ASSAULT OPERATIVES              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/assault_operatives
	name = "Assault Operatives"
	antag_flag = ROLE_ASSAULT_OPERATIVE
	antag_datum = /datum/antagonist/assault_operative
	minimum_required_age = 14
	restricted_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
	)
	required_candidates = 5
	weight = 3
	cost = 20
	requirements = list(90,90,90,80,60,40,30,20,10,10)
	flags = HIGH_IMPACT_RULESET
	antag_cap = list("denominator" = 18, "offset" = 1)
	var/datum/team/assault_operatives/assault_operatives_team

/datum/dynamic_ruleset/roundstart/assault_operatives/ready(population, forced = FALSE)
	required_candidates = get_antag_cap(population)
	. = ..()

/datum/dynamic_ruleset/roundstart/assault_operatives/pre_execute(population)
	. = ..()
	// If ready() did its job, candidates should have 5 or more members in it
	var/operatives = get_antag_cap(population)
	for(var/operatives_number = 1 to operatives)
		if(candidates.len <= 0)
			break
		var/mob/mob = pick_n_take(candidates)
		assigned += mob.mind
		mob.mind.set_assigned_role(SSjob.GetJobType(/datum/job/assault_operative))
		mob.mind.special_role = ROLE_ASSAULT_OPERATIVE
		GLOB.pre_setup_antags += mob.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/assault_operatives/execute()
	assault_operatives_team = new()
	for(var/datum/mind/mind in assigned)
		GLOB.pre_setup_antags -= mind
		var/datum/antagonist/assault_operative/new_op = new antag_datum()
		mind.add_antag_datum(new_op, assault_operatives_team)
	if(assault_operatives_team.members.len)
		assault_operatives_team.update_objectives()
		return TRUE
	log_game("DYNAMIC: [ruletype] [name] failed to get any eligible assault operatives. Refunding [cost] threat.")
	return FALSE


/datum/dynamic_ruleset/roundstart/assault_operatives/round_result()
	var/result = assault_operatives_team.get_result()
	SSticker.news_report = OPERATIVE_SKIRMISH
	switch(result)
		if(ASSAULT_RESULT_OPERATIVE_WIN)
			SSticker.mode_result = "win - assault operatives extracted data"
		if(ASSAULT_RESULT_OPERATIVE_PARTIAL_WIN)
			SSticker.mode_result = "partial win - assault operatives extracted some data"
		if(ASSAULT_RESULT_CREW_WIN)
			SSticker.mode_result = "loss - assault operatives failed to extract data"
