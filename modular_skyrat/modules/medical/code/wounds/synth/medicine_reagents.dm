#define CLOT_RATE_INTENSITY_MULT 50

/datum/reagent/medicine/coagulant
	/// was_working, but for electrical damage
	var/was_working_synth
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/coagulant/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()

	if (was_working_synth)
		to_chat(affected_mob, span_warning("The chemicals sealing your faulty wires loses its effect!"))

/datum/reagent/medicine/coagulant/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	var/datum/wound/electrical_damage/zappiest_wound

	for (var/datum/wound/electrical_damage/electrical_wound in affected_mob.all_wounds)
		if (electrical_wound.processing_shock_power_per_second_max > zappiest_wound?.processing_shock_power_per_second_max)
			zappiest_wound = electrical_wound

	if (zappiest_wound)
		if (!was_working_synth)
			to_chat(affected_mob, span_warning("Your damaged circuitry is encased in a insulative substance!"))
			was_working_synth = TRUE
		zappiest_wound.adjust_intensity(-clot_rate * CLOT_RATE_INTENSITY_MULT * seconds_per_tick)
	else
		was_working_synth = FALSE

#undef CLOT_RATE_INTENSITY_MULT
