/// Chance the traitor gets a martyr objective instead of having to escape alive, as long as all the objectives are martyr compatible.
#define MARTYR_PROB 20

/// Chance the traitor gets a kill objective. If this prob fails, they will get a steal objective instead.
#define KILL_PROB 50
/// If a kill objective is rolled, chance that it is to destroy the AI.
#define DESTROY_AI_PROB(denominator) (100 / denominator)
/// If the destroy AI objective doesn't roll, chance that we'll get a maroon instead. If this prob fails, they will get a generic assassinate objective instead.
#define MAROON_PROB 30
/// If it's a steal objective, this is the chance that it'll be a download research notes objective. Science staff can't get this objective. It can only roll once. If any of these fail, they will get a generic steal objective instead.
#define DOWNLOAD_PROB 15

/datum/antagonist
	//Should this antagonist be allowed to view exploitable information?
	var/view_exploitables = FALSE

/datum/antagonist/heretic
	view_exploitables = TRUE

/datum/antagonist/changeling
	view_exploitables = TRUE

/datum/antagonist/obsessed
	view_exploitables = TRUE

/datum/antagonist/ninja
	view_exploitables = TRUE

/datum/antagonist/wizard
	view_exploitables = TRUE

/datum/antagonist/brother
	view_exploitables = TRUE

/datum/antagonist/malf_ai
	view_exploitables = TRUE

/datum/antagonist/revenant
	view_exploitables = TRUE

/datum/antagonist/traitor
	view_exploitables = TRUE

/datum/antagonist/traitor/proc/forge_single_generic_objective()
	if(prob(KILL_PROB))
		var/list/active_ais = active_ais()
		if(active_ais.len && prob(DESTROY_AI_PROB(GLOB.joined_player_list.len)))
			var/datum/objective/destroy/destroy_objective = new
			destroy_objective.owner = owner
			destroy_objective.find_target()
			objectives += destroy_objective
			return

		if(prob(MAROON_PROB))
			var/datum/objective/maroon/maroon_objective = new
			maroon_objective.owner = owner
			maroon_objective.find_target()
			objectives += maroon_objective
			return

		var/datum/objective/assassinate/kill_objective = new
		kill_objective.owner = owner
		kill_objective.find_target()
		objectives += kill_objective
		return

	if(prob(DOWNLOAD_PROB) && !(locate(/datum/objective/download) in objectives) && !(owner.assigned_role.departments & DEPARTMENT_SCIENCE))
		var/datum/objective/download/download_objective = new
		download_objective.owner = owner
		download_objective.gen_amount_goal()
		objectives += download_objective
		return

	var/datum/objective/steal/steal_objective = new
	steal_objective.owner = owner
	steal_objective.find_target()
	objectives += steal_objective

/datum/antagonist/pirate
	view_exploitables = TRUE //pirates are flexible antags, not strictly bound by their objective. i could see this working

/datum/antagonist/rev/head
	view_exploitables = TRUE //heads only. while all revs having exploitables would be fine, i feel this would complement the "leaders leading the masses" stuff rev naturally makes

/*/datum/antagonist/cortical_borer //come back to borer when its not as new
	view_exploitables = TRUE */

/datum/antagonist/cult //cult is adminbus only... im not sure about this but im doing it anyway
	view_exploitables = TRUE

/*/datum/antagonist/abductor //maybe?
	view_exploitables = TRUE */

#undef MARTYR_PROB
#undef KILL_PROB
#undef DESTROY_AI_PROB
#undef MAROON_PROB
#undef DOWNLOAD_PROB
