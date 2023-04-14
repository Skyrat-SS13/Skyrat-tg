/datum/species/pod
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_PLANT_SAFE,
		TRAIT_LITERATE,
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"pod_hair" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	payday_modifier = 0.75

/datum/species/pod/podweak
	name = "Podperson"
	id = SPECIES_PODPERSON_WEAK
	examine_limb_id = SPECIES_PODPERSON
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		HAIR, // Leaving this here so they can still use it if they want, even if it's kinda ugly compared to their special hair.
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
	)

	always_customizable = FALSE

/datum/species/pod/podweak/spec_life(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	if(H.stat != CONSCIOUS)
		return

	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1, T.get_lumcount()) - 0.5
		H.adjust_nutrition(5 * light_amount * seconds_per_tick)
		if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
			H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)
		if(light_amount > 0.2) //if there's enough light, heal
			H.heal_overall_damage(0.2 * seconds_per_tick, 0.2 * seconds_per_tick, 0)
			H.adjustStaminaLoss(-0.2 * seconds_per_tick)
			H.adjustToxLoss(-0.2 * seconds_per_tick)
			H.adjustOxyLoss(-0.2 * seconds_per_tick)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.take_overall_damage(1 * seconds_per_tick, 0)


/datum/species/pod/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.mutant_bodyparts["pod_hair"] = list(MUTANT_INDEX_NAME = "Ivy", MUTANT_INDEX_COLOR_LIST = list(COLOR_VIBRANT_LIME, COLOR_VIBRANT_LIME, COLOR_VIBRANT_LIME))
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)

