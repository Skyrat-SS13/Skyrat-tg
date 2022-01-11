


/datum/species/necromorph
	///Use icon-states instead of limbs id
	var/necro_iconstate = FALSE

// /datum/species/necromorph/proc/handle_mutant_bodyparts(/mob/living/carbon/human/species/necromorph/N)
// 	. = ..()
// 	var/mutable_appearance/simple_necromorph = null
// 	var/datum/species/necromorph/necromorph = NM
// 	if(dna?.species.id == SPECIES_NECROMORPH)
// 		if(dna?.species.id == SPECIES_NECROMORPH_BRUTE)
// 			var/necro_icon = "modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi"
// 			var/necro_icon_state = "brute-d"
// 			remove_overlay(BODYPARTS_LAYER)
// 			simple_necromorph = mutable_appearance(necro_icon, necro_icon_state, -BODYPARTS_LAYER)
// 		overlays_standing[BODYPARTS_LAYER] = simple_necromorph
// 		apply_overlay(BODYPARTS_LAYER)
// 	else
// 		return



/mob/living/carbon/human/species/necromorph/update_body_parts()
	. = ..()
	var/mutable_appearance/simple_necromorph = null
	if(dna?.species.id == SPECIES_NECROMORPH)
		if(dna?.species.id == SPECIES_NECROMORPH_BRUTE)
			var/necro_icon = "modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi"
			var/necro_icon_state = "brute-d"
			remove_overlay(BODYPARTS_LAYER)
			simple_necromorph = mutable_appearance(necro_icon, necro_icon_state, -BODYPARTS_LAYER)
		overlays_standing[BODYPARTS_LAYER] = simple_necromorph
		apply_overlay(BODYPARTS_LAYER)
	else
		return

