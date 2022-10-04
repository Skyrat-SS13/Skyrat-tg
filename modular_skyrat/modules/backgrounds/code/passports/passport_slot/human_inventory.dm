/mob/living/carbon/human/get_item_by_slot(slot_id)
	. = ..()
	if(slot_id == ITEM_SLOT_PASSPORT)
		return passport

/mob/living/carbon/human/get_slot_by_item(obj/item/looking_for)
	. = ..()
	if(looking_for == passport)
		return ITEM_SLOT_PASSPORT

/mob/living/carbon/human/get_body_slots()
	. = ..()
	. += passport

/mob/living/carbon/human/equip_to_slot(obj/item/item, slot, initial, redraw_mob)
	if(!..())
		return

	if(slot == ITEM_SLOT_PASSPORT)
		if(passport)
			return
		passport = item
		update_worn_passport()
		has_equipped(item, slot, initial)

/mob/living/carbon/human/modular_doUnEquip(obj/item/item)
	. = ..()
	if(item == passport)
		passport = null
		if(!QDELETED(src))
			update_worn_passport()
