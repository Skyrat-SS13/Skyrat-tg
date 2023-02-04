//////////////////////////////////////////
////////////Nebula Designs////////////////
//////////////////////////////////////////

/datum/design/healthanalyzer
	name = "Death Alarm Implant Case"
	id = "deathalarmimplant"
	build_type =  PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = 10000,
		/datum/material/silver = 10000,
		/datum/material/diamond = 10000,
		/datum/material/gold = 4000,
		/datum/material/glass = 2000,
	)
	build_path = /obj/item/implantcase/deathalarm
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
