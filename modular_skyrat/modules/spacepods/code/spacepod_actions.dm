/obj/spacepod/proc/generate_action_type(actiontype)
	var/datum/action/spacepod/action = new actiontype
	if(!istype(action))
		return
	action.spacepod_target = src
	return action

/obj/spacepod/proc/grant_action_type_to_mob(actiontype, mob/grant_to)
	if(isnull(LAZYACCESS(occupants, grant_to)) || !actiontype)
		return FALSE
	LAZYINITLIST(occupant_actions[grant_to])
	if(occupant_actions[grant_to][actiontype])
		return TRUE
	var/datum/action/action = generate_action_type(actiontype)
	action.Grant(grant_to)
	occupant_actions[grant_to][action.type] = action
	return TRUE

/obj/spacepod/proc/remove_action_type_from_mob(actiontype, mob/take_from)
	if(isnull(LAZYACCESS(occupants, take_from)) || !actiontype)
		return FALSE
	LAZYINITLIST(occupant_actions[take_from])
	if(occupant_actions[take_from][actiontype])
		var/datum/action/action = occupant_actions[take_from][actiontype]
		action.Remove(take_from)
		occupant_actions[take_from] -= actiontype
	return TRUE

/obj/spacepod/proc/grant_passenger_actions(mob/grant_to)
	for(var/action in passenger_actions)
		grant_action_type_to_mob(action, grant_to)

/obj/spacepod/proc/grant_pilot_actions(mob/grant_to)
	for(var/action in pilot_actions)
		grant_action_type_to_mob(action, grant_to)

/obj/spacepod/proc/remove_pilot_actions(mob/take_from)
	for(var/action in pilot_actions)
		remove_action_type_from_mob(action, take_from)

/obj/spacepod/proc/remove_passenger_actions(mob/take_from)
	for(var/action in passenger_actions)
		remove_action_type_from_mob(action, take_from)

/obj/spacepod/proc/cleanup_actions_for_mob(mob/M)
	if(!istype(M))
		return FALSE
	for(var/path in occupant_actions[M])
		stack_trace("Leftover action type [path] in vehicle type [type] for mob type [M.type] - THIS SHOULD NOT BE HAPPENING!")
		var/datum/action/action = occupant_actions[M][path]
		action.Remove(M)
		occupant_actions[M] -= path
	occupant_actions -= M
	return TRUE

// ACTION TYPES

/datum/action/spacepod
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_eject"
	var/obj/spacepod/spacepod_target

/datum/action/spacepod/exit
	name = "Exit pod"

/datum/action/spacepod/exit/Trigger(trigger_flags)
	if(!owner)
		return
	if(!spacepod_target || !(owner in spacepod_target.occupants))
		return
	spacepod_target.exit_pod(owner)

/datum/action/spacepod/controls
	name = "Spacepod controls"
	button_icon_state = "mech_view_stats"

/datum/action/spacepod/controls/Trigger(trigger_flags)
	if(!owner)
		return
	if(!spacepod_target || !(owner in spacepod_target.occupants))
		return
	if(!spacepod_target.pilot)
		to_chat(usr, span_warning("You are not in a pod."))
	else if(owner.incapacitated())
		to_chat(usr, span_warning("You are incapacitated."))
	else
		spacepod_target.ui_interact(owner)

