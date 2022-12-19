/obj/item/update_slot_icon()
	if(!ismob(loc))
		return
	. = ..()

	var/mob/owner = loc
	if(slot_flags & ITEM_SLOT_PASSPORT)
		owner.update_worn_passport()
