// Allows silicons/cyborgs to have unique icons when tipped over
// Originally added by Skyrat-tg PR #10894
/datum/component/tippable/set_tipped_status(mob/living/tipped_mob, new_status = FALSE)
	// Defer to TG code if the mob isn't a silicon.
	if (!iscyborg(tipped_mob))
		return ..()
	is_tipped = new_status
	var/mob/living/silicon/robot/robot = tipped_mob
	if(is_tipped)
		ADD_TRAIT(robot, TRAIT_IMMOBILIZED, TIPPED_OVER)
		if(R_TRAIT_UNIQUETIP in robot.model.model_features)
			robot.icon_state = "[robot.model.cyborg_base_icon]-tipped"
			robot.cut_overlays() // Cut eye-lights
			return
		robot.transform = turn(robot.transform, 180)
	else
		REMOVE_TRAIT(robot, TRAIT_IMMOBILIZED, TIPPED_OVER)
		if(R_TRAIT_UNIQUETIP in robot.model.model_features)
			robot.icon_state = "[robot.model.cyborg_base_icon]"
			robot.regenerate_icons() // Return eye-lights
			return
		robot.transform = turn(robot.transform, -180)
