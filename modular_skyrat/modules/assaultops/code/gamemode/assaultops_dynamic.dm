/*
//////////////////////////////////////////////
//                                          //
//          ASSAULT OPERATIVES              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/assaultops
	name = "Assault Operatives"
	antag_flag = ROLE_ASSAULTOPS
	antag_datum = /datum/antagonist/nukeop
	var/datum/antagonist/antag_leader_datum = /datum/antagonist/nukeop/leader
	minimum_required_age = 14
	restricted_roles = list("Head of Security", "Captain") // Just to be sure that a nukie getting picked won't ever imply a Captain or HoS not getting drafted
	required_candidates = 5
	weight = 3
	cost = 40
	requirements = list(90,90,90,80,60,40,30,20,10,10)
	flags = HIGHLANDER_RULESET
	antag_cap = list(2,2,2,3,3,3,4,4,5,5)
	var/datum/team/assaultops/assault_team

/datum/dynamic_ruleset/roundstart/assaultops/ready(forced = FALSE)
	required_candidates = antag_cap[indice_pop]
	. = ..()

/datum/dynamic_ruleset/roundstart/assaultops/pre_execute()
	var/n_agents = min(round(num_players() / 10), antag_candidates.len, agents_possible)
	if(n_agents >= required_enemies)
		for(var/i = 0, i < n_agents, ++i)
			var/datum/mind/new_op = pick_n_take(antag_candidates)
			pre_operatives += new_op
			new_op.assigned_role = "Assault Operative"
			new_op.special_role = "Assault Operative"
			log_game("[key_name(new_op)] has been selected as an Assault operative")
		return TRUE
	else
		setup_error = "Not enough assault op candidates"
		return FALSE

/datum/dynamic_ruleset/roundstart/assaultops/execute()
	//Assign leader
	var/datum/mind/leader_mind = pre_operatives[1]
	var/datum/antagonist/assaultops/L = leader_mind.add_antag_datum(leader_antag_datum_type)
	assault_team = L.assault_team
	//Assign the remaining operatives
	for(var/i = 2 to pre_operatives.len)
		var/datum/mind/assault_mind = pre_operatives[i]
		assault_mind.add_antag_datum(operative_antag_datum_type)
	//Assign the targets
	for(var/i in GLOB.player_list)
		if(ishuman(i))
			var/mob/living/carbon/human/H = i
			if(H.job == "Captain" || "Head of Personnel" || "Quartermaster" || "Head of Security" || "Chief Engineer" || "Research Director" || "Blueshield" || "Security Officer" || "Warden") //UGH SHITCODE!!
				GLOB.assaultops_targets.Add(H)
	return ..()

/datum/dynamic_ruleset/roundstart/assaultops/round_result()
	var/result = assault_team.get_result()
	switch(result)
		if(NUKE_RESULT_FLUKE)
			SSticker.mode_result = "loss - takeover failed - crew secured"
			SSticker.news_report = NUKE_SYNDICATE_BASE
		if(ASSAULT_RESULT_ASSAULT_WIN)
			SSticker.mode_result = "win - syndicate takeover"
			SSticker.news_report = STATION_NUKED
		if(ASSAULT_RESULT_CREW_WIN)
			SSticker.mode_result = "loss - evacuation - no takeover"
			SSticker.news_report = OPERATIVES_KILLED
		else
			SSticker.mode_result = "halfwin - interrupted"
			SSticker.news_report = OPERATIVE_SKIRMISH

//////////////////////////////////////////////
//                                          //
//          ASSAULT OPERATIVES (MIDROUND)   //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/nuclear
	name = "Nuclear Assault"
	antag_flag = ROLE_OPERATIVE
	antag_datum = /datum/antagonist/nukeop
	enemy_roles = list("AI", "Cyborg", "Security Officer", "Warden","Detective","Head of Security", "Captain")
	required_enemies = list(3,3,3,3,3,2,1,1,0,0)
	required_candidates = 5
	weight = 5
	cost = 35
	requirements = list(90,90,90,80,60,40,30,20,10,10)
	var/list/operative_cap = list(2,2,3,3,4,5,5,5,5,5)
	var/datum/team/nuclear/nuke_team
	flags = HIGHLANDER_RULESET

/datum/dynamic_ruleset/midround/from_ghosts/nuclear/acceptable(population=0, threat=0)
	if (locate(/datum/dynamic_ruleset/roundstart/nuclear) in mode.executed_rules)
		return FALSE // Unavailable if nuke ops were already sent at roundstart
	indice_pop = min(operative_cap.len, round(living_players.len/5)+1)
	required_candidates = operative_cap[indice_pop]
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/nuclear/ready(forced = FALSE)
	if (required_candidates > (dead_players.len + list_observers.len))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/nuclear/finish_setup(mob/new_character, index)
	new_character.mind.special_role = "Nuclear Operative"
	new_character.mind.assigned_role = "Nuclear Operative"
	if (index == 1) // Our first guy is the leader
		var/datum/antagonist/nukeop/leader/new_role = new
		nuke_team = new_role.nuke_team
		new_character.mind.add_antag_datum(new_role)
	else
		return ..()
*/
