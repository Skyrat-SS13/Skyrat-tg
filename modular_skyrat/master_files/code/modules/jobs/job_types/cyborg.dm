/mob/living/silicon/robot/proc/latejoin_find_parent_ai(target_z_level = 3)
	if(connected_ai)
		return
	for(var/mob/living/silicon/ai/AI in GLOB.silicon_mobs)
		if(AI.z == target_z_level)
			set_connected_ai(AI)
			break
	lawsync()
	show_laws()
