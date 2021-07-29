/datum/reagent/drug/quaalude
	name = "Quaalude"
	description = "Relaxes the user, putting them in a hypnotic, drugged state. A favorite drug of kids from Brooklyn." //THAT WAS THE BEST FUCKIN DRUG EVER MADE
	reagent_state = LIQUID
	color = "#ffe669"
	overdose_threshold = 20
	ph = 8
	taste_description = "lemons"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/quaalude/on_mob_life(mob/living/carbon/containing_mob, delta_time, times_fired)
	var/high_message = pick("You feel relaxed.", "You feel like you're on the moon.", "You feel like you could walk 20 miles for a quaalude.")
	if(DT_PROB(2.5, delta_time))
		to_chat(containing_mob, "<span class='notice'>[high_message]</span>")
	containing_mob.set_drugginess(15 * REM * delta_time)
	containing_mob.adjustStaminaLoss(-5 * REM * delta_time, 0)
	if(DT_PROB(3.5, delta_time))
		containing_mob.emote(pick("laugh","drool"))
	..()

/datum/reagent/drug/quaalude/overdose_process(mob/living/containing_mob, delta_time, times_fired)
	var/kidfrombrooklyn_message = pick("BRING BACK THE FUCKING QUAALUDES!", "I'd walk 20 miles for a quaalude, let me tell ya'!", "There's nothing like a fuckin' quaalude!")
	if(DT_PROB(1.5, delta_time))
		containing_mob.say("[kidfrombrooklyn_message]")
	containing_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25 * REM * delta_time)
	containing_mob.adjustToxLoss(0.25 * REM * delta_time, 0)
	containing_mob.drowsyness += 0.25 * REM * normalise_creation_purity() * delta_time
	if(DT_PROB(3.5, delta_time))
		containing_mob.emote("twitch")
	..()
	. = TRUE
