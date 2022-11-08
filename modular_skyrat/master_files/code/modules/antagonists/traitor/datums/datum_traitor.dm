/// Progresionless traitor
/datum/antagonist/traitor
	/// If the traitor should have progression enabled or not on their uplink
	var/progression_enabled = FALSE
	/// The final objective the traitor has to accomplish, be it escaping, hijacking, or just martyrdom.
	var/datum/objective/ending_objective

/datum/antagonist/traitor/on_gain()
	if(give_objectives)
		forge_traitor_objectives()
		forge_ending_objective()
	return ..()
