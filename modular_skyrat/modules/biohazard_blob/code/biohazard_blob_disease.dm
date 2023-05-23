/datum/disease/cryptococcus
	name = "Cryptococcal meningitis"
	max_stages = 4
	stage_prob = 1.75
	spread_text = "Airborne"
	spreading_modifier = 0.75
	cure_text = "Haloperidol"
	cures = list(/datum/reagent/medicine/haloperidol)
	agent = "Cryptococcus gattii fungus"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 25
	desc = "Fungal infection that attacks patient's muscles and brain in an attempt to hijack them. Causes fever, headaches, muscle spasms, and fatigue."
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE

/datum/disease/cryptococcus/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your brain feels fuzzy. That's not right."))
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your head hurts. Were the ceiling tiles always moving like that?"))
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.emote("twitch")
				to_chat(affected_mob, span_danger("You twitch involuntarily. That's not right."))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("You sniff, smelling green slime. Does green have a smell?"))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("Your head hurts. Were the ceiling tiles always moving like that?"))
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("You see four of everything!"))
				affected_mob.set_dizzy_if_lower(10 SECONDS)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("You suddenly feel exhausted. Your movements are starting to feel stiff. Something seriously isn't right..."))
				affected_mob.adjustStaminaLoss(30, FALSE)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("You feel hot. Very hot. Your muscles feel okay for a moment, but the pain returns."))
				affected_mob.adjust_bodytemperature(20)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("You feel air escape from your lungs painfully. You didn't intend to exhale, they seem to be seizing up on their own."))
				affected_mob.adjustOxyLoss(25, FALSE)
				affected_mob.emote("gasp")
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("[pick("Your muscles seize!", "You collapse!")]"))
				affected_mob.adjustStaminaLoss(50, FALSE)
				affected_mob.Paralyze(40, FALSE)
				affected_mob.adjustBruteLoss(5) //It's damaging the muscles
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjustStaminaLoss(100, FALSE)
				affected_mob.visible_message(span_warning("[affected_mob] faints!"), span_userdanger("You surrender yourself and feel at peace..."))
				affected_mob.AdjustSleeping(100)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("You feel your mind relax and your thoughts drift!"))
				affected_mob.adjust_confusion(10 SECONDS)
				affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
			if(SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("You feel uncomfortably hot...", "You feel like unzipping your jumpsuit", "You feel like taking off some clothes...")]"))
				affected_mob.adjust_bodytemperature(30)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.vomit(20)

/datum/reagent/cryptococcus_spores
	name = "Cryptococcus gattii microbes"
	description = "Active fungal spores."
	color = "#92D17D"
	chemical_flags = NONE
	taste_description = "slime"
	penetrates_skin = NONE

/datum/reagent/cryptococcus_spores/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/cryptococcus(), FALSE, TRUE)
