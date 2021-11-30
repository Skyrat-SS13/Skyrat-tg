/datum/disease/shock
	form = "Condition"
	name = "Shock"
	max_stages = 3
	cure_text = "Trauma"
	cures = list(/datum/reagent/medicine/epinephrine)
	cure_chance = 15
	agent = "Insufficient Blood Flow"
	viable_mobtypes = list(/mob/living/carbon/human)
	permeability_mod = 1
	desc = "If left untreated the subject will suffer from fast heart rate, and ultimately cardiac arrest."
	severity = DISEASE_SEVERITY_MEDIUM
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	visibility_flags = HIDDEN_PANDEMIC
	bypasses_immunity = TRUE

/datum/disease/shock/stage_act(delta_time, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1) //just warning signs
			if(DT_PROB(2.5, delta_time))
				to_chat(affected_mob, span_warning(pick("You feel anxious.", "Your heart feels faster.")))
				affected_mob.add_confusion(rand(2,3))
		if(2) //actual symptoms
			if(DT_PROB(3, delta_time))
				affected_mob.visible_message(span_warning("[affected_mob] starts to look pale."))
			if(DT_PROB(2.5, delta_time))
				to_chat(affected_mob, span_warning(pick("You have trouble breathing!", "You feel like you are going to pass out at any moment!")))
				affected_mob.jitteriness += (rand(6,8))
			if(DT_PROB(1, delta_time))
				to_chat(affected_mob, span_warning(pick("You feel panicky!", "You feel like you're about to have a heart attack!")))
				affected_mob.add_confusion(rand(6,8))
			if(DT_PROB(0.5, delta_time))
				affected_mob.vomit()
		if(3) //the big one: the heart attack
			if(DT_PROB(5, delta_time) && !affected_mob.undergoing_cardiac_arrest() && affected_mob.can_heartattack())
				affected_mob.set_heartattack(TRUE)
				if(affected_mob.stat == CONSCIOUS)
					affected_mob.visible_message(span_userdanger("[affected_mob] clutches at [affected_mob.p_their()] chest as if [affected_mob.p_their()] heart stopped!"))
