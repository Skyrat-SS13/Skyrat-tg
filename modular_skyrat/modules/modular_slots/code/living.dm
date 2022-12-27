/// Gets the mob's current passport, if present. Purposefully doesn't support PDAs or wallets.
/mob/living/proc/get_passport()
	if(!length(held_items)) // Early return for mobs without hands.
		return
	// Check hands
	var/obj/item/held_item = get_active_held_item()
	if(held_item) // Check active hand
		return held_item
	if(!.) // If there is no id, check the other hand
		return held_item = get_inactive_held_item()
