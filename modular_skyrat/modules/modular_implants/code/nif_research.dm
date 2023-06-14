/datum/design/nifsoft_remover
	name = "Lopland 'Wrangler' NIF-Cutter"
	desc = "A small device that lets the user remove NIFSofts from a NIF user"
	id = "nifsoft_remover"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/nifsoft_remover
	materials = list(/datum/material/iron = 200, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nifsoft_money_sense
	name = "Automatic Appraisal NIFSoft"
	desc = "A NIFSoft datadisk containing Automatic Appraisal"
	id = "nifsoft_money_sense"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/disk/nifsoft_uploader/money_sense
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/soulcatcher_device
	name = "Evoker-Type RSD"
	desc = "An RSD instrument that lets the user pull the consciousness from a body and store it virtually."
	id = "soulcatcher_device"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/handheld_soulcatcher
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

