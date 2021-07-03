/datum/design/hammercm1
	name = "Hammer (cm 1)"
	desc = "A hammer that can slowly remove debris on a strange rock."
	id = "hammercm1"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/hammer/cm1
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/hammercm2
	name = "Hammer (cm 2)"
	desc = "A hammer that can slowly remove debris on a strange rock."
	id = "hammercm2"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/hammer/cm2
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/hammercm3
	name = "Hammer (cm 3)"
	desc = "A hammer that can slowly remove debris on a strange rock."
	id = "hammercm3"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/hammer/cm3
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/hammercm5
	name = "Hammer (cm 5)"
	desc = "A hammer that can slowly remove debris on a strange rock."
	id = "hammercm5"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/hammer/cm5
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/hammercm10
	name = "Hammer (cm 10)"
	desc = "A hammer that can slowly remove debris on a strange rock."
	id = "hammercm10"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/hammer/cm10
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/bas_brush
	name = "Brush"
	desc = "A brush that can slowly remove debris on a strange rock."
	id = "bas_brush"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/brush
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/xeno_tape
	name = "Xenoarch Tape Measure"
	desc = "A tape measure used to measure the dug depth of strange rocks."
	id = "xeno_tape"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/xenoarch/tape_measure
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/xeno_bag
	name = "Xenoarch Bag"
	desc = "A bag that can hold strange rocks."
	id = "xeno_bag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/storage/bag/xenoarch
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/xeno_belt
	name = "Xenoarch Belt"
	desc = "A belt that can hold all of the essential tools for xenoarchaeology."
	id = "xeno_belt"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500)
	build_path = /obj/item/storage/belt/utility/xenoarch
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/adv_hammer
	name = "Advanced Hammer"
	desc = "A hammer that can slowly remove debris on a strange rock. Can also change digging depths."
	id = "adv_hammer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/diamond = 500)
	build_path = /obj/item/xenoarch/hammer/adv
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/adv_brush
	name = "Advanced Brush"
	desc = "A brush that can slowly remove debris on a strange rock."
	id = "adv_brush"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/diamond = 500)
	build_path = /obj/item/xenoarch/brush/adv
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/adv_bag
	name = "Advanced Xenoarch Bag"
	desc = "A bag that can hold strange rocks."
	id = "adv_bag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/diamond = 500)
	build_path = /obj/item/storage/bag/xenoarch/adv
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/board/xeno_researcher
	name = "Machine Design (Xenoarch Researcher)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch researcher."
	id = "xeno_researcher"
	build_path = /obj/item/circuitboard/machine/xenoarch_researcher
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/xeno_digger
	name = "Machine Design (Xenoarch Digger)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch digger."
	id = "xeno_digger"
	build_path = /obj/item/circuitboard/machine/xenoarch_digger
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/xeno_scanner
	name = "Machine Design (Xenoarch Scanner)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch scanner."
	id = "xeno_scanner"
	build_path = /obj/item/circuitboard/machine/xenoarch_scanner
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/xeno_recoverer
	name = "Machine Design (Xenoarch Recoverer)"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch recoverer."
	id = "xeno_recoverer"
	build_path = /obj/item/circuitboard/machine/xenoarch_recoverer
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/techweb_node/basic_xenoarch
	id = "basic_xenoarch"
	starting_node = TRUE
	display_name = "Basic Xenoarchaeology"
	description = "The basic designs of xenoarchaeology."
	design_ids = list(
		"hammercm1",
		"hammercm2",
		"hammercm3",
		"hammercm5",
		"hammercm10",
		"bas_brush",
		"xeno_tape",
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
		"xeno_digger",
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
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
