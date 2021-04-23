/datum/reagent/drug/opium
	name = "Opium"
	description = "A extract from opium poppies. Puts the user in a slightly euphoric state."
	reagent_state = LIQUID
	color = "#ffe669"
	overdose_threshold = 30
	ph = 8
	taste_description = "flowers"

/datum/reagent/drug/opium/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/high_message = pick("You feel euphoric.", "You feel on top of the world.")
	if(DT_PROB(2.5, delta_time))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_medium, name)
	..()

/datum/reagent/drug/opium/overdose_process(mob/living/M, delta_time, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.5 * REM * delta_time)
	M.adjustToxLoss(1 * REM * delta_time, 0)
	M.drowsyness += 0.5 * REM * normalise_creation_purity() * delta_time
	..()
	. = TRUE

/datum/reagent/drug/opium/heroin
	name = "Heroin"
	description = "She's like heroin to me, she's like heroin to me! She cannot... miss a vein!"
	reagent_state = LIQUID
	color = "#ffe669"
	overdose_threshold = 20
	ph = 6
	taste_description = "flowers"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	failed_chem = /datum/reagent/drug/opium/blacktar


/datum/reagent/drug/opium/heroin/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/high_message = pick("You feel like nothing can stop you.", "You feel like God.")
	if(DT_PROB(2.5, delta_time))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "smacked out", /datum/mood_event/narcotic_heavy, name)
	M.set_drugginess(15 * REM * delta_time)
	..()

/datum/reagent/drug/opium/blacktar
	name = "Black Tar Heroin"
	description = "An impure, freebase form of heroin. Probably not a good idea to take this..."
	reagent_state = LIQUID
	color = "#242423"
	overdose_threshold = 10 //more easy to overdose on
	ph = 8
	taste_description = "flowers"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	failed_chem = null

/datum/reagent/drug/opium/blacktar/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/high_message = pick("You feel like tar.", "The blood in your veins feel like syrup.")
	if(DT_PROB(2.5, delta_time))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "smacked out", /datum/mood_event/narcotic_heavy, name)
	M.set_drugginess(15 * REM * delta_time)
	M.adjustToxLoss(0.5 * REM * delta_time, 0) //toxin damage
	..()
