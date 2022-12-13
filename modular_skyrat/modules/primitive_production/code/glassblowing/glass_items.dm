/obj/item/reagent_containers/cup/bowl/generic_material/glass
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/reagent_containers/cup/beaker/generic_material/fancy_lookin/glass
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/plate/generic_material/glass
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/plate/large/generic_material/glass
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/plate/small/generic_material/glass
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/plate/oven_tray/generic_material/glass
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 0.5)

/// Glassblowing recipe datums

/datum/glassblowing_recipe
	/// What the resulting item is
	var/resulting_item
	/// What steps you need to get to this point, goes in order of (blowing, spinning, paddling, shearing, jacking)
	var/list/steps = list(0,0,0,0,0)

/datum/glassblowing_recipe/bowl
	resulting_item = /obj/item/reagent_containers/cup/bowl/generic_material/glass
	steps = list(2,2,2,0,3)

/datum/glassblowing_recipe/cup
	resulting_item = /obj/item/reagent_containers/cup/beaker/generic_material/fancy_lookin/glass
	steps = list(3,3,3,0,0)

/datum/glassblowing_recipe/small_plate
	resulting_item = /obj/item/plate/small/generic_material/glass
	steps = list(2,2,2,0,0)

/datum/glassblowing_recipe/plate
	resulting_item = /obj/item/plate/generic_material/glass
	steps = list(3,3,3,0,0)

/datum/glassblowing_recipe/large_plate
	resulting_item = /obj/item/plate/large/generic_material/glass
	steps = list(4,4,4,0,0)

/datum/glassblowing_recipe/oven_tray
	resulting_item = /obj/item/plate/oven_tray/generic_material/glass
	steps = list(3,3,3,0,0)

/datum/glassblowing_recipe/bottle
	resulting_item = /obj/item/reagent_containers/cup/glass/bottle/small
	steps = list(3,2,3,0,0)
