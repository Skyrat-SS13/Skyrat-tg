// This is required to be filled out for item slots to work at all.
/mob/living/carbon/human/get_item_by_slot(slot_id)
	. = ..()
	if(slot_id == ITEM_SLOT_PASSPORT)
		return passport

// Required for coder QoL.
/mob/living/carbon/human/get_slot_by_item(obj/item/looking_for)
	. = ..()
	if(looking_for == passport)
		return ITEM_SLOT_PASSPORT

// There are only head, body and storage slots. Nonmodular edits are required for anything else.
// Add your slot here. Do not null check.
/mob/living/carbon/human/get_body_slots()
	. = ..()
	. += passport

// Required for items to be equippable in a slot at all. Very important.
/mob/living/carbon/human/equip_to_slot(obj/item/item, slot, initial, redraw_mob)
	if(!..())
		return

	// Copy this and modify to point to your own slot. Monmodular edits are required to suppport extra unfiltered slots like pockets.
	if(slot == ITEM_SLOT_PASSPORT)
		if(passport)
			return
		passport = item
		update_worn_passport()
		has_equipped(item, slot, initial)

/// A proc that can be used by modules to modularly add an item to doUnEquip logic.
/mob/living/carbon/human/proc/modular_doUnEquip(obj/item/item)
	// Copy this and modify to point to your own slot.
	if(item == passport)
		passport = null
		if(!QDELETED(src))
			update_worn_passport()
