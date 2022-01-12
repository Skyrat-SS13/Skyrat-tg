/*
	This handles the slowing effects of injured legs, feet and any other locmotion limbs
*/
/datum/extension/updating/impaired_locomotion
	statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE = 1,
	STATMOD_EVASION = 0)

	/*
		Maximum penalty when all locomotion limbs are completely gone
		50% speed penalty may not seem like enough for missing both legs, but you'll be crawling, in pain, and in shock
		as well, and those add their own penalties
	*/
	var/total_max_slowdown = 0.5
	var/impairment	=	0

/datum/extension/updating/impaired_locomotion/update()
	var/mob/living/carbon/human/H = holder
	if (istype(H))
		var/total_limbs = length(H.species.locomotion_limbs)
		if (!total_limbs)
			//Should never happen
			remove_self()
			return

		var/total_impairment = 0

		for (var/organ_tag in H.species.locomotion_limbs)
			var/obj/item/organ/external/E = H.get_organ(organ_tag)
			if(!E || E.is_stump() || E.status & ORGAN_CUT_AWAY)
				total_impairment += 1
			else if(E.status & ORGAN_IMPAIRED_LOCOMOTION)
				if (E.splinted)
					total_impairment += 0.25
				else
					total_impairment += 0.5

		if (!total_impairment)
			//All our limbs are healed/fine, we're done here
			remove_self()
			return

		impairment = total_impairment / total_limbs
		var/slowdown = total_max_slowdown * impairment
		statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE = (1-slowdown),
		STATMOD_EVASION = -10 * impairment)

		update_statmods()