/proc/make_datum_references_lists()
	. = ..()
	// Here we build the global list for all accessories
	for(var/path in subtypesof(/datum/sprite_accessory))
		var/datum/sprite_accessory/P = path
		if(initial(P.key) && !(initial(P.special)))
			P = new path()
			if(!GLOB.sprite_accessories[key])
				GLOB.sprite_accessories[key] = list()
			GLOB.sprite_accessories[key][P.name] = P
