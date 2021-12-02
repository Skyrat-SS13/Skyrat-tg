/turf/open/floor/material/meat
	custom_materials = list(/datum/material/meat = MINERAL_MATERIAL_AMOUNT / 4)

/turf/open/floor/material/meat/inedible/Initialize()
	. = ..()
	qdel(GetComponent(/datum/component/edible))
