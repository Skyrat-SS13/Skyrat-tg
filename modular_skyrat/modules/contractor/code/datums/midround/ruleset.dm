/datum/dynamic_ruleset/midround/from_ghosts/contractor
	name = "Drifting Contractors"
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	antag_datum = /datum/antagonist/contractor
	antag_flag = ROLE_DRIFTING_CONTRACTOR
	antag_flag_override = ROLE_DRIFTING_CONTRACTOR
	enemy_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
	)
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 2
	weight = 6
	cost = 10
	minimum_players = 25
	flags = HIGH_IMPACT_RULESET
	/// valid places to spawn
	var/list/spawn_locs = list()

/datum/dynamic_ruleset/midround/from_ghosts/contractor/ready(forced = FALSE)
	if(prob(33))
		required_candidates++
	if (required_candidates > (length(dead_players) + length(list_observers)))
		return FALSE
	for(var/obj/effect/landmark/carpspawn/carp in GLOB.landmarks_list)
		spawn_locs += carp.loc
	if(!length(spawn_locs))
		log_admin("Cannot accept Drifting Contractors ruleset. Couldn't find any carp spawn points.")
		message_admins("Cannot accept Drifting Contractors ruleset. Couldn't find any carp spawn points.")
		return FALSE
	return TRUE

/datum/dynamic_ruleset/midround/from_ghosts/contractor/finish_setup(mob/new_character, index)
	..()
	new_character.forceMove(pick_n_take(spawn_locs))
	new_character.mind.set_assigned_role(SSjob.GetJobType(/datum/job/drifting_contractor))
	new_character.mind.active = TRUE
