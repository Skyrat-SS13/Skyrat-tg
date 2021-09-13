/mob/living/silicon/robot
	icon = 'modular_skyrat/master_files/icons/mob/robots.dmi'
	var/robot_resting = FALSE
	var/robot_rest_style = ROBOT_REST_NORMAL

/mob/living/silicon/robot/model/miner/skyrat
	set_model = /obj/item/robot_model/miner/skyrat

/mob/living/silicon/robot/model/butler/skyrat
	set_model = /obj/item/robot_model/service/skyrat
