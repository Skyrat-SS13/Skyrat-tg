/datum/design/mre_board
	name = "MRE Vendor Board"
	id = "mre_board"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/circuitboard/machine/vending/mre_board
	category = list("initial", "Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE
