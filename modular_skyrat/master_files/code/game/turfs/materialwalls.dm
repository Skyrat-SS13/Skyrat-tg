/turf/closed/wall/material/meat
	custom_materials = list(/datum/material/meat = MINERAL_MATERIAL_AMOUNT * 2)

/turf/closed/wall/material/meat/nonedible/Initialize()
	. = ..()
	qdel(GetComponent(/datum/component/edible))
