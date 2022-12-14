///Interdyne roles

/datum/team/interdyne
	name = "Interdyne Staff"
	show_roundend_report = FALSE

/datum/antagonist/interdyne
	name = "Interdyne Operative"
	job_rank = ROLE_SYNDICATE
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	prevent_roundtype_conversion = FALSE
	antagpanel_category = "Interdyne"
	count_against_dynamic_roll_chance = FALSE
	var/datum/team/interdyne/interdyne_team

/datum/antagonist/interdyne/create_team(datum/team/team)
	if(team)
		interdyne_team = team
		objectives |= interdyne_team.objectives
	else
		interdyne_team = new

/datum/antagonist/interdyne/get_team()
	return interdyne_team

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	var/datum/team/interdyne/team


///DS-2 roles

/datum/team/ds2
	name = "DS-2 Crew"
	show_roundend_report = FALSE

/datum/antagonist/ds2
	name = "DS-2 Crew"
	job_rank = ROLE_SYNDICATE
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	prevent_roundtype_conversion = FALSE
	antagpanel_category = "DS2"
	count_against_dynamic_roll_chance = FALSE
	var/datum/team/ds2/ds2_team

/datum/antagonist/ds2/create_team(datum/team/team)
	if(team)
		ds2_team = team
		objectives |= ds2_team.objectives
	else
		ds2_team = new

/datum/antagonist/ds2/get_team()
	return ds2_team

/obj/effect/mob_spawn/ghost_role/human/ds2
	var/datum/team/ds2/team
