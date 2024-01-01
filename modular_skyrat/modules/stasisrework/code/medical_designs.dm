/datum/design/stasisbag
	name = "Stasis Body Bag"
	desc = "A stasis body bag, powered by cryogenic stasis technology. It can hold only one body, but it prevents decay."
	id = "stasisbag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/bodybag/stasis
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/stasissleeper
	name = "Machine Design (Lifeform Stasis Unit)"
	desc = "The circuit board for a Stasis Unit"
	id = "stasissleeper"
	build_path = /obj/item/circuitboard/machine/stasissleeper
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
