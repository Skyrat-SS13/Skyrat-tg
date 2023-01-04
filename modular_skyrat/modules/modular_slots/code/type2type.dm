// Stuff that SS13 relies on for telling where a slot is on a character.
/slot2body_zone(slot)
	. = ..()
	if(slot == ITEM_SLOT_PASSPORT)
		return BODY_ZONE_CHEST
