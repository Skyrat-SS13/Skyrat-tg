// Alters nicotine withdrawal
/datum/addiction/nicotine
	name = "nicotine"
	withdrawal_stage_messages = list("Feel like having a smoke...", "I really need a smoke now...", "I can't take it, I really need a smoke now!")

	addiction_relief_treshold = MIN_NICOTINE_ADDICTION_REAGENT_AMOUNT
	medium_withdrawal_moodlet = /datum/mood_event/nicotine_withdrawal_moderate
	severe_withdrawal_moodlet = /datum/mood_event/nicotine_withdrawal_severe

/datum/addiction/nicotine/proc/trigger_random_side_effect(mob/living/carbon/affected_carbon, seconds_per_tick, strength = 1)
	switch(rand(1, 4))
		if(1)
			if(!HAS_TRAIT(affected_carbon, TRAIT_NOHUNGER))
				affected_carbon.adjust_nutrition(-10 * REM * seconds_per_tick)
		if(2)
			to_chat(affected_carbon, span_warning("Your head hurts."))
			affected_carbon.adjustStaminaLoss(50 * REM * seconds_per_tick)
		if(3)
			if(strength >= 2)
				to_chat(affected_carbon, span_warning("You feel a little dizzy."))
				affected_carbon.set_dizzy(strength * 6 SECONDS)
		if(4)
			if(strength >= 2)
				to_chat(affected_carbon, span_warning("You feel tired."))
				affected_carbon.adjustStaminaLoss(75 * REM * seconds_per_tick)

/datum/addiction/nicotine/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	to_chat(affected_carbon, span_danger("[withdrawal_stage_messages[1]]"))

/datum/addiction/nicotine/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	to_chat(affected_carbon, span_danger("[withdrawal_stage_messages[2]]"))

/datum/addiction/nicotine/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	to_chat(affected_carbon, span_danger("[withdrawal_stage_messages[3]]"))

/datum/addiction/nicotine/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	if(SPT_PROB(0.3, seconds_per_tick))
		to_chat(affected_carbon, span_danger("[withdrawal_stage_messages[1]]"))

/datum/addiction/nicotine/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	if(SPT_PROB(0.5, seconds_per_tick))
		trigger_random_side_effect(affected_carbon, seconds_per_tick, 1)
	if(SPT_PROB(0.5, seconds_per_tick))
		to_chat(affected_carbon, span_danger("[withdrawal_stage_messages[2]]"))

/datum/addiction/nicotine/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	if(SPT_PROB(0.7, seconds_per_tick))
		trigger_random_side_effect(affected_carbon, seconds_per_tick, 2)
	if(SPT_PROB(0.7, seconds_per_tick))
		to_chat(affected_carbon, span_danger("[withdrawal_stage_messages[3]]"))
