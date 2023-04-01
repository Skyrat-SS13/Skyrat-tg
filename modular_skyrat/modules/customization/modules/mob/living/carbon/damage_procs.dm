/mob/living/carbon/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE, required_biotype, required_respiration_type)
	if(HAS_TRAIT(src, TRAIT_OXYIMMUNE)) //Prevents oxygen damage
		amount = min(amount, 0)
	return ..()
