/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/wearer)
	var/list/used_in_turf = list("tail")
	// Emote exception
	if(wearer.owned_turf?.name in used_in_turf)
		return TRUE

	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	if(wearer.wear_suit)
		// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE

		// Hide accessory if flagged to do so
		else if(wearer.wear_suit.flags_inv & HIDETAIL)
			return TRUE

	return FALSE
