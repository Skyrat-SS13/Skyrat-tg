// Hexacrocin. Advanced aphrodisiac that can cause brain traumas.
/datum/reagent/drug/aphrodisiac/crocin/hexacrocin
	name = "hexacrocin"
	description = "Chemically condensed form of basic crocin. This aphrodisiac is extremely powerful and addictive for most animals.\
					Addiction withdrawals can cause brain damage and shortness of breath. Overdose can lead to brain traumas."
	taste_description = "liquid desire"
	color = "#FF2BFF"
	overdose_threshold = 25
	overdose_pref_datum = /datum/preference/toggle/erp/bimbofication

	emote_probability = 5
	thought_probability = 5
	arousal_adjust_amount = 2
	pleasure_adjust_amount = 1.5
	pain_adjust_amount = 0.2
	possible_aroused_thoughts = list(
		"You feel a bit hot.",
		"You feel strong sexual urges.",
		"You feel in the mood.",
		"You're ready to go down on someone.",
	)

	/// A list of possible to_chat messages the chem is able to trigger after enough cycles in the mobs system
	var/list/extreme_aroused_thoughts = list(
		"You need to fuck someone!",
		"You're bursting with sexual tension!",
		"You can't get sex off your mind!",
	)
	/// How many cycles the chem has to be in the mob's system before triggering extreme effects
	var/extreme_thought_threshold = 25

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(prob(thought_probability) && current_cycle >= extreme_thought_threshold)
		var/displayed_extreme_thought = pick(extreme_aroused_thoughts)
		to_chat(exposed_mob, span_purple("[displayed_extreme_thought]"))

	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/camphor))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/camphor, 5)

	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor, 5)

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/on_mob_metabolize(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(HAS_TRAIT(exposed_mob, TRAIT_NEVERBONER))
		exposed_mob.cure_trauma_type(/datum/brain_trauma/very_special/neverboner, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/overdose_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(HAS_TRAIT(exposed_mob, TRAIT_BIMBO))
		return
	else
		exposed_mob.gain_trauma(/datum/brain_trauma/very_special/bimbo, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/chemical_reaction/hexacrocin
	results = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = 1)
	required_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 6, /datum/reagent/phenol = 1)
	required_temp = 600
	mix_message = "The mixture rapidly condenses and darkens in color..."
	erp_reaction = TRUE
