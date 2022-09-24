/// Chance that the traitor could roll hijack if the pop limit is met.
#define HIJACK_PROB 10
/// Hijack is unavailable as a random objective below this player count.
#define HIJACK_MIN_PLAYERS 50

/// Chance the traitor gets a martyr objective instead of having to escape alive, as long as all the objectives are martyr compatible.
#define MARTYR_PROB 20

/// Chance the traitor gets a kill objective. If this prob fails, they will get a steal objective instead.
#define KILL_PROB 50
/// If a kill objective is rolled, chance that it is to destroy the AI.
#define DESTROY_AI_PROB(denominator) (100 / denominator)
/// If the destroy AI objective doesn't roll, chance that we'll get a maroon instead. If this prob fails, they will get a generic assassinate objective instead.
#define MAROON_PROB 30

/// Generates a complete set of traitor objectives up to the traitor objective limit, including non-generic objectives such as martyr and hijack.
/datum/antagonist/traitor/saboteur/forge_traitor_objectives()
	objectives.Cut()

	var/objective_count = 0

	if((length(GLOB.joined_player_list) >= HIJACK_MIN_PLAYERS) && prob(HIJACK_PROB))
		is_hijacker = TRUE
		objective_count++

	var/objective_limit = CONFIG_GET(number/traitor_objectives_amount)

	// for(in...to) loops iterate inclusively, so to reach objective_limit we need to loop to objective_limit - 1
	// This does not give them 1 fewer objectives than intended.
	for(var/i in objective_count to objective_limit - 1)
		objectives += forge_single_generic_objective()


/// Adds a generic kill or steal objective to this datum's objective list.
/datum/antagonist/traitor/saboteur/proc/forge_single_generic_objective()
	if(prob(KILL_PROB))
		var/list/active_ais = active_ais()
		if(length(active_ais) && prob(DESTROY_AI_PROB(length(GLOB.joined_player_list))))
			var/datum/objective/destroy/destroy_objective = new
			destroy_objective.owner = owner
			destroy_objective.find_target()
			return destroy_objective

		if(prob(MAROON_PROB))
			var/datum/objective/maroon/maroon_objective = new
			maroon_objective.owner = owner
			maroon_objective.find_target()
			return maroon_objective

		var/datum/objective/assassinate/kill_objective = new
		kill_objective.owner = owner
		kill_objective.find_target()
		return kill_objective

	var/datum/objective/steal/steal_objective = new
	steal_objective.owner = owner
	steal_objective.find_target()
	return steal_objective

/**
 * ## forge_ending_objective
 *
 * Forges the endgame objective and adds it to this datum's objective list.
 */
/datum/antagonist/traitor/saboteur/proc/forge_ending_objective()
	if(is_hijacker)
		ending_objective = new /datum/objective/hijack
		ending_objective.owner = owner
		objectives += ending_objective
		return

	var/martyr_compatibility = TRUE

	for(var/datum/objective/traitor_objective in objectives)
		if(!traitor_objective.martyr_compatible)
			martyr_compatibility = FALSE
			break

	if(martyr_compatibility && prob(MARTYR_PROB))
		ending_objective = new /datum/objective/martyr
		ending_objective.owner = owner
		objectives += ending_objective
		return

	ending_objective = new /datum/objective/escape
	ending_objective.owner = owner
	objectives += ending_objective

/// Forges a single escape objective and adds it to this datum's objective list.
/datum/antagonist/traitor/saboteur/proc/forge_escape_objective()
	var/is_martyr = prob(MARTYR_PROB)
	var/martyr_compatibility = TRUE

	for(var/datum/objective/traitor_objective in objectives)
		if(!traitor_objective.martyr_compatible)
			martyr_compatibility = FALSE
			break

	if(martyr_compatibility && is_martyr)
		var/datum/objective/martyr/martyr_objective = new
		martyr_objective.owner = owner
		objectives += martyr_objective
		return

	var/datum/objective/escape/escape_objective = new
	escape_objective.owner = owner
	objectives += escape_objective


#undef HIJACK_PROB
#undef HIJACK_MIN_PLAYERS
#undef MARTYR_PROB
#undef KILL_PROB
#undef DESTROY_AI_PROB
#undef MAROON_PROB
