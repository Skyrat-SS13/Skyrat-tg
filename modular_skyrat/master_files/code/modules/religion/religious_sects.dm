/datum/religion_sect/on_select()
	. = ..()
	
	// if the same religious sect gets selected, carry the favor over
	if(istype(src, GLOB.prev_sect_type))
		set_favor(GLOB.prev_favor)
