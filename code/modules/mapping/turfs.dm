/turf/open/floor/material/meat
	custom_materials = list(/datum/material/meat = MINERAL_MATERIAL_AMOUNT * 0.25)

/turf/closed/wall/material/meat
	custom_materials = list(/datum/material/meat = MINERAL_MATERIAL_AMOUNT * 2)

/turf
	var/prevent_rcd_deconstruction = FALSE

/turf/closed/wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	if(prevent_rcd_deconstruction)
		return FALSE
	return ..()
