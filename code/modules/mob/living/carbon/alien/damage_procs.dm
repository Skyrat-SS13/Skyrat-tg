///alien immune to tox damage
/mob/living/carbon/alien/getToxLoss()
	return FALSE

///alien immune to tox damage
/mob/living/carbon/alien/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	return FALSE

///aliens are immune to stamina damage.
/mob/living/carbon/alien/adjustStaminaLoss(amount, updating_health = 1, forced = FALSE)
	return FALSE

///aliens are immune to stamina damage.
/mob/living/carbon/alien/setStaminaLoss(amount, updating_health = 1)
	return FALSE
// Want to find the source of Xenomorphs taking double / 1.5x burn damage? See: code/modules/surgery/bodyparts/bodyparts.dm and search for ALIEN_BODYPART don't ask why it's there.
