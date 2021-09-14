/datum/design/mining_drill
	name = "Machine Design (Mining Drill)"
	desc = "Allows for the construction of circuit boards used to build a Mining Drill."
	id = "mining_drill"
	build_type = IMPRINTER
	materials = list(/datum/material/glass = 1000)
	build_path = /obj/item/circuitboard/machine/mining_drill
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/mining_brace
	name = "Machine Design (Mining Brace)"
	desc = "Allows for the construction of circuit boards used to build a Mining Brace."
	id = "mining_brace"
	build_type = IMPRINTER
	materials = list(/datum/material/glass = 1000)
	build_path = /obj/item/circuitboard/machine/mining_brace
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/metal_density_scanner
	name = "Metal Density Scanner"
	desc = "A scanner which allows detection of deep ore deposits."
	id = "metal_density_scanner"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 1000)
	build_path = /obj/item/metal_density_scanner
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/adv_metal_density_scanner
	name = "Advanced Metal Density Scanner"
	desc = "A scanner which allows detection of deep ore deposits, this one can make an accurate readout and detect exactly which ores are underneath."
	id = "adv_metal_density_scanner"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 1000, /datum/material/gold = 500)
	build_path = /obj/item/metal_density_scanner/adv
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO
