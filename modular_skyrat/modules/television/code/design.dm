/datum/design/pocket_tvcamera
	name = "Pocket TV Camera"
	id = "pocket_tvcamera"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 50, /datum/material/gold=100, /datum/material/plastic = 800, /datum/material/bluespace = 50)
	build_path = /obj/item/device/pocket_tvcamera
	category = list("initial","Misc")
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/tv_radio
	name = "Pocket TV Radio"
	id = "tv_radio"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 50)
	build_path = /obj/item/tv_radio
	category = list("initial","Misc")
