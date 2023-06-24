/datum/design/satchel_holding
	name = "Inert Satchel of Holding"
	desc = "A block of metal ready to be transformed into a satchel of holding with a bluespace anomaly core."
	id = "satchel_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/satchel_of_holding_inert
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/duffel_holding
	name = "Inert Duffel Bag of Holding"
	desc = "A block of metal ready to be transformed into a duffel bag of holding with a bluespace anomaly core."
	id = "duffel_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/duffel_of_holding_inert
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_BLUESPACE)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
