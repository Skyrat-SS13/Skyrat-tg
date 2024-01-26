/// This type of NIFSoft grants the user an action when active.
/datum/nifsoft/action_granter
	active_mode = TRUE
	activation_cost = 10
	active_cost = 1
	/// What is the path of the action that we want to grant?
	var/action_to_grant = /datum/action/innate
	/// What action are we giving the user of the NIFSoft?
	var/datum/action/innate/granted_action

/datum/nifsoft/action_granter/activate()
	. = ..()
	if(active)
		granted_action = new action_to_grant(linked_mob)
		granted_action.Grant(linked_mob)
		return

	if(granted_action)
		granted_action.Remove(linked_mob)

/datum/nifsoft/action_granter/Destroy()
	if(granted_action)
		QDEL_NULL(granted_action)
	return ..()


