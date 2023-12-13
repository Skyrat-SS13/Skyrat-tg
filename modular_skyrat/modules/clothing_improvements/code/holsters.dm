/obj/item/clothing/suit/Initialize(mapload)
	// holsters originally are in /obj/item/clothing/suit's base allowed list, often replaced by subtype definitions.
	// here, we just add it to the allowed list of *all* suit clothing items. billions must holster
	. = ..()
	if(!locate(/obj/item/storage/belt/holster) in allowed)
		allowed += list(/obj/item/storage/belt/holster)

/obj/item/storage/belt/holster
	// use a pen to rename your holster to something based (or cringe if that's your jam)
	obj_flags = UNIQUE_RENAME
