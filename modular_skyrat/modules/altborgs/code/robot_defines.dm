/mob/living/silicon/robot
	icon = 'modular_skyrat/master_files/icons/mob/robots.dmi'
	var/robot_resting = FALSE
	var/robot_rest_style = ROBOT_REST_NORMAL
	var/datum/examine_panel/tgui = new() //create the datum

/obj/item/robot_model
	cyborg_icon_file = 'modular_skyrat/master_files/icons/mob/robots.dmi'
