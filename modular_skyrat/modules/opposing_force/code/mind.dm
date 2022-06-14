/datum/mind
	var/datum/opposing_force/opposing_force

/datum/mind/Destroy()
	QDEL_NULL(opposing_force)
	return ..()

/mob/verb/opposing_force()
	set name = "Opposing Force"
	set category = "OOC"
	set desc = "View your opposing force panel, or request one."
	// Mind checks
	if(!mind)
		var/fail_message = "You have no mind!"
		if(isobserver(src))
			fail_message += " You have to be in the current round at some point to have one."
		to_chat(src, span_warning(fail_message))
		return

	if(is_banned_from(ckey, BAN_ANTAGONIST))
		to_chat(src, span_warning("You are antagonist banned!"))
		return

	if(is_banned_from(ckey, BAN_OPFOR))
		to_chat(src, span_warning("You are OPFOR banned!"))
		return

	if(!mind.opposing_force)
		var/datum/opposing_force/opposing_force = new(mind)
		mind.opposing_force = opposing_force
		SSopposing_force.new_opfor(opposing_force)
	mind.opposing_force.ui_interact(usr)
