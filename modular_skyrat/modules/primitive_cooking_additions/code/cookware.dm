/obj/item/reagent_containers/cup/soup_pot/material
	icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/cookware.dmi'
	custom_materials = null // We're going to apply custom materials when this baby is actually made
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

// A few random preset types as well

/obj/item/reagent_containers/cup/soup_pot/material/fake_copper

/obj/item/reagent_containers/cup/soup_pot/material/fake_copper/Initialize(mapload)
	. = ..()
	set_custom_materials(list(GET_MATERIAL_REF(/datum/material/copporcitite) = SHEET_MATERIAL_AMOUNT))

/obj/item/reagent_containers/cup/soup_pot/material/fake_brass

/obj/item/reagent_containers/cup/soup_pot/material/fake_brass/Initialize(mapload)
	. = ..()
	set_custom_materials(list(GET_MATERIAL_REF(/datum/material/brussite) = SHEET_MATERIAL_AMOUNT))

/obj/item/reagent_containers/cup/soup_pot/material/fake_tin

/obj/item/reagent_containers/cup/soup_pot/material/fake_tin/Initialize(mapload)
	. = ..()
	set_custom_materials(list(GET_MATERIAL_REF(/datum/material/tinumium) = SHEET_MATERIAL_AMOUNT))

// Oven Trays
/obj/item/plate/oven_tray/material
	desc = "Time to bake hardtack!"
	icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/cookware.dmi'
	custom_materials = null // We're going to apply custom materials when this baby is actually made
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

// A few random preset types as well

/obj/item/plate/oven_tray/material/fake_copper

/obj/item/plate/oven_tray/material/fake_copper/Initialize(mapload)
	. = ..()
	set_custom_materials(list(GET_MATERIAL_REF(/datum/material/copporcitite) = SHEET_MATERIAL_AMOUNT))

/obj/item/plate/oven_tray/material/fake_brass

/obj/item/plate/oven_tray/material/fake_brass/Initialize(mapload)
	. = ..()
	set_custom_materials(list(GET_MATERIAL_REF(/datum/material/brussite) = SHEET_MATERIAL_AMOUNT))

/obj/item/plate/oven_tray/material/fake_tin

/obj/item/plate/oven_tray/material/fake_tin/Initialize(mapload)
	. = ..()
	set_custom_materials(list(GET_MATERIAL_REF(/datum/material/tinumium) = SHEET_MATERIAL_AMOUNT))

