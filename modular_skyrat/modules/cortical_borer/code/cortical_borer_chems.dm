/datum/reagent/drug/methamphetamine/borer_version
	name = "Unknown Methamphetamine Isomer"
	overdose_threshold = 40

/datum/reagent/drug/methamphetamine/borer_version/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustStun(-40 * REM * seconds_per_tick)
	M.AdjustKnockdown(-40 * REM * seconds_per_tick)
	M.AdjustUnconscious(-40 * REM * seconds_per_tick)
	M.AdjustParalyzed(-40 * REM * seconds_per_tick)
	M.AdjustImmobilized(-40 * REM * seconds_per_tick)
	M.adjustStaminaLoss(-2 * REM * seconds_per_tick, 0)
	M.set_jitter_if_lower(5 SECONDS)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote(pick("twitch", "shiver"))
	..()
	. = TRUE
