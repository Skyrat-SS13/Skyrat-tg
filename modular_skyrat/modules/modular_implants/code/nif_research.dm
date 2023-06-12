/datum/design/nifsoft_remover
	name = "Lopland 'Wrangler' NIF-Cutter"
	desc = "A small device that lets the user remove NIFSofts from a NIF user"
	id = "nifsoft_remover"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/nifsoft_remover
	materials = list(/datum/material/iron = 200, /datum/material/silver = 500, /datum/material/uranium = 500)
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/nifsoft_money_sense
	name = "Automatic Appraisal NIFSoft"
	desc = "A NIFSoft datadisk containing Automatic Appraisal"
	id = "nifsoft_money_sense"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/disk/nifsoft_uploader/money_sense
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 1000, /datum/material/plastic = 2000)
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/soulcatcher_device
	name = "Evoker-Type RSD"
	desc = "An RSD instrument that lets the user pull the consciousness from a body and store it virtually."
	id = "soulcatcher_device"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/handheld_soulcatcher
	materials = list(/datum/material/iron = 6000, /datum/material/silver = 2000, /datum/material/bluespace = 2000)
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

