/datum/design/xeno_hammer
	desc = "A hammer that can slowly remove debris on a strange rock."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/xeno_hammer/hammercm1
	name = "Hammer (cm 1)"
	id = "hammercm1"
	build_path = /obj/item/xenoarch/hammer/cm1

/datum/design/xeno_hammer/hammercm2
	name = "Hammer (cm 2)"
	id = "hammercm2"
	build_path = /obj/item/xenoarch/hammer/cm2

/datum/design/xeno_hammer/hammercm3
	name = "Hammer (cm 3)"
	id = "hammercm3"
	build_path = /obj/item/xenoarch/hammer/cm3

/datum/design/xeno_hammer/hammercm4
	name = "Hammer (cm 4)"
	id = "hammercm4"
	build_path = /obj/item/xenoarch/hammer/cm4

/datum/design/xeno_hammer/hammercm5
	name = "Hammer (cm 5)"
	id = "hammercm5"
	build_path = /obj/item/xenoarch/hammer/cm5

/datum/design/xeno_hammer/hammercm6
	name = "Hammer (cm 6)"
	id = "hammercm6"
	build_path = /obj/item/xenoarch/hammer/cm6

/datum/design/xeno_hammer/hammercm10
	name = "Hammer (cm 10)"
	id = "hammercm10"
	build_path = /obj/item/xenoarch/hammer/cm10

/datum/design/bas_brush
	name = "Brush"
	desc = "A brush that can slowly remove debris on a strange rock."
	id = "bas_brush"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/brush
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/xeno_tape
	name = "Xenoarch Tape Measure"
	desc = "A tape measure used to measure the dug depth of strange rocks."
	id = "xeno_tape"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/tape_measure
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/xeno_hh_scanner
	name = "Xenoarch Handheld Scanner"
	desc = "A handheld scanner for strange rocks. It tags the depths to the rock."
	id = "xeno_hh_scanner"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/handheld_scanner
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/xeno_hh_scanner/advanced
	name = "Xenoarch Advanced Handheld Scanner"
	id = "xeno_hh_scanner_advanced"
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/diamond = 500)
	build_path = /obj/item/xenoarch/handheld_scanner/advanced
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/xeno_hh_recoverer
	name = "Xenoarch Handheld Recoverer"
	desc = "An item that has the capabilities to recover items lost due to time."
	id = "xeno_hh_recoverer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/handheld_recoverer
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/xeno_bag
	name = "Xenoarch Bag"
	desc = "A bag that can hold strange rocks."
	id = "xeno_bag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/storage/bag/xenoarch
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/xeno_belt
	name = "Xenoarch Belt"
	desc = "A belt that can hold all of the essential tools for xenoarchaeology."
	id = "xeno_belt"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/storage/belt/utility/xenoarch
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/adv_hammer
	name = "Advanced Hammer"
	desc = "A hammer that can slowly remove debris on a strange rock. Can also change digging depths."
	id = "adv_hammer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/diamond = 500)
	build_path = /obj/item/xenoarch/hammer/adv
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/adv_brush
	name = "Advanced Brush"
	desc = "A brush that can slowly remove debris on a strange rock."
	id = "adv_brush"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/diamond = 500)
	build_path = /obj/item/xenoarch/brush/adv
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/adv_bag
	name = "Advanced Xenoarch Bag"
	desc = "A bag that can hold strange rocks."
	id = "adv_bag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/diamond = 500)
	build_path = /obj/item/storage/bag/xenoarch/adv
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO

/datum/design/board/xeno_researcher
	name = "Machine Design (Xenoarch Researcher)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch researcher."
	id = "xeno_researcher"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xeno_scanner
	name = "Machine Design (Xenoarch Scanner)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch scanner."
	id = "xeno_scanner"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xeno_recoverer
	name = "Machine Design (Xenoarch Recoverer)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch recoverer."
	id = "xeno_recoverer"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_recoverer
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xeno_digger
	name = "Machine Design (Xenoarch Digger)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch digger."
	id = "xeno_digger"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/techweb_node/basic_xenoarch
	id = "basic_xenoarch"
	starting_node = TRUE
	display_name = "Basic Xenoarchaeology"
	description = "The basic designs of xenoarchaeology."
	design_ids = list(
		"hammercm1",
		"hammercm2",
		"hammercm3",
		"hammercm4",
		"hammercm5",
		"hammercm6",
		"hammercm10",
		"bas_brush",
		"xeno_tape",
		"xeno_hh_scanner",
	)

/datum/techweb_node/xenoarch_storage
	id = "xenoarch_storage"
	display_name = "Xenoarchaeology Storage"
	description = "When dealing with xenoarchaeology, one may need storage."
	prereq_ids = list("basic_xenoarch")
	design_ids = list(
		"xeno_belt",
		"xeno_bag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)

/datum/techweb_node/xenoarch_machines
	id = "xenoarch_machines"
	display_name = "Xenoarchaeology Machines"
	description = "Sometimes, xenoarchaeology can be time consuming, perhaps machines can help?"
	prereq_ids = list("basic_xenoarch")
	design_ids = list(
		"xeno_researcher",
		"xeno_scanner",
		"xeno_recoverer",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)

/datum/techweb_node/adv_xenoarch
	id = "adv_xenoarch"
	display_name = "Advanced Xenoarchaeology"
	description = "After some time, those tools we used have become antiquated-- we need an upgrade."
	prereq_ids = list("basic_xenoarch", "xenoarch_machines", "xenoarch_storage")
	design_ids = list(
		"adv_hammer",
		"adv_brush",
		"adv_bag",
		"xeno_hh_scanner_advanced",
		"xeno_hh_recoverer",
		"xeno_digger",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
	required_experiments = list(/datum/experiment/scanning/points/xenoarch)

/datum/experiment/scanning/points/xenoarch
	name = "Advanced Xenoarchaeology Tools"
	description = "It is possible to create even more advanced tools for xenoarchaeoloy."
	required_points = 10
	required_atoms = list(
		/obj/item/xenoarch/useless_relic = 1,
		/obj/item/xenoarch/broken_item = 2,
	)
