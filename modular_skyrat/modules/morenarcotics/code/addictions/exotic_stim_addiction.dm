#define STAGE_1_START_CYCLE 101
#define STAGE_1_END_CYCLE 1000
#define STAGE_2_START_CYCLE 1001
#define STAGE_2_END_CYCLE 3000
#define STAGE_3_START_CYCLE 5001 // You get a small period of respite before the worst happens

/datum/addiction/exotic_stimulants
	name = "exotic stimulant"

	addiction_gain_threshold = 200
	addiction_loss_threshold = -100 // Naw son you're addicted to the big leagues now, you ain't getting out of this

// All of this is going to be the same except for the numbers because there's not a decent way to do this :)
/datum/addiction/exotic_stimulants/process_addiction(mob/living/carbon/affected_carbon, delta_time, times_fired)
	var/current_addiction_cycle = LAZYACCESS(affected_carbon.mind.active_addictions, type) //If this is null, we're not addicted
	var/on_drug_of_this_addiction = FALSE
	for(var/datum/reagent/possible_drug as anything in affected_carbon.reagents.reagent_list) //Go through the drugs in our system
		for(var/addiction in possible_drug.addiction_types) //And check all of their addiction types
			if(addiction == type && possible_drug.volume >= addiction_relief_treshold) //If one of them matches, and we have enough of it in our system, we're not losing addiction
				if(current_addiction_cycle)
					end_withdrawal(affected_carbon) //stop the pain
				on_drug_of_this_addiction = TRUE
				break

	var/withdrawal_stage

	switch(current_addiction_cycle)
		if(STAGE_1_START_CYCLE to STAGE_1_END_CYCLE)
			withdrawal_stage = 1
		if(STAGE_2_START_CYCLE to STAGE_2_END_CYCLE)
			withdrawal_stage = 2
		if(STAGE_3_START_CYCLE to INFINITY)
			withdrawal_stage = 3
		else
			withdrawal_stage = 0

	if(!on_drug_of_this_addiction && !HAS_TRAIT(affected_carbon, TRAIT_HOPELESSLY_ADDICTED))
		if(affected_carbon.mind.remove_addiction_points(type, addiction_loss_per_stage[withdrawal_stage + 1] * delta_time)) //If true was returned, we lost the addiction!
			return

	if(!current_addiction_cycle) //Dont do the effects if were not on drugs
		return FALSE

	switch(current_addiction_cycle)
		if(STAGE_1_START_CYCLE)
			withdrawal_enters_stage_1(affected_carbon)
		if(STAGE_2_START_CYCLE)
			withdrawal_enters_stage_2(affected_carbon)
		if(STAGE_3_START_CYCLE)
			withdrawal_enters_stage_3(affected_carbon)

	///One cycle is 2 seconds
	switch(withdrawal_stage)
		if(1)
			withdrawal_stage_1_process(affected_carbon, delta_time)
		if(2)
			withdrawal_stage_2_process(affected_carbon, delta_time)
		if(3)
			withdrawal_stage_3_process(affected_carbon, delta_time)

	LAZYADDASSOC(affected_carbon.mind.active_addictions, type, 1 * delta_time) //Next cycle!

/datum/addiction/exotic_stimulants/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()

	affected_carbon.add_actionspeed_modifier(/datum/actionspeed_modifier/stimulants)

	to_chat(affected_carbon, span_danger("You feel the need to hit some of those exotic stims again..."))

/datum/addiction/exotic_stimulants/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()

	affected_carbon.apply_status_effect(/datum/status_effect/high_blood_pressure)

	to_chat(affected_carbon, span_danger("You're hit with a sudden terrible migraine that just won't go away..."))

/datum/addiction/exotic_stimulants/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, delta_time)
	affected_carbon.set_jitter_if_lower(5 SECONDS * delta_time)
	affected_carbon.set_hallucinations_if_lower(10 SECONDS)

	if(DT_PROB(5, delta_time))
		affected_carbon.add_filter("addiction_phase", 2, phase_filter(8))
		addtimer(CALLBACK(affected_carbon, TYPE_PROC_REF(/atom, remove_filter), "addiction_phase"), 0.5 SECONDS)

/datum/addiction/exotic_stimulants/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()

	affected_carbon.add_movespeed_modifier(/datum/movespeed_modifier/stimulants)

	to_chat(affected_carbon, span_danger("Your heart pounds in your chest, you can feel your blood boiling, what you'd do for another hit to make it all go away again..."))

/datum/addiction/exotic_stimulants/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, delta_time)
	affected_carbon.set_jitter_if_lower(5 SECONDS * delta_time)
	affected_carbon.set_hallucinations_if_lower(10 SECONDS)

	if(DT_PROB(10, delta_time))
		affected_carbon.playsound_local(affected_carbon, 'sound/effects/singlebeat.ogg', 100, TRUE)
		flash_color(affected_carbon, flash_color = "#ac3737", flash_time = 3 SECONDS)

	if(DT_PROB(10, delta_time))
		affected_carbon.add_filter("addiction_phase", 2, phase_filter(8))
		addtimer(CALLBACK(affected_carbon, TYPE_PROC_REF(/atom, remove_filter), "addiction_phase"), 0.5 SECONDS)

	if(DT_PROB(5, delta_time)) // You will eventually die to max addiction
		affected_carbon.adjustOrganLoss(
			pick(ORGAN_SLOT_BRAIN,ORGAN_SLOT_APPENDIX,ORGAN_SLOT_LUNGS,ORGAN_SLOT_HEART,ORGAN_SLOT_LIVER,ORGAN_SLOT_STOMACH),
			5,
		)

/datum/addiction/exotic_stimulants/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()

	affected_carbon.remove_actionspeed_modifier(ACTIONSPEED_ID_STIMULANTS)
	affected_carbon.remove_status_effect(/datum/status_effect/woozy)
	affected_carbon.remove_status_effect(/datum/status_effect/high_blood_pressure)
	affected_carbon.remove_movespeed_modifier(MOVESPEED_ID_STIMULANTS)

#undef STAGE_1_START_CYCLE
#undef STAGE_1_END_CYCLE
#undef STAGE_2_START_CYCLE
#undef STAGE_2_END_CYCLE
#undef STAGE_3_START_CYCLE
