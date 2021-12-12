/proc/KillEveryoneOnZLevel(level)
	if(!level)
		return
	for(var/mob/living/iterated_mob in GLOB.mob_living_list)
		if(iterated_mob.loc.z == level)
			iterated_mob.flash_act(100, TRUE, TRUE)
			to_chat(iterated_mob, span_userdanger("You feel your skin prickle with heat as you're ripped atom from atom in the raging inferno of a nuclear blast. Your last thought is 'Oh fuck.'"))
			iterated_mob.emote("scream")
			iterated_mob.gib()
