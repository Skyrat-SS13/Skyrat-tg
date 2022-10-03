/atom/movable/screen/alert/status_effect/agent_pinpointer/away_objective
	name = "Objective Locator"
	desc = "Points to your next objective."

/datum/status_effect/agent_pinpointer/away_objective
	id = "agent_pinpointer" //this stays the same because it's in the same loc as the agent pinpointer
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/away_objective
	minimum_range = 3
	range_fuzz_factor = 1
	range_mid = 5
	range_far = 10

/datum/status_effect/agent_pinpointer/away_objective/scan_for_target()
	return
