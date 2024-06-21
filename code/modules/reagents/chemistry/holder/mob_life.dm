/**
 * Triggers metabolizing for all the reagents in this holder
 *
 * Arguments:
 * * mob/living/carbon/carbon - The mob to metabolize in, if null it uses [/datum/reagents/var/my_atom]
 * * seconds_per_tick - the time in server seconds between proc calls (when performing normally it will be 2)
 * * times_fired - the number of times the owner's life() tick has been called aka The number of times SSmobs has fired
 * * can_overdose - Allows overdosing
 * * liverless - Stops reagents that aren't set as [/datum/reagent/var/self_consuming] from metabolizing
 */
/datum/reagents/proc/metabolize(mob/living/carbon/owner, seconds_per_tick, times_fired, can_overdose = FALSE, liverless = FALSE, dead = FALSE)
	var/list/cached_reagents = reagent_list
	if(owner)
		expose_temperature(owner.bodytemperature, 0.25)

	var/need_mob_update = FALSE
	var/obj/item/organ/internal/stomach/belly = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/obj/item/organ/internal/liver/liver = owner.get_organ_slot(ORGAN_SLOT_LIVER)
	var/liver_tolerance
	if(liver)
		var/liver_health_percent = (liver.maxHealth - liver.damage) / liver.maxHealth
		liver_tolerance = liver.toxTolerance * liver_health_percent

	for(var/datum/reagent/reagent as anything in cached_reagents)
		// skip metabolizing effects for small units of toxins
		if(istype(reagent, /datum/reagent/toxin) && liver && !dead)
			var/datum/reagent/toxin/toxin = reagent
			var/amount = toxin.volume
			if(belly)
				amount += belly.reagents.get_reagent_amount(toxin.type)

			if(amount <= liver_tolerance)
				owner.reagents.remove_reagent(toxin.type, toxin.metabolization_rate * owner.metabolism_efficiency * seconds_per_tick)
				continue

		need_mob_update += metabolize_reagent(owner, reagent, seconds_per_tick, times_fired, can_overdose, liverless, dead)

	if(owner && need_mob_update) //some of the metabolized reagents had effects on the mob that requires some updates.
		owner.updatehealth()
	update_total()

/*
 * Metabolises a single reagent for a target owner carbon mob. See above.
 *
 * Arguments:
 * * mob/living/carbon/owner - The mob to metabolize in, if null it uses [/datum/reagents/var/my_atom]
 * * seconds_per_tick - the time in server seconds between proc calls (when performing normally it will be 2)
 * * times_fired - the number of times the owner's life() tick has been called aka The number of times SSmobs has fired
 * * can_overdose - Allows overdosing
 * * liverless - Stops reagents that aren't set as [/datum/reagent/var/self_consuming] from metabolizing
 */
/datum/reagents/proc/metabolize_reagent(mob/living/carbon/owner, datum/reagent/reagent, seconds_per_tick, times_fired, can_overdose = FALSE, liverless = FALSE, dead = FALSE)
	var/need_mob_update = FALSE
	if(QDELETED(reagent.holder))
		return FALSE

	if(!owner)
		owner = reagent.holder.my_atom

	//SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION
	var/can_process = reagent_process_flags_valid(owner, reagent)
	//If the mob can't process it, remove the reagent at it's normal rate without doing any addictions, overdoses, or on_mob_life() for the reagent
	if(!can_process)
		reagent.holder.remove_reagent(reagent.type, reagent.metabolization_rate)
		return
	//SKYRAT EDIT ADDITION END

	if(owner && reagent && (!dead || (reagent.chemical_flags & REAGENT_DEAD_PROCESS)))
		if(owner.reagent_check(reagent, seconds_per_tick, times_fired))
			return
		if(liverless && !reagent.self_consuming) //need to be metabolized
			return
		if(!reagent.metabolizing)
			reagent.metabolizing = TRUE
			reagent.on_mob_metabolize(owner)
		if(can_overdose && !HAS_TRAIT(owner, TRAIT_OVERDOSEIMMUNE))
			if(reagent.overdose_threshold)
				if(reagent.volume >= reagent.overdose_threshold && !reagent.overdosed)
					reagent.overdosed = TRUE
					need_mob_update += reagent.overdose_start(owner)
					owner.log_message("has started overdosing on [reagent.name] at [reagent.volume] units.", LOG_GAME)
			for(var/addiction in reagent.addiction_types)
				owner.mind?.add_addiction_points(addiction, reagent.addiction_types[addiction] * REAGENTS_METABOLISM)

			if(reagent.overdosed)
				need_mob_update += reagent.overdose_process(owner, seconds_per_tick, times_fired)
		reagent.current_cycle++
		need_mob_update += reagent.on_mob_life(owner, seconds_per_tick, times_fired)
		if(dead && !QDELETED(owner) && !QDELETED(reagent))
			need_mob_update += reagent.on_mob_dead(owner, seconds_per_tick)
		if(!QDELETED(owner) && !QDELETED(reagent))
			reagent.metabolize_reagent(owner, seconds_per_tick, times_fired)

	return need_mob_update

