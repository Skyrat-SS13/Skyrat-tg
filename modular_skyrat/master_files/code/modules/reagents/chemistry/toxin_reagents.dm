
/datum/reagent/toxin/sodium_thiopental_lesser // Functionally a copypaste from the non-modular folder for easier balance tweaks.
	name = "Lesser Sodium Thiopental"
	description = "Lesser Sodium Thiopental induces heavy weakness in its target as well as unconsciousness, though not as well as it's pure alternative."
	silent_toxin = TRUE
	reagent_state = LIQUID
	color = "#6496FA"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	toxpwr = 0
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/sodium_thiopental_lesser/on_mob_add(mob/living/L, amount)
	. = ..()
	ADD_TRAIT(L, TRAIT_ANTICONVULSANT, name)

/datum/reagent/medicine/sodium_thiopental_lesser/on_mob_delete(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_ANTICONVULSANT, name)

/datum/reagent/toxin/sodium_thiopental_lesser/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(current_cycle >= 18)
		M.Sleeping(40 * REM * delta_time)
	M.adjustStaminaLoss(7 * REM * delta_time, 0)
	..()
	return TRUE
