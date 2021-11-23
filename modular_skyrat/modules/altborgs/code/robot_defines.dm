/mob/living/silicon/robot
	var/robot_resting = FALSE
	var/robot_rest_style = ROBOT_REST_NORMAL
	var/datum/examine_panel/tgui = new() //create the datum

/mob/living/silicon/robot/model/miner/skyrat
	set_model = /obj/item/robot_model/miner/skyrat

/mob/living/silicon/robot/model/butler/skyrat
	set_model = /obj/item/robot_model/service/skyrat