/**
 * Signals that metabolization has stopped, triggering the end of trait-based effects
 * Arguments
 *
 * * [C][mob/living/carbon] - the mob to end metabolization on
 * * keep_liverless - if true will work without a liver
 */
/datum/reagents/proc/end_metabolization(mob/living/carbon/C, keep_liverless = TRUE)
	var/list/cached_reagents = reagent_list
	for(var/datum/reagent/reagent as anything in cached_reagents)
		if(QDELETED(reagent.holder))
			continue
		if(keep_liverless && reagent.self_consuming) //Will keep working without a liver
			continue
		if(!C)
			C = reagent.holder.my_atom
		if(reagent.metabolizing)
			reagent.metabolizing = FALSE
			reagent.on_mob_end_metabolize(C)

/**
 * Processes the reagents in the holder and converts them, only called in a mob/living/carbon on addition
 *
 * Arguments:
 * * reagent - the added reagent datum/object
 * * added_volume - the volume of the reagent that was added (since it can already exist in a mob)
 * * added_purity - the purity of the added volume
 * returns the volume of the original, pure, reagent to add / keep
 */
/datum/reagents/proc/process_mob_reagent_purity(datum/reagent/reagent, added_volume, added_purity)
	if(!reagent)
		stack_trace("Attempted to process a mob's reagent purity for a null reagent!")
		return FALSE
	if(added_purity == 1)
		return added_volume
	if(reagent.chemical_flags & REAGENT_DONOTSPLIT)
		return added_volume
	if(added_purity < 0)
		stack_trace("Purity below 0 for chem on mob splitting: [reagent.type]!")
		added_purity = 0

	if((reagent.inverse_chem_val > added_purity) && (reagent.inverse_chem))//Turns all of a added reagent into the inverse chem
		add_reagent(reagent.inverse_chem, added_volume, FALSE, added_purity = reagent.get_inverse_purity(reagent.creation_purity))
		var/datum/reagent/inverse_reagent = has_reagent(reagent.inverse_chem)
		if(inverse_reagent.chemical_flags & REAGENT_SNEAKYNAME)
			inverse_reagent.name = reagent.name//Negative effects are hidden
		return FALSE //prevent addition
	return added_volume

/**
 * Processes any chems that have the REAGENT_IGNORE_STASIS bitflag ONLY
 * Arguments
 *
 * * [owner][mob/living/carbon] - the mob we are doing stasis handlng on
 * * seconds_per_tick - passed from process
 * * times_fired - number of times to metabolize this reagent
 */
/datum/reagents/proc/handle_stasis_chems(mob/living/carbon/owner, seconds_per_tick, times_fired)
	var/need_mob_update = FALSE
	for(var/datum/reagent/reagent as anything in reagent_list)
		if(!(reagent.chemical_flags & REAGENT_IGNORE_STASIS))
			continue
		need_mob_update += metabolize_reagent(owner, reagent, seconds_per_tick, times_fired, can_overdose = TRUE)
	if(owner && need_mob_update) //some of the metabolized reagents had effects on the mob that requires some updates.
		owner.updatehealth()
	update_total()
