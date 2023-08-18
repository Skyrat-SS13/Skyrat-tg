/datum/chemical_reaction/heroin
	results = list(/datum/reagent/drug/heroin = 4)
	required_reagents = list(/datum/reagent/drug/opium = 2, /datum/reagent/acetone = 2)
	reaction_tags = REACTION_TAG_CHEMICAL
	required_temp = 480
	optimal_ph_min = 8
	optimal_ph_max = 12
	H_ion_release = -0.04
	rate_up_lim = 12.5
	purity_min = 0.5

/datum/chemical_reaction/powder_heroin
	is_cold_recipe = TRUE
	required_reagents = list(/datum/reagent/drug/heroin = 8)
	required_temp = 250 //freeze it
	reaction_flags = REACTION_INSTANT
	reaction_flags_skyrat = REACTION_KEEP_INSTANT_REQUIREMENTS
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING
	mix_message = "The solution freezes into a powder!"

/datum/chemical_reaction/powder_heroin/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)

	// get the purity from the holder (can only do this because we arent deleting the ingredients yet)
	var/saved_purity = 0
	for(var/used_reagent_type in required_reagents)//this is not an object
		var/datum/reagent/used_reagent = holder.has_reagent(used_reagent_type)
		if (!used_reagent)
			continue
		saved_purity += used_reagent.creation_purity
	saved_purity /= required_reagents.len

	// create the result
	for(var/i in 1 to created_volume)
		var/obj/item/snortable/heroin/created_heroin = new(location)
		var/datum/reagent/drug/heroin/powder_heroin/created_reagent = created_heroin.reagents.has_reagent(/datum/reagent/drug/heroin/powder_heroin)
		created_reagent.creation_purity = saved_purity
		created_reagent.purity = saved_purity
		created_heroin.pixel_x = rand(-6, 6)
		created_heroin.pixel_y = rand(-6, 6)

	// and finally delete the initial ingredients
	for(var/used_reagent_type in required_reagents)//this is not an object
		holder.remove_reagent(used_reagent_type, (created_volume * required_reagents[used_reagent_type]), safety = 1)

/atom/movable/screen/fullscreen/color_vision/heroin_color
	color = "#444444"

/datum/reagent/drug/opium
	name = "Opium"
	description = "A extract from opium poppies. Puts the user in a slightly euphoric state."
	reagent_state = LIQUID
	color = "#ffe669"
	overdose_threshold = 30
	ph = 8
	taste_description = "flowers"
	addiction_types = list(/datum/addiction/opioids = 33)

/datum/reagent/drug/opium/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("You feel euphoric.", "You feel on top of the world.")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("smacked out", /datum/mood_event/narcotic_heavy, name)
	M.adjustBruteLoss(-0.1 * REM * seconds_per_tick, 0) //can be used as a (shitty) painkiller
	M.adjustFireLoss(-0.1 * REM * seconds_per_tick, 0)
	M.overlay_fullscreen("heroin_euphoria", /atom/movable/screen/fullscreen/color_vision/heroin_color)
	return ..()

/datum/reagent/drug/opium/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.5 * REM * seconds_per_tick)
	M.adjustToxLoss(1 * REM * seconds_per_tick, 0)
	M.adjust_drowsiness(1 SECONDS * REM * normalise_creation_purity() * seconds_per_tick)
	return TRUE

/datum/reagent/drug/opium/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/drug/opium/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	metabolizer.clear_fullscreen("heroin_euphoria")


/datum/reagent/drug/heroin
	name = "Heroin"
	description = "She's like heroin to me, she's like heroin to me! She cannot... miss a vein!"
	reagent_state = LIQUID
	color = "#ffe669"
	overdose_threshold = 20
	ph = 6
	taste_description = "flowers"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	inverse_chem = /datum/reagent/drug/black_tar/liquid
	addiction_types = list(/datum/addiction/opioids = 66)

/datum/reagent/drug/heroin/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("You feel like nothing can stop you.", "You feel like God.")
	var/strength_multiplier = creation_purity**2
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("smacked out", /datum/mood_event/narcotic_heavy, name)
	M.adjustBruteLoss(-0.5 * strength_multiplier * REM * seconds_per_tick, 0) //more powerful as a painkiller, possibly actually useful to medical now
	M.adjustFireLoss(-0.5 * strength_multiplier * REM * seconds_per_tick, 0)
	M.adjustToxLoss(0.1 * (1/strength_multiplier) * REM * seconds_per_tick, 0)
	M.overlay_fullscreen("heroin_euphoria", /atom/movable/screen/fullscreen/color_vision/heroin_color)
	..()

/datum/reagent/drug/heroin/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.75 * REM * seconds_per_tick)
	M.adjustToxLoss(1.5 * REM * seconds_per_tick, 0)
	M.adjust_drowsiness(1 SECONDS * REM * normalise_creation_purity() * seconds_per_tick)
	return TRUE

/datum/reagent/drug/heroin/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/drug/heroin/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	metabolizer.clear_fullscreen("heroin_euphoria")

/datum/reagent/drug/heroin/powder_heroin
	name = "Powder heroin"
	description = "The powder form of heroin."

/datum/reagent/drug/black_tar
	name = "Black tar heroin"
	description = "An impure, freebase form of heroin. Probably not a good idea to take this..."
	reagent_state = LIQUID
	color = "#242423"
	overdose_threshold = 10 //more easy to overdose on
	ph = 8
	taste_description = "flowers"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = 0.05
	addiction_types = list(/datum/addiction/opioids = 66)

/datum/reagent/drug/black_tar/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("You feel like tar.", "The blood in your veins feel like syrup.")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("smacked out", /datum/mood_event/narcotic_heavy, name)
	M.set_drugginess(20 SECONDS * REM * seconds_per_tick)
	M.adjustBruteLoss(-0.1 * REM * seconds_per_tick, 0)
	M.adjustFireLoss(-0.1 * REM * seconds_per_tick, 0)
	M.adjustToxLoss(0.5 * REM * seconds_per_tick, 0) //toxin damage
	return ..()

/datum/reagent/drug/black_tar/liquid //prevents self-duplication by going one step down when mixed
	name = "Liquid black tar heroin"

/datum/chemical_reaction/black_tar
	required_reagents = list(/datum/reagent/drug/black_tar/liquid = 5)
	required_temp = 480
	reaction_flags = REACTION_INSTANT
	reaction_flags_skyrat = REACTION_KEEP_INSTANT_REQUIREMENTS
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/black_tar/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)

	// get the purity from the holder (can only do this because we arent deleting the ingredients yet)
	var/saved_purity = 0
	for(var/used_reagent_type in required_reagents)//this is not an object
		var/datum/reagent/used_reagent = holder.has_reagent(used_reagent_type)
		if (!used_reagent)
			continue
		saved_purity += used_reagent.creation_purity
	saved_purity /= required_reagents.len

	// create the result
	for(var/i in 1 to created_volume)
		var/obj/item/smokable/black_tar/created_heroin = new(location)
		var/datum/reagent/drug/black_tar/created_reagent = created_heroin.reagents.has_reagent(/datum/reagent/drug/black_tar)
		created_reagent.creation_purity = saved_purity
		created_reagent.purity = saved_purity
		created_heroin.pixel_x = rand(-6, 6)
		created_heroin.pixel_y = rand(-6, 6)

	// and finally delete the initial ingredients
	for(var/used_reagent_type in required_reagents)//this is not an object
		holder.remove_reagent(used_reagent_type, (created_volume * required_reagents[used_reagent_type]), safety = 1)
