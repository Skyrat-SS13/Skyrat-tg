/obj/item/organ/internal/brain/on_life(seconds_per_tick, times_fired) //All your horny is here *points to the head*
	. = ..()
	var/mob/living/carbon/human/brain_owner = owner
	if(istype(brain_owner, /mob/living/carbon/human) && brain_owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		if(!(organ_flags & ORGAN_FAILING))
			brain_owner.dna.species.handle_arousal(brain_owner, seconds_per_tick, times_fired)
