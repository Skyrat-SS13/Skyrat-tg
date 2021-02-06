/datum/techweb_node/sizeplaytech
	id = "sizeplaytech"
	display_name = "Size Alteration Technology"
	description = "Portable shrink-rays and god knows what else. Science is going too far."
	prereq_ids = list("biotech", "engineering")
	boost_item_paths = list(/obj/item/gun/energy/sizegun)
	design_ids = list("sizeray")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	hidden = TRUE

/datum/design/sizeray
	name = "Size Ray Gun"
	desc = "A portable size alteration ray emitter."
	id = "sizeray"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4000,/datum/material/uranium = 2000 ,/datum/material/plasma = 4000)
	build_path = /obj/item/gun/energy/sizegun
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
