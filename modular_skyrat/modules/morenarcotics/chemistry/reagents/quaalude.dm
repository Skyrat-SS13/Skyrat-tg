/datum/reagent/drug/quaalude
	name = "Quaalude"
	description = "Relaxes the user, putting them in a hypnotic, drugged state. If overdosed it will cause Brain damage and cause the user to impulsively shout about quaaludes."
	reagent_state = LIQUID
	color = "#FA00C8"
	overdose_threshold = 20
	ph = 8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	//NON NARCOTIC, NON ADDICTIVE!!

/datum/reagent/drug/quaalude/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/high_message = pick("You feel relaxed.", "You feel like you're on the moon.", "You feel like you could walk 20 miles for a quaalude.")
	if(DT_PROB(2.5, delta_time))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	M.set_drugginess(15 * REM * delta_time)
	M.adjustStaminaLoss(-5 * REM * delta_time, 0)
	if(DT_PROB(3.5, delta_time))
		M.emote("laugh")
	..()

/datum/reagent/drug/quaalude/overdose_process(mob/living/M, delta_time, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25 * REM * delta_time)
	M.adjustToxLoss(0.25 * REM * delta_time, 0)
	var/kidfrombrooklyn_message = pick("BRING BACK THE FUCKING QUAALUDES!", "I'd walk 20 miles for a quaalude, let me tell ya'!", "There's nothing like a fuckin' quaalude!")
	if(DT_PROB(1.5, delta_time))
		M.say("[kidfrombrooklyn_message]")
	if(DT_PROB(3.5, delta_time))
		M.emote("twitch")
	..()
	. = TRUE