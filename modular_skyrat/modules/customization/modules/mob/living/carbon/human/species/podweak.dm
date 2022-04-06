/datum/species/pod
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP
	)
	learnable_languages = list(/datum/language/common, /datum/language/sylvan) //I guess plants are smart and they can speak common
	payday_modifier = 0.75

/datum/species/pod/podweak
	name = "Podperson"
	id = SPECIES_PODPERSON_WEAK
	examine_limb_id = SPECIES_PODPERSON
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list()

	learnable_languages = list(/datum/language/common, /datum/language/sylvan)
	always_customizable = FALSE

/datum/species/pod/podweak/spec_life(mob/living/carbon/human/H, delta_time, times_fired)
	if(H.stat != CONSCIOUS)
		return

	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1, T.get_lumcount()) - 0.5
		H.adjust_nutrition(5 * light_amount * delta_time)
		if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
			H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)
		if(light_amount > 0.2) //if there's enough light, heal
			H.heal_overall_damage(0.2 * delta_time, 0.2 * delta_time, 0)
			H.adjustToxLoss(-0.2 * delta_time)
			H.adjustOxyLoss(-0.2 * delta_time)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.take_overall_damage(1 * delta_time, 0)
