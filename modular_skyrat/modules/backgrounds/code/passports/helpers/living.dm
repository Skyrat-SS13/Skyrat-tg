/mob/living/proc/get_passport()
	if(!length(held_items)) // Early return for mobs without hands.
		return
	// Check hands
	var/obj/item/held_item = get_active_held_item()
	if(held_item) // Check active hand
		. = held_item.get_passport()
	if(!.) // If there is no id, check the other hand
		held_item = get_inactive_held_item()
		if(held_item)
			. = held_item.get_passport()

/mob/living/carbon/human/get_passport(hand_first = TRUE)
	. = ..()
	if(. && hand_first)
		return
	// Check inventory slots
	return (passport?.get_passport() || belt?.get_passport())
