//	Modular solution for alternative skins and tipping
/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/tippable/skyrat, \
		tip_time = 3 SECONDS, \
		untip_time = 2 SECONDS, \
		self_right_time = 60 SECONDS, \
		post_tipped_callback = CALLBACK(src, .proc/after_tip_over), \
		post_untipped_callback = CALLBACK(src, .proc/after_righted))

/datum/component/tippable/skyrat/Initialize(
	tip_time = 3 SECONDS,
	untip_time = 1 SECONDS,
	self_right_time = 60 SECONDS,
	datum/callback/pre_tipped_callback,
	datum/callback/post_tipped_callback,
	datum/callback/post_untipped_callback,
)
	qdel(GetComponent(/datum/component/tippable))
	. = ..()

/datum/component/tippable/skyrat/set_tipped_status(mob/living/tipped_mob, new_status = FALSE)
	is_tipped = new_status

	var/mob/living/silicon/robot/robot = tipped_mob

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

////
//	Alternative tipped procs
/mob/living/silicon/robot/after_tip_over(mob/user)
	. = ..()
	var/list/listofroombas = list("zoomba_engi", "zoomba_med", "zoomba_green", "zoomba_miner", "zoomba_jani", "zoomba_sec")
	if(model.cyborg_base_icon in listofroombas)
		roomba_after_tip_over()

/mob/living/silicon/robot/after_righted(mob/user)
	. = ..()
	if(!user) //Did we self-right?
		var/list/listofroombas = list("zoomba_engi", "zoomba_med", "zoomba_green", "zoomba_miner", "zoomba_jani", "zoomba_sec")
		if(model.cyborg_base_icon in listofroombas)
			roomba_after_righted()

	LAZYNULL(vis_contents)


//	Zoomba skinline
/mob/living/silicon/robot/proc/roomba_after_tip_over()
	var/atom/movable/overlay = new /atom/movable
	overlay.name = "[src]'s arm."
	overlay.icon = 'modular_skyrat/modules/altborgs/icons/robot_effect.dmi'
	overlay.layer = ABOVE_MOB_LAYER

	flick("zoomba_flip", overlay) //Start from the start
	vis_contents += overlay

/mob/living/silicon/robot/proc/roomba_after_righted()
	SpinAnimation(3, 1)
	playsound(get_turf(src), 'sound/vehicles/skateboard_ollie.ogg', 50, TRUE) //Roomba does a sick ollie
