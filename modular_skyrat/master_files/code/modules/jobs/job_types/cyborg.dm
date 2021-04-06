/datum/job/cyborg/after_spawn(mob/living/silicon/robot/R, mob/M)
	R.updatename(M.client)
	R.gender = NEUTER
	for(var/mob/living/silicon/ai/AI in GLOB.silicon_mobs)
		if(AI.z == 3)
			if(!(R.connected_ai))
				R.set_connected_ai(AI)
	R.lawsync()
	R.show_laws()
	
