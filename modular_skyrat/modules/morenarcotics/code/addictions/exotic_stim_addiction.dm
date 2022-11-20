/datum/addiction/exotic_stimulants
	name = "exotic stimulant"

	addiction_gain_threshold = 200
	addiction_loss_threshold = -100 // Naw son you're addicted to the big leagues now, you ain't getting out of this

	withdrawal_stage_messages = list(
		"You feel like you just can't quite work the same without those special stims...",
		"You ache all over, your body feels like its falling apart, maybe it is, if only you had those stims around to juice you up again...",
		"You get a sudden splitting migraine, your blood feels like its boiling, your heart pounds wildly in your chest!"
	)

/datum/addiction/exotic_stimulants/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.add_actionspeed_modifier(/datum/actionspeed_modifier/stimulants)

/datum/addiction/exotic_stimulants/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/woozy)
	affected_carbon.apply_status_effect(/datum/status_effect/high_blood_pressure)

/datum/addiction/exotic_stimulants/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, delta_time)
	. = ..()

	affected_carbon.set_jitter_if_lower(5 SECONDS * delta_time)
	affected_carbon.set_hallucinations_if_lower(10 SECONDS)

	if(DT_PROB(5, delta_time))
		affected_carbon.add_filter("addiction_phase", 2, phase_filter(8))
		addtimer(CALLBACK(affected_carbon, TYPE_PROC_REF(/atom, remove_filter), "addiction_phase"), 0.5 SECONDS)

/datum/addiction/exotic_stimulants/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.add_movespeed_modifier(/datum/movespeed_modifier/stimulants)

/datum/addiction/exotic_stimulants/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, delta_time)
	. = ..()

	affected_carbon.set_jitter_if_lower(5 SECONDS * delta_time)
	affected_carbon.set_hallucinations_if_lower(10 SECONDS)

	if(DT_PROB(10, delta_time))
		affected_carbon.playsound_local(affected_carbon, 'sound/effects/singlebeat.ogg', 100, TRUE)
		flash_color(affected_carbon, flash_color = "#ac3737", flash_time = 3 SECONDS)

/datum/addiction/exotic_stimulants/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_actionspeed_modifier(ACTIONSPEED_ID_STIMULANTS)
	affected_carbon.remove_status_effect(/datum/status_effect/woozy)
	affected_carbon.remove_status_effect(/datum/status_effect/high_blood_pressure)
	affected_carbon.remove_movespeed_modifier(MOVESPEED_ID_STIMULANTS)
