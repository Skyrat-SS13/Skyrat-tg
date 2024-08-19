/mob/living/silicon
	var/datum/examine_panel/examine_panel = new() //create the datum

/mob/living/silicon/robot
	blocks_emissive = EMISSIVE_BLOCK_NONE
	var/robot_resting = FALSE
	var/robot_rest_style = ROBOT_REST_NORMAL
