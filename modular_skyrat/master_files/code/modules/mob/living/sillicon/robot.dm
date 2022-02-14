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
	else
		particles = new /particles/smoke/robot()

/particles/smoke/robot
	width = 100
	height = 100
	spawning = 4
	lifespan = 1.5 SECONDS
	fadein = 0.2 SECONDS
	fade = 1 SECONDS
	velocity = list(0, 0.4, 0)
	position = list(6, 0, 0)
	drift = generator("sphere", 0, 2, NORMAL_RAND)
	friction = 0.2
	gravity = list(0, 0.95)
	grow = 0.05

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
