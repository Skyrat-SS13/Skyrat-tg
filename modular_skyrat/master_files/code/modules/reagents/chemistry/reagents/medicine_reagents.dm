//Used for Abductors
/datum/reagent/medicine/abductoradrenaline
	name = "Z-Gamma Precepts"
	description = "A synthesized adrenaline based on a chemical a certain other lifeform creates. Overdosing can cause brain damage."
	color = "#4CFF00"
	overdose_threshold = 30
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/changelingadrenaline/on_mob_life(mob/living/carbon/metabolizer, delta_time, times_fired)
	..()
	metabolizer.AdjustAllImmobility(-10 * REM * delta_time)
	metabolizer.adjustStaminaLoss(-5 * REM * delta_time, 0)
	metabolizer.Jitter(10 * REM * delta_time)
	return TRUE

/datum/reagent/medicine/abductoradrenaline/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/abductoradrenaline/on_mob_end_metabolize(mob/living/L)
	..()
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/abductoradrenaline/overdose_process(mob/living/metabolizer, delta_time, times_fired)
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjustOrganLoss(ORGAN_SLOT_BRAIN,1*REM*delta_time)
	..()
	. = TRUE