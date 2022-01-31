/mob/living/silicon/robot/set_typing_indicator(state)
	var/mutable_appearance/indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/typing_indicator.dmi', "borg0", FLY_LAYER)
	typing_indicator = state

	if(typing_indicator)

		//Tallborg stuff
		if((!robot_resting) && model && model.model_features && (R_TRAIT_TALL in model.model_features))
			indicator.pixel_y = 16
		else
			indicator.pixel_y = 0
		add_overlay(indicator)

	else
		regenerate_icons()


//	Modular solution for alternative tipping visuals
/datum/component/tippable/set_tipped_status(mob/living/tipped_mob, new_status = FALSE)
	var/mob/living/silicon/robot/robot = tipped_mob

	is_tipped = new_status

	if(is_tipped)
		ADD_TRAIT(tipped_mob, TRAIT_IMMOBILIZED, TIPPED_OVER)
		if(R_TRAIT_UNIQUETIP in robot.model.model_features)
			robot.icon_state = "[robot.model.cyborg_base_icon]-tipped"
			robot.cut_overlays() //Cut eye-lights
			return

		tipped_mob.transform = turn(tipped_mob.transform, 180)

	else
		REMOVE_TRAIT(tipped_mob, TRAIT_IMMOBILIZED, TIPPED_OVER)
		if(R_TRAIT_UNIQUETIP in robot.model.model_features)
			robot.icon_state = "[robot.model.cyborg_base_icon]"
			robot.regenerate_icons() //Return eye-lights
			return

		tipped_mob.transform = turn(tipped_mob.transform, -180)
