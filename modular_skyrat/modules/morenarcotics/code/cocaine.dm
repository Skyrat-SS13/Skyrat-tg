/datum/chemical_reaction/powder_cocaine
	is_cold_recipe = TRUE
	required_reagents = list(/datum/reagent/drug/cocaine = 10)
	required_temp = 250 //freeze it
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL
	mix_message = "The solution freezes into a powder!"

/datum/chemical_reaction/powder_cocaine/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/cocaine(location)

/datum/chemical_reaction/freebase_cocaine
	required_reagents = list(/datum/reagent/drug/cocaine = 10, /datum/reagent/water = 5, /datum/reagent/ash = 10) //mix 20 cocaine, 10 water, 20 ash
	required_temp = 480 //heat it up
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/freebase_cocaine/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/crack(location)

/datum/reagent/drug/cocaine
	name = "cocaine"
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
	ADD_TRAIT(containing_mob, TRAIT_BATON_RESISTANCE, type)

/datum/reagent/drug/cocaine/on_mob_end_metabolize(mob/living/containing_mob)
	containing_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	REMOVE_TRAIT(containing_mob, TRAIT_BATON_RESISTANCE, type)
	..()

/datum/reagent/drug/cocaine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(DT_PROB(2.5, delta_time))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, span_notice("[high_message]"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "zoinked", /datum/mood_event/stimulant_heavy, name)
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

/datum/reagent/drug/cocaine/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Your heart beats is beating so fast, it hurts..."))

/datum/reagent/drug/cocaine/overdose_process(mob/living/M, delta_time, times_fired)
	M.adjustToxLoss(1 * REM * delta_time, 0)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, (rand(10, 20) / 10) * REM * delta_time)
	M.set_timed_status_effect(5 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(DT_PROB(2.5, delta_time))
		M.emote(pick("twitch","drool"))
	if(!HAS_TRAIT(M, TRAIT_FLOORED))
		if(DT_PROB(1.5, delta_time))
			M.visible_message(span_danger("[M] collapses onto the floor!"))
			M.Paralyze(135,TRUE)
			M.drop_all_held_items()
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
