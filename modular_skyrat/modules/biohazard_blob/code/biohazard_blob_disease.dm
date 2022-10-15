/datum/disease/cordyceps
	form = "Disease"
	name = "Cordyceps omniteralis"
	max_stages = 5
	spread_text = "Airborne"
	cure_text = "Neurine & Modafinil"
	cures = list(/datum/reagent/medicine/neurine, /datum/reagent/medicine/modafinil)
	agent = "Fungal Cordycep bacillus"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 20
	desc = "Fungal virus that attacks patient's muscles and brain in an attempt to hijack them. Causes fever, headaches, muscle spasms, and fatigue."
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE

/datum/disease/cordyceps/stage_act(delta_time, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(DT_PROB(2, delta_time))
				affected_mob.emote("twitch")
				to_chat(affected_mob, span_danger("You twitch."))
			if(DT_PROB(2, delta_time))
				to_chat(affected_mob, span_danger("You feel tired."))
			if(DT_PROB(5, delta_time))
				to_chat(affected_mob, span_danger("Your head hurts."))
		if(3,4)
			if(DT_PROB(2, delta_time))
				to_chat(affected_mob, span_userdanger("You see four of everything!"))
				affected_mob.set_timed_status_effect(10 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
			if(DT_PROB(2, delta_time))
				to_chat(affected_mob, span_danger("You suddenly feel exhausted."))
				affected_mob.adjustStaminaLoss(30, FALSE)
			if(DT_PROB(2, delta_time))
				to_chat(affected_mob, span_danger("You feel hot."))
				affected_mob.adjust_bodytemperature(20)
			if(DT_PROB(5, delta_time))
				to_chat(affected_mob, span_danger("You feel air escape from your lungs painfully."))
				affected_mob.adjustOxyLoss(25, FALSE)
				affected_mob.emote("gasp")
		if(5)
			if(DT_PROB(5, delta_time))
				to_chat(affected_mob, span_userdanger("[pick("Your muscles seize!", "You collapse!")]"))
				affected_mob.adjustStaminaLoss(50, FALSE)
				affected_mob.Paralyze(40, FALSE)
				affected_mob.adjustBruteLoss(5) //It's damaging the muscles
			if(DT_PROB(2, delta_time))
				affected_mob.adjustStaminaLoss(100, FALSE)
				affected_mob.visible_message(span_warning("[affected_mob] faints!"), span_userdanger("You surrender yourself and feel at peace..."))
				affected_mob.AdjustSleeping(100)
			if(DT_PROB(5, delta_time))
				to_chat(affected_mob, span_userdanger("You feel your mind relax and your thoughts drift!"))
				affected_mob.adjust_timed_status_effect(10 SECONDS, /datum/status_effect/confusion)
				affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
			if(DT_PROB(10, delta_time))
				to_chat(affected_mob, span_danger("[pick("You feel uncomfortably hot...", "You feel like unzipping your jumpsuit", "You feel like taking off some clothes...")]"))
				affected_mob.adjust_bodytemperature(30)
			if(DT_PROB(5, delta_time))
				affected_mob.vomit(20)

/datum/reagent/cordycepsspores
	name = "Cordycep bacillus microbes"
	description = "Active fungal spores."
	color = "#92D17D"
	chemical_flags = NONE
	taste_description = "slime"
	penetrates_skin = NONE

/datum/reagent/cordycepsspores/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/cordyceps(), FALSE, TRUE)
