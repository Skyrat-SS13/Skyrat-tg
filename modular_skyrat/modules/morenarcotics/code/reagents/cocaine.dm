/datum/chemical_reaction/powder_cocaine
	is_cold_recipe = TRUE
	required_reagents = list(/datum/reagent/drug/cocaine = 10)
	required_temp = 250 //freeze it
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING
	mix_message = "The solution freezes into a powder!"

/datum/chemical_reaction/powder_cocaine/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		var/obj/item/snortable/cocaine/created_powder = new(location)
		created_powder.pixel_x = rand(-6, 6)
		created_powder.pixel_y = rand(-6, 6)


/datum/chemical_reaction/freebase_cocaine
	required_reagents = list(/datum/reagent/drug/cocaine = 10, /datum/reagent/water = 5, /datum/reagent/ash = 10)
	required_temp = 480 //heat it up
	reaction_flags = REACTION_INSTANT
	reaction_flags_skyrat = REACTION_KEEP_INSTANT_REQUIREMENTS
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/freebase_cocaine/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)

	// get the purity from the holder (can only do this because we arent deleting the ingredients yet)
	var/saved_purity = 0
	for(var/used_reagent_type in required_reagents)//this is not an object
		var/datum/reagent/used_reagent = holder.has_reagent(used_reagent_type)
		if (!used_reagent)
			continue
		saved_purity += used_reagent.purity
	saved_purity /= required_reagents.len

	// create the result
	for(var/i in 1 to created_volume)
		var/obj/item/smokable/crack/created_crack = new(location)
		var/datum/reagent/drug/cocaine/freebase_cocaine/created_reagent = created_crack.reagents.has_reagent(/datum/reagent/drug/cocaine/freebase_cocaine)
		created_reagent.creation_purity = saved_purity
		created_reagent.purity = saved_purity
		created_crack.pixel_x = rand(-6, 6)
		created_crack.pixel_y = rand(-6, 6)

	// and finally delete the initial ingredients
	for(var/used_reagent_type in required_reagents)//this is not an object
		holder.remove_reagent(used_reagent_type, (created_volume * required_reagents[used_reagent_type]), safety = 1)

/datum/reagent/drug/cocaine
	name = "Cocaine"
	description = "A powerful stimulant extracted from coca leaves. Reduces stun times, but causes drowsiness and severe brain damage if overdosed."
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
	ph = 9
	taste_description = "bitterness" //supposedly does taste bitter in real life
	addiction_types = list(/datum/addiction/stimulants = 44) // 1200 / (addiction points * (0.2 / reagent metabolism rate)) = how many units it takes to get addicted

/datum/reagent/drug/cocaine/on_mob_metabolize(mob/living/containing_mob)
	..()
	containing_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	ADD_TRAIT(containing_mob, TRAIT_BATON_RESISTANCE, type)

/datum/reagent/drug/cocaine/on_mob_end_metabolize(mob/living/containing_mob)
	containing_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	REMOVE_TRAIT(containing_mob, TRAIT_BATON_RESISTANCE, type)
	..()

/datum/reagent/drug/cocaine/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(SPT_PROB(2.5, seconds_per_tick))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("zoinked", /datum/mood_event/stimulant_heavy, name)
	M.AdjustStun(-15 * REM * seconds_per_tick)
	M.AdjustKnockdown(-15 * REM * seconds_per_tick)
	M.AdjustUnconscious(-15 * REM * seconds_per_tick)
	M.AdjustImmobilized(-15 * REM * seconds_per_tick)
	M.AdjustParalyzed(-15 * REM * seconds_per_tick)
	M.adjustStaminaLoss(-2 * REM * seconds_per_tick, 0)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote("shiver")
	..()
	. = TRUE

/datum/reagent/drug/cocaine/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Your heart beats is beating so fast, it hurts..."))

/datum/reagent/drug/cocaine/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjustToxLoss(1 * REM * seconds_per_tick, 0)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, (rand(10, 20) / 10) * REM * seconds_per_tick)
	M.set_jitter_if_lower(5 SECONDS)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote(pick("twitch","drool"))
	if(!HAS_TRAIT(M, TRAIT_FLOORED))
		if(SPT_PROB(1.5, seconds_per_tick))
			M.visible_message(span_danger("[M] collapses onto the floor!"))
			M.Paralyze(135,TRUE)
			M.drop_all_held_items()
	..()
	. = TRUE

/datum/reagent/drug/cocaine/freebase_cocaine
	name = "Freebase cocaine"
	description = "A smokable form of cocaine."
	color = "#f0e6bb"
	metabolization_rate = 0.05
	addiction_types = list(/datum/addiction/stimulants = 66)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/cocaine/powder_cocaine
	name = "Powder cocaine"
	description = "The powder form of cocaine."
	color = "#ffffff"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
