
/datum/reagent/medicine/lesser_syndicate_nanites //This didn't exist before, but we still had modular changes.
	name = "Lesser Restorative Nanites"
	description = "Miniature medical robots that swiftly restore bodily damage, these one seems a bit slower then usual."
	reagent_state = SOLID
	color = "#555555"
	overdose_threshold = 30
	ph = 11
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/lesser_syndicate_nanites/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustBruteLoss(-2 * REM * delta_time, 0) //Alot less healing, this will come from a 5tc investment.
	M.adjustFireLoss(-2 * REM * delta_time, 0)
	M.adjustOxyLoss(-8 * REM * delta_time, 0)
	M.adjustToxLoss(-2 * REM * delta_time, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -8 * REM * delta_time)
	M.adjustCloneLoss(-1 * REM * delta_time, 0)
	..()
	. = TRUE

/datum/reagent/medicine/lesser_syndicate_nanites/overdose_process(mob/living/carbon/M, delta_time, times_fired) //wtb flavortext messages that hint that you're vomitting up robots
	if(DT_PROB(13, delta_time))
		M.reagents.remove_reagent(type, metabolization_rate*15) // ~5 units at a rate of 0.4 but i wanted a nice number in code
		M.vomit(20) // nanite safety protocols make your body expel them to prevent harmies
	..()
	. = TRUE
