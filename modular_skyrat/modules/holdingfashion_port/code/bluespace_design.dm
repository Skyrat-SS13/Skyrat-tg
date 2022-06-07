/datum/design/satchel_holding
	name = "Inert Satchel of Holding"
	desc = "A block of metal ready to be transformed into a satchel of holding with a bluespace anomaly core."
	id = "satchel_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 3000, /datum/material/diamond = 1500, /datum/material/uranium = 250, /datum/material/bluespace = 2000)
	build_path = /obj/item/satchel_of_holding_inert
	category = list("Bluespace Designs")
	dangerous_construction = TRUE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/duffel_holding
	name = "Inert Duffel Bag of Holding"
	desc = "A block of metal ready to be transformed into a duffel bag of holding with a bluespace anomaly core."
	id = "duffel_holding"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 3000, /datum/material/diamond = 1500, /datum/material/uranium = 250, /datum/material/bluespace = 2000)
	build_path = /obj/item/duffel_of_holding_inert
	category = list("Bluespace Designs")
	dangerous_construction = TRUE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
