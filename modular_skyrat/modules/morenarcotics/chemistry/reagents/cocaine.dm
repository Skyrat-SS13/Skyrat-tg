/datum/reagent/drug/cocaine
	name = "Cocaine"
	description = "A powerful stimulant extracted from coca leaves. Reduces stun times, but causes drowsiness and severe brain damage if overdosed."
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
	ph = 9
	taste_description = "bitterness" //supposedly does taste bitter in real life
	addiction_types = list(/datum/addiction/stimulants = 14) //5.6 per 2 seconds

/datum/reagent/drug/cocaine/on_mob_metabolize(mob/living/containing_mob)
	..()
	containing_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	ADD_TRAIT(containing_mob, TRAIT_STUNRESISTANCE, type)

/datum/reagent/drug/cocaine/on_mob_end_metabolize(mob/living/containing_mob)
	containing_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	REMOVE_TRAIT(containing_mob, TRAIT_STUNRESISTANCE, type)
	..()

/datum/reagent/drug/cocaine/on_mob_life(mob/living/carbon/containing_mob, delta_time, times_fired)
	if(DT_PROB(2.5, delta_time))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(containing_mob, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(containing_mob, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	containing_mob.AdjustStun(-15 * REM * delta_time)
	containing_mob.AdjustKnockdown(-15 * REM * delta_time)
	containing_mob.AdjustUnconscious(-15 * REM * delta_time)
	containing_mob.AdjustImmobilized(-15 * REM * delta_time)
	containing_mob.AdjustParalyzed(-15 * REM * delta_time)
	containing_mob.adjustStaminaLoss(-2 * REM * delta_time, 0)
	if(DT_PROB(2.5, delta_time))
		containing_mob.emote("shiver")
	..()
	. = TRUE


/datum/reagent/drug/cocaine/overdose_start(mob/living/containing_mob)
	to_chat(containing_mob, "<span class='userdanger'>Your heart beats is beating so fast, it hurts...</span>")

/datum/reagent/drug/cocaine/overdose_process(mob/living/containing_mob, delta_time, times_fired)
	containing_mob.adjustToxLoss(1 * REM * delta_time, 0)
	containing_mob.adjustOrganLoss(ORGAN_SLOT_HEART, (rand(10, 20) / 10) * REM * delta_time)
	containing_mob.Jitter(2 * REM * delta_time)
	if(DT_PROB(2.5, delta_time))
		containing_mob.emote(pick("twitch","drool"))
	..()
	. = TRUE

/datum/reagent/drug/cocaine/freebase_cocaine
	name = "freebase cocaine"
	description = "A smokable form of cocaine."
	color = "#f0e6bb"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/cocaine/powder_cocaine
	name = "powder cocaine"
	description = "The powder form of cocaine."
	color = "#ffffff"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
