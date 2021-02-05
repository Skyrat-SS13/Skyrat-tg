/datum/species/lizard/ashwalker
	mutanteyes = /obj/item/organ/eyes/night_vision

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	LAZYOR(C.weather_immunities, "ash")

/datum/species/lizard/ashwalker/on_species_loss(mob/living/carbon/C)
	. = ..()
	LAZYREMOVE(C.weather_immunities, "ash")
