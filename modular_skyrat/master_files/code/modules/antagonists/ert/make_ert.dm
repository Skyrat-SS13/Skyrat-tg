#define ERT_EXPERIENCED_LEADER_CHOOSE_TOP 3

/**
 * Make ERT
 *
 * A generalised ERT creation proc, useful for when you want to make an ERT, but not require an admin.
 *
 * PROC IS NOT ASYNC.
 */
/proc/make_ert(ert_type, teamsize = 5, mission_objective_override = "Assist the station.", poll_description = "an ERT team", code = "UNKNOWN", enforce_human = FALSE, open_armory_doors = FALSE, leader_experience = FALSE, random_names = TRUE, notify_players = TRUE, spawnpoint_override)
	if(!ert_type)
		return

	var/datum/ert/created_ert_datum = new ert_type

	created_ert_datum.teamsize = teamsize
	created_ert_datum.mission = mission_objective_override
	created_ert_datum.polldesc = poll_description
	created_ert_datum.enforce_human = enforce_human
	created_ert_datum.opendoors = open_armory_doors
	created_ert_datum.leader_experience = leader_experience
	created_ert_datum.random_names = random_names
	created_ert_datum.notify_players = notify_players
	created_ert_datum.code = code

	var/list/spawnpoints

	if(spawnpoint_override)
		spawnpoints = spawnpoint_override
	else
		spawnpoints = GLOB.emergencyresponseteamspawn

	if(!LAZYLEN(spawnpoints))
		CRASH("make_ert had no ERT spawnpoints to choose from!")

	var/list/mob/dead/observer/candidates = SSpolling.poll_ghost_candidates("Do you wish to be considered for [created_ert_datum.polldesc]?", ROLE_DEATHSQUAD)

	if(!LAZYLEN(candidates))
		return FALSE

	//Create team
	var/datum/team/ert/ert_team = new created_ert_datum.team
	if(created_ert_datum.rename_team)
		ert_team.name = created_ert_datum.rename_team

	//Assign team objective
	var/datum/objective/mission_objective = new ()
	mission_objective.team = ert_team
	mission_objective.explanation_text = created_ert_datum.mission
	mission_objective.completed = TRUE
	ert_team.objectives += mission_objective
	ert_team.mission = mission_objective

	var/mob/dead/observer/earmarked_leader
	var/leader_spawned = FALSE // just in case the earmarked leader disconnects or becomes unavailable, we can try giving leader to the last guy to get chosen

	if(created_ert_datum.leader_experience)
		var/list/candidate_living_exps = list()
		for(var/mob/dead/observer/potential_leader as anything in candidates)
			candidate_living_exps[potential_leader] = potential_leader.client?.get_exp_living(TRUE)

		candidate_living_exps = sort_list(candidate_living_exps, cmp = /proc/cmp_numeric_dsc)
		if(LAZYLEN(candidate_living_exps) > ERT_EXPERIENCED_LEADER_CHOOSE_TOP)
			candidate_living_exps = candidate_living_exps.Cut(ERT_EXPERIENCED_LEADER_CHOOSE_TOP + 1) // pick from the top ERT_EXPERIENCED_LEADER_CHOOSE_TOP contenders in playtime
		earmarked_leader = pick(candidate_living_exps)
	else
		earmarked_leader = pick(candidates)

	var/index = 0
	var/number_of_agents = min(created_ert_datum.teamsize, LAZYLEN(candidates))
	var/team_spawned = FALSE

	while(number_of_agents && LAZYLEN(candidates))
		var/spawnloc = spawnpoints[index + 1]
		//loop through spawnpoints one at a time
		index = (index + 1) % spawnpoints.len
		var/mob/dead/observer/chosen_candidate = earmarked_leader || pick(candidates) // this way we make sure that our leader gets chosen
		candidates -= chosen_candidate
		if(!chosen_candidate?.key)
			continue

		//Spawn the body
		var/mob/living/carbon/human/ert_operative = new created_ert_datum.mobtype(spawnloc)
		chosen_candidate.client.prefs.safe_transfer_prefs_to(ert_operative, is_antag = TRUE)
		ert_operative.key = chosen_candidate.key

		if(created_ert_datum.enforce_human || !(ert_operative.dna.species.changesource_flags & ERT_SPAWN)) // Don't want any exploding plasmemes
			ert_operative.set_species(/datum/species/human)

		//Give antag datum
		var/datum/antagonist/ert/ert_antag

		if((chosen_candidate == earmarked_leader) || (number_of_agents && !leader_spawned))
			ert_antag = new created_ert_datum.leader_role
			earmarked_leader = null
			leader_spawned = TRUE
		else
			ert_antag = created_ert_datum.roles[WRAP(number_of_agents, 1, length(created_ert_datum.roles) + 1)]
			ert_antag = new ert_antag ()
		ert_antag.random_names = created_ert_datum.random_names

		ert_operative.mind.add_antag_datum(ert_antag,ert_team)
		ert_operative.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))

		//Logging and cleanup
		log_game("[key_name(ert_operative)] has been selected as an [ert_antag.name]")
		number_of_agents--
		team_spawned++

	if(team_spawned)
		message_admins("[created_ert_datum.polldesc] has spawned with the mission: [created_ert_datum.mission]")
		if(created_ert_datum.notify_players)
			priority_announce("Central command has responded to your request for a CODE [uppertext(created_ert_datum.code)] Emergency Response Team and have confirmed one to be enroute.", "ERT Request", ANNOUNCER_ERTYES)
	//Open the Armory doors
	if(created_ert_datum.opendoors)
		for(var/obj/machinery/door/poddoor/ert/door as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor/ert))
			door.open()
			CHECK_TICK
	return TRUE

#undef ERT_EXPERIENCED_LEADER_CHOOSE_TOP
