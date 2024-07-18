/datum/design/board/circulator
	name = "Machine Design (Circulator Board)"
	desc = "The circuit board for a circulator."
	id = "circulator"
	build_path = /obj/item/circuitboard/machine/circulator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/teg
	name = "Machine Design (TEG Board)"
	desc = "The circuit board for a TEG."
	id = "teg"
	build_path = /obj/item/circuitboard/machine/thermoelectric_generator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/adv_power_skyrat
	id = "adv_power_skyrat"
	display_name = "Additional Advanced Power Manipulation"
	description = "How to get different types of zap."
	prereq_ids = list("parts_adv")
	design_ids = list("teg", "circulator")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_capacitors = TECHWEB_TIER_3_POINTS)
