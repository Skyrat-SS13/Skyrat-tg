/obj/item/organ/body_egg/alien_embryo/advance_embryo_stage()

	if(stage >= 6)
		return

	if(owner && owner.stat != DEAD)
		stage++

	if(stage < 6)
		INVOKE_ASYNC(src, .proc/RefreshInfectionImage)
		addtimer(CALLBACK(src, .proc/advance_embryo_stage), growth_time)
