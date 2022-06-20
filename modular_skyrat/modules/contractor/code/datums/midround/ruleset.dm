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
	requirements = list(101,101,101,80,60,50,30,20,10,10)
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
		log_admin("Cannot accept Drifting Contractor ruleset. Couldn't find any carp spawn points.")
		message_admins("Cannot accept Drifting Contractor ruleset. Couldn't find any carp spawn points.")
		return FALSE
	return ..()


/datum/dynamic_ruleset/midround/from_ghosts/contractor/generate_ruleset_body(mob/applicant)
	var/mob/living/carbon/human/operative = new(pick(spawn_locs))
	operative.dna.remove_all_mutations()
	operative.randomize_human_appearance(~RANDOMIZE_SPECIES)
	operative.dna.update_dna_identity()
	return operative

/datum/dynamic_ruleset/midround/from_ghosts/contractor/finish_setup(mob/new_character, index)
	if(!usr.mind)
		usr.mind = new /datum/mind(usr.key)
	usr.mind.transfer_to(new_character)
	new_character.ckey = usr.ckey
	..()
	new_character.mind.set_assigned_role(SSjob.GetJobType(/datum/job/drifting_contractor))
	new_character.mind.special_role = ROLE_DRIFTING_CONTRACTOR
	new_character.mind.active = TRUE
