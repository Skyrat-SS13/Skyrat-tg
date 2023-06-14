// Reasoning behind this: silly? perhaps. Spamming a hundred banana peels being good for RP? not so much
// This is unfortunately mapped into maps instead of being loot/a spawner, so we're forced to remove it this way

/obj/item/clothing/shoes/clown_shoes/banana_shoes/Initialize(mapload)
	..()
	return INITIALIZE_HINT_QDEL
