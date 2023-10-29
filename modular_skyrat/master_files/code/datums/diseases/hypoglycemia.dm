/datum/disease/hypoglycemia
	form = "Condition"
	name = "Hypoglycemic Shock"
	max_stages = 3
	stage_prob = 0
	cure_text = "Trauma"
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
	var/stage_time = 5 MINUTES


/datum/disease/hypoglycemia/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	if(stage < 3)
		stage_time -= seconds_per_tick
		if(stage_time < 1)
			stage_time = 5 MINUTES
			update_stage(stage + 1)

	if(stage == 1)
		if(SPT_PROB(2.5, seconds_per_tick))
			to_chat(affected_mob, span_warning(pick("You feel lightheaded.", "You feel lethargic.")))
			
	if(SPT_PROB(1.5, seconds_per_tick))
		affected_mob.adjust_confusion(8 SECONDS)
		affected_mob.adjustStaminaLoss(40, FALSE)

	if(stage > 1)
			// Hypoglycemia symptoms become major after 5 minutes.
		if(SPT_PROB(5, seconds_per_tick))
			affected_mob.Unconscious(20 SECONDS)
		if(SPT_PROB(10, seconds_per_tick))
			affected_mob.adjust_slurring(14 SECONDS)
		if(SPT_PROB(7, seconds_per_tick))
			affected_mob.set_dizzy_if_lower(20 SECONDS)
		if(SPT_PROB(2.5, seconds_per_tick))
			to_chat(affected_mob, span_warning(pick("You feel pain shoot down your legs!", "You feel like you are going to pass out at any moment.", "You feel really dizzy.")))

	if(stage == 3)
		affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2 * seconds_per_tick)
