/datum/reagent/medicine/c2/libital/borer_version
	impure_chem = null

/datum/reagent/medicine/c2/lenturi/borer_version
	impure_chem = null

/datum/reagent/drug/methamphetamine_borer
	name = "Methamphetamine"
	description = "Reduces stun times by about 300%, speeds the user up, and allows the user to quickly recover stamina while dealing a small amount of Brain damage. If overdosed the subject will move randomly, laugh randomly, drop items and suffer from Toxin and Brain damage. If addicted the subject will constantly jitter and drool, before becoming dizzy and losing motor control and eventually suffer heavy toxin damage."
	reagent_state = LIQUID
	color = "#FAFAFA"
	overdose_threshold = 40
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/stimulants = 12) //4.8 per 2 seconds

/datum/reagent/drug/methamphetamine_borer/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(DT_PROB(2.5, delta_time))
		to_chat(M, span_notice("[high_message]"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustStun(-40 * REM * delta_time)
	M.AdjustKnockdown(-40 * REM * delta_time)
	M.AdjustUnconscious(-40 * REM * delta_time)
	M.AdjustParalyzed(-40 * REM * delta_time)
	M.AdjustImmobilized(-40 * REM * delta_time)
	M.adjustStaminaLoss(-2 * REM * delta_time, 0)
	M.Jitter(2 * REM * delta_time)
	..()
	. = TRUE
