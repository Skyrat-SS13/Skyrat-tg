GLOBAL_LIST_INIT(ambition_objectives, create_objective_instances())

/proc/create_objective_instances()
	for(var/spath in subtypesof(/datum/ambition_objective))
		var/datum/ambition_objective/sub = spath
		if(istype(sub, initial(sub.abstract))
			continue
		LAZYADD(GLOB.ambitions_objectives[initial(sub.abstract)], new sub())

/datum/ambition_objective
	var/name = "BROKEN OBJECTIVE"
	var/desc = "BROKEN OBJECTIVE"
	var/key = "DEF"
	var/intensity = INTENSITY_STEALTH
	var/list/allowed_antag_types = list()
	var/abstract = /datum/ambition_objective

/datum/ambition_objective/proc/on_select(client/parent)
	return

/datum/ambition_objective/proc/on_approved(client/parent)
	return

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
	allowed_antag_types = list(/datum/antagonist/rev)

/datum/ambition_objective/gang
	abstract = /datum/ambition_objective/gang
	allowed_antag_types = list(/datum/antagonist/gang)

/datum/ambition_objective/heretic
	abstract = /datum/ambition_objective/heretic
	allowed_antag_types = list(/datum/antagonist/heretic)

/datum/ambition_objective/brother
	abstract = /datum/ambition_objective/brother
	allowed_antag_types = list(/datum/antagonist/brother)
