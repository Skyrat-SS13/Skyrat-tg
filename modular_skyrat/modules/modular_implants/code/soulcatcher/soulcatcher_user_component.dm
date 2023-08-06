/// The component given to soulcatcher inhabitants
/datum/component/soulcatcher_user
	/// Is the action to control the HUD given to the mob?
	var/hud_action_given = TRUE
	/// The coresponding action used to pull up the HUD
	var/datum/action/innate/soulcatcher_user/soulcatcher_action
	/// Is the action to leave given to the mob?
	var/leave_action_given = TRUE
	/// The coresponding action used to leave the soulcatcher
	var/datum/action/innate/leave_soulcatcher/leave_action

/datum/component/soulcatcher_user/New()
	. = ..()
	var/mob/living/soulcatcher_soul/parent_soul = parent
	if(!istype(parent_soul))
		return COMPONENT_INCOMPATIBLE

	if(hud_action_given)
		soulcatcher_action = new
		soulcatcher_action.Grant(parent_soul)
		soulcatcher_action.soulcatcher_user_component = WEAKREF(src)

	if(leave_action_given)
		leave_action = new
		leave_action.Grant(parent_soul)

	return TRUE


/datum/component/soulcatcher_user/Destroy(force, silent)
	if(soulcatcher_action)
		qdel(soulcatcher_action)

	if(leave_action)
		qdel(leave_action)

	return ..()
