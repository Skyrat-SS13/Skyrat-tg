/*
	This extension is just a holder for proximity triggers, allowing them (or even multiples) to be attached to a holder object
	without needing to make specific variables. Really the only purpose of this is to hold references so that proximity triggers don't get garbage-collected

	The triggers themselves hold all the fancy logic, check proximity_trigger.dm

*/
/datum/extension/proximity_manager
	name = "Step Trigger Manager"
	base_type = /datum/extension/proximity_manager
	flags = EXTENSION_FLAG_IMMEDIATE
	var/list/triggers = list()

//Must pass in a trigger on new, because why wouldn't you
/datum/extension/proximity_manager/New(var/atom/holder, var/datum/proximity_trigger/P)
	.=..()
	triggers.Add(P)

/datum/extension/proximity_manager/Destroy()
	QDEL_NULL_LIST(triggers)
	.=..()