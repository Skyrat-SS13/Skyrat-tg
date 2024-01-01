// Make sure that these get drawn over the snout layer if the mob has a snout
/obj/item/clothing/glasses/visual_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot & ITEM_SLOT_EYES)
		if(!(user.bodytype & BODYTYPE_ALT_FACEWEAR_LAYER))
			return
		if(!isnull(alternate_worn_layer) && alternate_worn_layer < BODY_FRONT_LAYER) // if the alternate worn layer was already lower than snouts then leave it be
			return

		alternate_worn_layer = ABOVE_BODY_FRONT_GLASSES_LAYER
		user.update_worn_glasses()

/obj/item/clothing/glasses/dropped(mob/living/carbon/human/user)
	. = ..()
	alternate_worn_layer = initial(alternate_worn_layer)
