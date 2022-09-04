/*
*	CATNIP PLANT
*/
/obj/item/seeds/tea/catnip
	name = "pack of catnip seeds"
	desc = "Long stalks with flowering tips, they contain a chemical that attracts felines."
	icon_state = "seed-catnip"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	species = "catnip"
	plantname = "Catnip Plant"
	growthstages = 3
	product = /obj/item/food/grown/tea/catnip
	reagents_add = list(/datum/reagent/catnip = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.06, /datum/reagent/toxin/teapowder = 0.3)
	rarity = 40

/obj/item/food/grown/tea/catnip
	seed = /obj/item/seeds/tea/catnip
	name = "catnip buds"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "catnip"
	filling_color = "#4582B4"
	grind_results = list(/datum/reagent/catnip = 2, /datum/reagent/water = 1)
	distill_reagent = /datum/reagent/consumable/pinkmilk //Don't ask, cats speak in poptart // Not anymore...


/*
*	CATNIP REAGENT
*	If you're a cat, it gives you a brain trauma that makes you hallucinate laser pointers around your person that you dive for
*/
/datum/reagent/catnip
	name = "Catnip"
	taste_description = "grass"
	description = "A colourless liquid that elicits a strong reaction in cats."
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	/// The brain trauma the reagent gives
	var/datum/brain_trauma/special/laser_pointer/laser_hallucination

/datum/reagent/catnip/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(isfelinid(drinker) || HAS_TRAIT(drinker, TRAIT_FELINE))
		laser_hallucination = new()
		drinker.gain_trauma(laser_hallucination, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/catnip/on_mob_end_metabolize(mob/living/carbon/drinker)
	if(laser_hallucination)
		QDEL_NULL(laser_hallucination)
	..()
