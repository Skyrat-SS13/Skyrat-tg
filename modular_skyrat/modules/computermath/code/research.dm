/datum/design/computermath
	name = "Problem Computer"
	desc = "Solve math problems. Get them correct, get credits."
	id = "computermath"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 250, /datum/material/glass = 250, /datum/material/plastic = 250)
	build_path = /obj/item/computermath/default
	category = list("Tool Designs")
	departmental_flags =  DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SCIENCE

/datum/techweb_node/computermath
	id = "computermath"
	display_name = "Problem Computer"
	description = "Solve problems for either cargo credits or research points."
	prereq_ids = list("base")
	design_ids = list("computermath")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)