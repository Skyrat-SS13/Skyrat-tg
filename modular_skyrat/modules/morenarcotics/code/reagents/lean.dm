// https://www.youtube.com/watch?v=2YVvMfXXG7E

/datum/chemical_reaction/promethazine
	results = list(/datum/reagent/medicine/promethazine = 4)
	required_reagents = list(/datum/reagent/medicine/morphine = 2, /datum/reagent/hydrogen = 1, /datum/reagent/chlorine = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG

/datum/chemical_reaction/lean
	results = list(/datum/reagent/drug/lean = 5)
	required_reagents = list(/datum/chemical_reaction/promethazine = 1, /datum/reagent/consumable/space_up = 5)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG

/datum/reagent/medicine/promethazine
	name = "Promethazine"
	description = "Promethazine can be used for suppressing coughs, although has the side effect of being a mild sedative."
	reagent_state = LIQUID
	color = "#74396a"
	overdose_threshold = 30
	ph = 8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/promethazine/on_mob_life(mob/living/carbon/affected_carbon, seconds_per_tick, times_fired)
	affected_carbon.adjust_drugginess_up_to(6 SECONDS, 12 SECONDS)
	affected_carbon.apply_status_effect(/datum/status_effect/throat_soothed)
	return ..()

/datum/reagent/medicine/promethazine/overdose_process(mob/living/affected_carbon, seconds_per_tick, times_fired)
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.25 * REM * seconds_per_tick)
	affected_carbon.adjustToxLoss(0.25 * REM * seconds_per_tick, 0)
	affected_carbon.adjust_drowsiness(0.5 SECONDS * REM * seconds_per_tick)
	affected_carbon.adjust_dizzy_up_to(30 SECONDS, 60 SECONDS)
	affected_carbon.adjustStaminaLoss(1 * REM * seconds_per_tick)
	return TRUE

/datum/reagent/drug/lean
	name = "Lean"
	description = "An cocktail of cough syrup and soda that originated in ancient Houston."
	reagent_state = LIQUID
	color = "#74396a"
	overdose_threshold = 30
	ph = 8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/lean/on_mob_life(mob/living/carbon/affected_carbon, seconds_per_tick, times_fired)
	affected_carbon.adjust_drugginess_up_to(30 SECONDS, 60 SECONDS)
	affected_carbon.adjust_slurring_up_to(30 SECONDS, 60 SECONDS)
	affected_carbon.apply_status_effect(/datum/status_effect/throat_soothed)
	return ..()

/datum/reagent/drug/lean/overdose_process(mob/living/affected_carbon, seconds_per_tick, times_fired)
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.25 * REM * seconds_per_tick)
	affected_carbon.adjustToxLoss(0.25 * REM * seconds_per_tick, 0)
	affected_carbon.adjust_drowsiness(0.5 SECONDS * REM * seconds_per_tick)
	affected_carbon.adjust_dizzy_up_to(30 SECONDS, 60 SECONDS)
	affected_carbon.adjustStaminaLoss(1 * REM * seconds_per_tick)
	return TRUE

/obj/item/reagent_containers/cup/bottle/promethazine
	name = "promethazine bottle"
	desc = "A small bottle. Contains prescription strength promethazine."
	list_reagents = list(/datum/reagent/medicine/promethazine = 30)
	fill_icon_state = null
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "promethazine"
