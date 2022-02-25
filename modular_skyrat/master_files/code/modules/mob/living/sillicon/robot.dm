////
//	Typing indicator icon change
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


////
//	Smoke particle effect for heavy-duty cyborgs
/datum/component/robot_smoke

/datum/component/robot_smoke/RegisterWithParent()
	add_verb(parent, /mob/living/silicon/robot/proc/toggle_smoke)

/datum/component/robot_smoke/UnregisterFromParent()
	remove_verb(parent, /mob/living/silicon/robot/proc/toggle_smoke)

/datum/component/robot_smoke/Destroy()
	return ..()

/mob/living/silicon/robot/proc/toggle_smoke()
	set name = "Toggle smoke"
	set category = "AI Commands"

	if(particles)
		QDEL_NULL(particles)
	else if (!stat && !robot_resting)
		particles = new /particles/smoke/robot()

/mob/living/silicon/robot/death()
	. = ..()
	if(GetComponent(/datum/component/robot_smoke))
		QDEL_NULL(particles)

/mob/living/silicon/robot/robot_lay_down()
	. = ..()

	if(GetComponent(/datum/component/robot_smoke))
		if(robot_resting)
			QDEL_NULL(particles)
		else
			return

// The smoke
/particles/smoke/robot
	spawning = 1
	lifespan = 1 SECONDS
	fade = 0.5 SECONDS
	velocity = list(0, 0.2, 0)
	position = list(0, 12, 0)
	drift = generator("sphere", -2, 2, NORMAL_RAND)
	friction = 0.35
	scale = 0.5


////
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
