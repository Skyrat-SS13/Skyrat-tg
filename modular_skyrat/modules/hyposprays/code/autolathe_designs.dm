/datum/design/hypoviallarge
	name = "Large Hypovial"
	id = "large_hypovial"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 2500)
	build_path = /obj/item/reagent_containers/glass/vial/large
	category = list("initial","Medical","Medical Designs")
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/pen
	name = "Pen"
	id = "pen"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 32, /datum/material/glass = 8)
	build_path = /obj/item/pen
	category = list("initial", "Misc")
