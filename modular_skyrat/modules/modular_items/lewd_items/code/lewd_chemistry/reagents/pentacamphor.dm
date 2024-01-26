// Pentacamphor. Used to purge crocin and hexacrocin. Can permanently disable arousal or cure bimbofication on overdose.
/datum/reagent/drug/aphrodisiac/camphor/pentacamphor
	name = "Pentacamphor"
	description = "Chemically condensed camphor. Causes an extreme reduction in libido and a permanent one if overdosed. Non-addictive."
	taste_description = "tranquil celibacy"
	color = "#D9D9D9"//rgb(255, 255, 255)
	reagent_state = SOLID
	overdose_threshold = 20
	arousal_adjust_amount = -18
	overdose_pref_datum = /datum/preference/toggle/erp/aphro

	/// How much of the given reagent to remove per operation
	var/reagent_reduction_amount = 20

/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/crocin))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/crocin, reagent_reduction_amount)
	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin, reagent_reduction_amount)

/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/overdose_start(mob/living/carbon/human/exposed_mob)
	if(HAS_TRAIT(exposed_mob, TRAIT_BIMBO))
		exposed_mob.cure_trauma_type(/datum/brain_trauma/very_special/bimbo, TRAUMA_RESILIENCE_ABSOLUTE)
		to_chat(exposed_mob, span_notice("Your mind is free. Your thoughts are pure and innocent once more."))
		REMOVE_TRAIT(exposed_mob, TRAIT_BIMBO, TRAIT_LEWDCHEM)
		return
	if(!HAS_TRAIT(exposed_mob, TRAIT_NEVERBONER))
		to_chat(exposed_mob, span_notice("You feel like you'll never feel aroused again..."))
		ADD_TRAIT(exposed_mob, TRAIT_NEVERBONER, TRAIT_LEWDCHEM)

/datum/chemical_reaction/pentacamphor
	results = list(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor = 1)
	required_reagents = list(/datum/reagent/drug/aphrodisiac/camphor = 5, /datum/reagent/acetone = 1)
	required_temp = 500
	mix_message = "The mixture thickens and heats up slighty..."
	erp_reaction = TRUE
