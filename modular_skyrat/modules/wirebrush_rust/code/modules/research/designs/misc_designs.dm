/////////////////////////////////////////
////////////Janitor Designs//////////////
/////////////////////////////////////////

/datum/design/wirebrush
	name = "Wirebrush"
	desc = "A tool to start removing rust from walls."
	id = "wirebrush"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200)
	build_path = /obj/item/wirebrush
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/wirebrush_adv
	name = "Advanced Wirebrush"
	desc = "An advanced tool to start removing rust from walls."
	id = "wirebrush_adv"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/uranium = 200, /datum/material/plasma = 200)
	build_path = /obj/item/wirebrush/advanced
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE
