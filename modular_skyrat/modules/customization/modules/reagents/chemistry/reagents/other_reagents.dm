/datum/reagent/fuel
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/oil
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/stable_plasma
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/pax
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/water
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/hellwater
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/syndicateadrenals
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/carbondioxide
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/stable_plasma/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC)
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()

/datum/reagent/fuel/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC)
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()

/datum/reagent/oil/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC && C.blood_volume < BLOOD_VOLUME_NORMAL)
		C.blood_volume += 0.5
	..()

/datum/reagent/carbondioxide/on_mob_life(mob/living/carbon/C)
	if(C.mob_biotypes & MOB_ROBOTIC)
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()

// Catnip
/datum/reagent/pax/catnip
	name = "Catnip"
	taste_description = "grass"
	description = "A colourless liquid that makes people more peaceful and felines happier."
	metabolization_rate = 1.75 * REAGENTS_METABOLISM

/datum/mood_event/catnip
	description = span_nicegreen("That plant has left me feeling great!\n")
	mood_change = 1
	timeout = 4 MINUTES

/datum/reagent/pax/catnip/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	SEND_SIGNAL(affected_mob, COMSIG_ADD_MOOD_EVENT, "catnip", /datum/mood_event/catnip)

/datum/reagent/pax/catnip/on_mob_life(mob/living/carbon/affected_carbon)
	if(prob(10))
		affected_carbon.emote(pick("nya", "meow"))
	..()
