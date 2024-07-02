GLOBAL_LIST_EMPTY(simple_research)

/datum/simple_research
	///the item that results from successful research symbols
	var/research_item
	///the item that, if you hit the probability from research skill, will spawn instead
	var/skilled_item
	///any pre-req items for this simple research
	var/list/required_items = list()

/**
 * 19 items
 */
/datum/simple_research/scanner
	research_item = /obj/item/stock_parts/scanning_module
	skilled_item = /obj/item/stock_parts/scanning_module/adv

/datum/simple_research/capacitor
	research_item = /obj/item/stock_parts/capacitor
	skilled_item = /obj/item/stock_parts/capacitor/adv

/datum/simple_research/servo
	research_item = /obj/item/stock_parts/servo
	skilled_item = /obj/item/stock_parts/servo/nano

/datum/simple_research/micro_laser
	research_item = /obj/item/stock_parts/micro_laser
	skilled_item = /obj/item/stock_parts/micro_laser/high

/datum/simple_research/matter_bin
	research_item = /obj/item/stock_parts/matter_bin
	skilled_item = /obj/item/stock_parts/matter_bin/adv

/datum/simple_research/cell
	research_item = /obj/item/stock_parts/power_store/cell
	skilled_item = /obj/item/stock_parts/power_store/cell/high

/datum/simple_research/cable
	research_item = /obj/item/stack/cable_coil/five
	skilled_item = /obj/item/stack/cable_coil

/datum/simple_research/part_replacer
	research_item = /obj/item/storage/part_replacer
	skilled_item = /obj/item/storage/part_replacer/bluespace
	required_items = list(
		/datum/simple_research/cable,
	)

/datum/simple_research/protolathe
	research_item = /obj/item/circuitboard/machine/protolathe/offstation
	required_items = list(
		/datum/simple_research/part_replacer,
	)

/datum/simple_research/circuit_imprinter
	research_item = /obj/item/circuitboard/machine/circuit_imprinter/offstation
	required_items = list(
		/datum/simple_research/part_replacer,
	)

/datum/simple_research/rdconsole
	research_item = /obj/item/circuitboard/computer/rdconsole
	required_items = list(
		/datum/simple_research/protolathe,
		/datum/simple_research/circuit_imprinter,
	)

/datum/simple_research/pipe_dispenser
	research_item = /obj/item/pipe_dispenser
	skilled_item = /obj/item/pipe_dispenser/bluespace
	required_items = list(
		/datum/simple_research/multitool,
	)

/datum/simple_research/inducer
	research_item = /obj/item/inducer/empty
	skilled_item = /obj/item/inducer/syndicate
	required_items = list(
		/datum/simple_research/cell,
	)

/datum/simple_research/pacman
	research_item = /obj/item/circuitboard/machine/pacman
	skilled_item = /obj/item/circuitboard/machine/rtg
	required_items = list(
		/datum/simple_research/cell,
	)

/datum/simple_research/smes
	research_item = /obj/item/circuitboard/machine/smes
	required_items = list(
		/datum/simple_research/pacman,
	)

/datum/simple_research/drill
	research_item = /obj/item/pickaxe/drill
	skilled_item = /obj/item/pickaxe/drill/diamonddrill

/datum/simple_research/chem_dispenser
	research_item = /obj/item/circuitboard/machine/chem_dispenser
	required_items = list(
		/datum/simple_research/igniter,
		/datum/simple_research/condenser,
	)

/datum/simple_research/igniter
	research_item = /obj/item/assembly/igniter

/datum/simple_research/condenser
	research_item = /obj/item/assembly/igniter/condenser

/datum/simple_research/multitool
	research_item = /obj/item/multitool
	skilled_item = /obj/item/multitool/abductor
