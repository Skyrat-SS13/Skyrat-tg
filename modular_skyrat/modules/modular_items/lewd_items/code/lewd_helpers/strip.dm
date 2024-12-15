/// Removes any and all clothing that the current mob may have on and transfers it to `transfer_destination` if applicable.
/mob/living/carbon/human/proc/strip_clothing(obj/item/transfer_destination)
	var/list/items = list()
	items |= get_all_gear(TRUE)
	for(var/found_item in items)
		if(istype(transfer_destination))
			transferItemToLoc(found_item ,transfer_destination)
			continue

		dropItemToGround(items)

	return TRUE


