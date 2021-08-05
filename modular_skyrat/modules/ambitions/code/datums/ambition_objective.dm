GLOBAL_LIST_INIT(ambition_objectives, create_objective_instances())
GLOBAL_LIST_EMPTY(ambition_objectives_all)

/proc/create_objective_instances()
	for(var/spath in subtypesof(/datum/ambition_objective))
		var/datum/ambition_objective/sub = spath
		if(sub == initial(sub.abstract))
			continue
		var/sub_instance = new sub()
		LAZYADD(GLOB.ambition_objectives[initial(sub.abstract)], sub_instance)
		LAZYADD(GLOB.ambition_objectives_all, sub_instance)

/datum/ambition_objective
	var/name = "BROKEN OBJECTIVE"
	var/desc = "BROKEN OBJECTIVE"
	var/key = "DEF"
	var/intensity = INTENSITY_STEALTH
	/// A type list of antags who are allowed to use this objective; if its TRUE any antag can
	var/list/allowed_antag_types = list()
	var/abstract = /datum/ambition_objective

/// This proc is run when an objective is initially selected, the objective should do all calculations and assign values here.
/// If the proc is unable to do anything it needs to do to ensure the objective works correctly, it should return FALSE.
/datum/ambition_objective/proc/on_select(datum/ambitions/parent)
	return TRUE

/// The client has deselected us, either because it wasn't approved or they changed their mind.
/datum/ambition_objective/proc/on_deselect(datum/ambitions/parent)
	return

/// This proc is run when an objective is approved.
/datum/ambition_objective/proc/on_approved(datum/ambitions/parent)
	return

/// Is this objective allowed to be selected; this is the proc that ensures only valid objectives are shown to potential clients.
/// IF YOU OVERRIDE THIS DO NOT DO ANYTHING FANCY, IT IS CALLED EVERY UI UPDATE.
/datum/ambition_objective/proc/allow_select(datum/ambitions/parent, list/all_objectives)
	SHOULD_CALL_PARENT(TRUE)
	for(var/datum/antagonist/antag as anything in parent.owner_antags)
		if(is_type_in_list(antag, allowed_antag_types))
			return TRUE
	return FALSE

/datum/ambition_objective/proc/calculate_completion(datum/ambitions/parent)
	return

/datum/ambition_objective/proc/update_completion(datum/ambitions/parent)
	var/completion = calculate_completion(parent)
	if(completion == parent.objectives[src])
		return

	if(completion)
		on_completion(parent)
		return

	on_uncompletion(parent)

/datum/ambition_objective/proc/on_completion(datum/ambitions/parent)
	to_chat(parent.owner.current, span_green("Ambition Objective [name] completed!"))

/datum/ambition_objective/proc/on_uncompletion(datum/ambitions/parent)
	to_chat(parent.owner.current, span_red("Ambition Objective [name] no longer complete."))

/datum/ambition_objective/cult
	abstract = /datum/ambition_objective/cult
	allowed_antag_types = list(/datum/antagonist/cult)

/datum/ambition_objective/traitor
	abstract = /datum/ambition_objective/traitor
	allowed_antag_types = list(/datum/antagonist/traitor)

/datum/ambition_objective/malf
	abstract = /datum/ambition_objective/malf
	allowed_antag_types = list(/datum/antagonist/malf_ai)

/datum/ambition_objective/changeling
	abstract = /datum/ambition_objective/changeling
	allowed_antag_types = list(/datum/antagonist/changeling)

/datum/ambition_objective/wizard
	abstract = /datum/ambition_objective/wizard
	allowed_antag_types = list(/datum/antagonist/wizard)

/datum/ambition_objective/ninja
	abstract = /datum/ambition_objective/ninja
	allowed_antag_types = list(/datum/antagonist/ninja)

/datum/ambition_objective/rev
	abstract = /datum/ambition_objective/rev
	allowed_antag_types = list(/datum/antagonist/rev/head)

/datum/ambition_objective/gang
	abstract = /datum/ambition_objective/gang
	allowed_antag_types = list(/datum/antagonist/gang)

/datum/ambition_objective/heretic
	abstract = /datum/ambition_objective/heretic
	allowed_antag_types = list(/datum/antagonist/heretic)

/datum/ambition_objective/brother
	abstract = /datum/ambition_objective/brother
	allowed_antag_types = list(/datum/antagonist/brother)

/datum/ambition_objective/generic
	abstract = /datum/ambition_objective/generic
	allowed_antag_types = TRUE

///^^VV^^VV^^VV^^VV^^VV^^///
/// AMBITION  OBJECTIVES ///
///VV^^VV^^VV^^VV^^VV^^VV///

/// GENERIC /// TODO

/datum/ambition_objective/generic/steal
	abstract = /datum/ambition_objective/generic/steal

/datum/ambition_objective/generic/steal/on_select(datum/ambitions/parent)
	if(locate(item) in world)
		return TRUE
	return FALSE

/datum/ambition_objective/generic/steal/calculate_completion(datum/ambitions/parent)
	if(locate(item) in parent.owner.current)
		return TRUE
	return FALSE

/// TRAITOR /// TODO
/// BROTHER /// TODO
/// HERETIC /// TODO
/// CHNGLNG /// TODO
/// GANG    /// TODO
/// CULT    /// TODO
/// WIZARD  /// TODO
/// MALF    /// TODO
/// REVHEAD /// TODO
/// NINJUA  /// TODO
