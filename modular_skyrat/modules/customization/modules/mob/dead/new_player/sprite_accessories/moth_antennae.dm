/datum/sprite_accessory/moth_antennae
	generic = "Moth Antennae"
	key = "moth_antennae"
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/wearer, obj/item/bodypart/bodypart)
	if(!wearer.head || !bodypart)
		return FALSE
//	Can hide if wearing hat
	if(key in wearer.try_hide_mutant_parts)
		return TRUE
//	Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return FALSE
//	Hide accessory if flagged to do so
	if((wearer.head.flags_inv & HIDEHAIR || (wearer.wear_mask && (wearer.wear_mask.flags_inv & HIDEHAIR))) \
		&& !(wearer.head.flags_inv & SHOWSPRITEEARS || wearer.wear_mask.flags_inv & SHOWSPRITEEARS))
		return TRUE



/obj/item/organ/external/antennae/can_draw_on_bodypart(mob/living/carbon/human/wearer)
	if(!wearer.head)
		return FALSE
//	Can hide if wearing hat
	if(feature_key in wearer.try_hide_mutant_parts)
		return FALSE
//	Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return TRUE
//	Hide accessory if flagged to do so
	if((wearer.head.flags_inv & HIDEHAIR || (wearer.wear_mask && (wearer.wear_mask.flags_inv & HIDEHAIR))) \
		&& !(wearer.head.flags_inv & SHOWSPRITEEARS || wearer.wear_mask.flags_inv & SHOWSPRITEEARS))
		return FALSE

