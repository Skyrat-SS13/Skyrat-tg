/datum/reagent/drug/cocaine
	name = "Cocaine"
	description = "A powerful stimulant extracted from coca leaves. Reduces stun times, but causes drowsiness and severe brain damage if overdosed."
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
	ph = 9
	taste_description = "lemons"
	addiction_types = list(/datum/addiction/stimulants = 14) //5.6 per 2 seconds

/datum/reagent/drug/cocaine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(DT_PROB(2.5, delta_time))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustStun(-15 * REM * delta_time)
	M.AdjustKnockdown(-15 * REM * delta_time)
	M.AdjustUnconscious(-15 * REM * delta_time)
	M.AdjustImmobilized(-15 * REM * delta_time)
	M.AdjustParalyzed(-15 * REM * delta_time)
	M.adjustStaminaLoss(-2 * REM * delta_time, 0)
	if(DT_PROB(2.5, delta_time))
		M.emote("shiver")
	..()
	. = TRUE

/datum/reagent/drug/cocaine/overdose_process(mob/living/M, delta_time, times_fired)
	M.adjustToxLoss((rand(10, 50) / 10) * REM * delta_time, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1 * REM * delta_time)
	M.Jitter(2 * REM * delta_time)
	M.drowsyness += 2 * REM * normalise_creation_purity() * delta_time
	if(DT_PROB(2.5, delta_time))
		M.emote(pick("twitch","drool"))
	..()
	. = TRUE