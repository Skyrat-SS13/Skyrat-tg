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
