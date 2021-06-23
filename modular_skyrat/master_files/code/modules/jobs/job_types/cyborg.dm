/mob/proc/latejoin_find_parent_ai(target_z_level = 3)
	var/mob/living/silicon/robot/cyborg = src
	if(!istype(cyborg))
		return
	if(cyborg.connected_ai)
		return
	for(var/mob/living/silicon/ai/AI in GLOB.silicon_mobs)
		if(AI.z == target_z_level)
			cyborg.set_connected_ai(AI)
			break
	cyborg.lawsync()
	cyborg.show_laws()
