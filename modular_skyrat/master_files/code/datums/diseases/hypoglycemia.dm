/datum/disease/hypoglycemia
	form = "Condition"
	name = "Hypoglycemic Shock"
	max_stages = 3
	stage_prob = 0
	cure_text = "Sugar"
	cures = list(/datum/reagent/consumable/sugar)
	cure_chance = 10
	agent = "Diabetes"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "If left untreated the subject will suffer from lethargy, dizziness and periodic loss of conciousness."
	severity = DISEASE_SEVERITY_HARMFUL
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	spread_text = "Organ failure"
	visibility_flags = HIDDEN_PANDEMIC
	bypasses_immunity = TRUE
	var/stage_time = 300 // Seconds


/datum/disease/hypoglycemia/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	// Advance stage every 5 minutes.
	if(stage < 3)
		stage_time -= seconds_per_tick
		if(stage_time < 1)
			stage_time = 300
			update_stage(stage + 1)

	switch(stage)
		if(1)
			// Symptoms at stage 1 are minor.
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_warning(pick("You feel lethargic.", "You feel lightheaded.", "You feel a cold sweat form.")))
				affected_mob.adjustStaminaLoss(20, FALSE)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_warning("You feel dizzy."))
				affected_mob.set_dizzy_if_lower(10 SECONDS)
		if(2, 3)
			// Symptoms become stage 2 (annoying) after 5 minutes.
			// Symptoms become stage 3 (deadly) after 10 minutes.
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_warning("You feel like you are going to pass out at any moment!"))
				affected_mob.set_drowsiness_if_lower(20 SECONDS)
				affected_mob.adjustStaminaLoss(40, FALSE)
			if(SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_warning("You feel your heart practically beating out of your chest!"))
				affected_mob.set_jitter_if_lower(20 SECONDS)
				affected_mob.set_confusion_if_lower(20 SECONDS)
				affected_mob.set_slurring_if_lower(20 SECONDS)
			if(SPT_PROB(7, seconds_per_tick))
				to_chat(affected_mob, span_warning("You feel really dizzy!"))
				affected_mob.set_dizzy_if_lower(20 SECONDS)
			if(stage == 3)
				// At stage 3, get brain damage and pass out.
				if(SPT_PROB(2.5, seconds_per_tick))
					to_chat(affected_mob, span_warning("You feel pain shoot down your arms and legs!"))
					affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2 * seconds_per_tick)
				else if(SPT_PROB(2.5, seconds_per_tick))
					affected_mob.Unconscious(12 SECONDS)
