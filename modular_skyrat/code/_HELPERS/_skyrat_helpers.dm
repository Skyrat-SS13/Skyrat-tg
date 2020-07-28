
//INTERACTION HELPERS
/mob/living/carbon/has_penis() // Skyrat Change
	var/obj/item/organ/genital/G = getorganslot(ORGAN_SLOT_PENIS)
	if(G && istype(G, /obj/item/organ/genital/penis))
		return TRUE
	return FALSE

/mob/living/carbon/proc/has_balls() // Skyrat Change
	var/obj/item/organ/genital/G = getorganslot(ORGAN_SLOT_TESTICLES)
	if(G && istype(G, /obj/item/organ/genital/testicles))
		return TRUE
	return FALSE

/mob/living/carbon/has_vagina() // Skyrat Change
	if(getorganslot(ORGAN_SLOT_VAGINA))
		return TRUE
	return FALSE

/mob/living/carbon/has_breasts() // Skyrat Change
	if(getorganslot(ORGAN_SLOT_BREASTS))
		return TRUE
	return FALSE