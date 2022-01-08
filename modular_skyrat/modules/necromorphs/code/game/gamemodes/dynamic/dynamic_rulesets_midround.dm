/datum/dynamic_ruleset/midround/from_ghosts/marker
	name = "Marker"
	antag_datum = /datum/antagonist/marker
	antag_flag = ROLE_NECROMORPH
	enemy_roles = list("Security Officer", "Detective", "Head of Security", "Captain")
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 1
	weight = 4
	cost = 10
	requirements = list(101,101,101,80,60,50,30,20,10,10)
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_ghosts/marker/generate_ruleset_body(mob/applicant)
	var/body = applicant.become_overmind()
	return body
