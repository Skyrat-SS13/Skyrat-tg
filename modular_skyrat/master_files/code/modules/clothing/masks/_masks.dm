// Make sure that these get drawn over the snout layer if the mob has a snout
/obj/item/clothing/mask/visual_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot & ITEM_SLOT_MASK)
		if(!(flags_inv & HIDESNOUT) && (user.dna.species.bodytype & BODYTYPE_SNOUTED))
			alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
			user.update_worn_mask()
	
/obj/item/clothing/mask/dropped(mob/living/carbon/human/user)
	. = ..()
	alternate_worn_layer = initial(alternate_worn_layer)
