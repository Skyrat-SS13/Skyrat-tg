//useless relics
/obj/item/xenoarch/useless_relic
	name = "useless relic"
	desc = "A useless relic that can be redeemed for cargo or research points."

/obj/item/xenoarch/useless_relic/Initialize()
	. = ..()
	icon_state = "useless[rand(1,8)]"

/datum/export/xenoarch/useless_relic
	cost = 400
	unit_name = "xenoarch item"
	export_types = list(/obj/item/xenoarch/useless_relic,
						/obj/item/xenoarch/broken_item)

/datum/export/xenoarch/useless_relic/sell_object(obj/O, datum/export_report/report, dry_run, apply_elastic = FALSE) //I really dont want them to feel gimped
	. = ..()

//broken items
/obj/item/xenoarch/broken_item
	name = "parent dev item"
	desc = "An item that has been damaged, destroyed for quite some time. It is possible to recover it."

/obj/item/xenoarch/broken_item/tech
	name = "broken tech"
	icon_state = "recover_tech"

/obj/item/xenoarch/broken_item/weapon
	name = "broken weapon"
	icon_state = "recover_weapon"

/obj/item/xenoarch/broken_item/illegal
	name = "broken unknown object"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/alien
	name = "broken unknown object"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/plant
	name = "withered plant"
	desc = "A plant that is long past its prime. It is possible to recover it."
	icon_state = "recover_plant"

/obj/item/xenoarch/broken_item/animal
	name = "preserved animal carcass"
	desc = "An animal that is long past its prime. It is possible to recover it."
	icon_state = "recover_animal"

/obj/item/xenoarch/broken_item/animal/Initialize()
	. = ..()
	var/pick_celltype = pick(CELL_LINE_TABLE_BEAR,
							CELL_LINE_TABLE_BLOBBERNAUT,
							CELL_LINE_TABLE_BLOBSPORE,
							CELL_LINE_TABLE_CARP,
							CELL_LINE_TABLE_CAT,
							CELL_LINE_TABLE_CHICKEN,
							CELL_LINE_TABLE_COCKROACH,
							CELL_LINE_TABLE_CORGI,
							CELL_LINE_TABLE_COW,
							CELL_LINE_TABLE_GELATINOUS,
							CELL_LINE_TABLE_GRAPE,
							CELL_LINE_TABLE_MEGACARP,
							CELL_LINE_TABLE_MOUSE,
							CELL_LINE_TABLE_PINE,
							CELL_LINE_TABLE_PUG,
							CELL_LINE_TABLE_SLIME,
							CELL_LINE_TABLE_SNAKE,
							CELL_LINE_TABLE_VATBEAST,
							CELL_LINE_TABLE_NETHER,)
	AddElement(/datum/element/swabable, pick_celltype, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/xenoarch/broken_item/clothing
	name = "petrified clothing"
	desc = "A piece of clothing that has long since lost its beauty."
	icon_state = "recover_clothing"

/datum/export/xenoarch/broken_item
	cost = 1000
	unit_name = "broken object"
	export_types = list(/obj/item/xenoarch/broken_item)

//circuit boards
/obj/item/circuitboard/machine/xenoarch_researcher
	name = "Xenoarch Researcher (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/xenoarch/researcher
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_scanner
	name = "Xenoarch Scanner (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/xenoarch/scanner
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_digger
	name = "Xenoarch Digger (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/xenoarch/digger
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_recoverer
	name = "Xenoarch Recoverer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/xenoarch/recoverer
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = TRUE
