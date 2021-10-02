// Not used for much right now. Basically only used for bodywriting, at the current moment. Keeping it in for future use, but commenting out all but chest.
// Ported from Hyper Code, which came from Cit, I believe.

/*
/mob/living/carbon/proc/has_penis()
	if(getorganslot("penis"))//slot shared with ovipositor
		if(istype(getorganslot("penis"), /obj/item/organ/genital/penis))
			return TRUE
	return FALSE

/mob/living/carbon/proc/has_balls()
	if(getorganslot("balls"))
		if(istype(getorganslot("balls"), /obj/item/organ/genital/testicles))
			return TRUE
	return FALSE

/mob/living/carbon/proc/has_vagina()
	if(getorganslot("vagina"))
		return TRUE
	return FALSE

/mob/living/carbon/proc/has_breasts()
	if(getorganslot("breasts"))
		return TRUE
	return FALSE

/mob/living/carbon/proc/has_ovipositor()
	if(getorganslot("penis"))//shared slot
		if(istype(getorganslot("penis"), /obj/item/organ/genital/ovipositor))
			return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_eggsack()
	if(getorganslot("balls"))
		if(istype(getorganslot("balls"), /obj/item/organ/genital/eggsack))
			return TRUE
	return FALSE

/mob/living/carbon/human/proc/is_bodypart_exposed(bodypart)

/mob/living/carbon/proc/is_groin_exposed(var/list/L)
	if(!L)
		L = get_equipped_items()
	for(var/obj/item/I in L)
		if(I.body_parts_covered & GROIN)
			return FALSE
	return TRUE

/mob/living/carbon/proc/is_butt_exposed(var/list/L)
	if(!L)
		L = get_equipped_items()
	for(var/obj/item/I in L)
		if(I.body_parts_covered & GROIN)
			if(!I.do_not_cover_butt)
				return FALSE
			else
				return TRUE
	return TRUE
*/

/mob/living/carbon/proc/is_chest_exposed(var/list/L)
	if(!L)
		L = get_equipped_items()
	for(var/obj/item/I in L)
		if(I.body_parts_covered & CHEST)
			return FALSE
	return TRUE
