/obj/item/circuitboard/machine/rna_recombinator
	name = "RNA Recombinator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/rna_recombinator
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/servo = 2,
		/datum/stock_part/micro_laser = 2,
	)

/datum/techweb_node/mutanttech
	id = TECHWEB_NODE_MUTANT_TECH
	display_name = "Advanced Nanotrasen Viral Bioweapons Technology"
	description = "Research devices from the Nanotrasen viral bioweapons division! Got a virus problem? This'll save your day."
	prereq_ids = list("exp_tools", "cytology")
	design_ids = list("rna_vial", "rna_extractor", "rna_recombinator")
	research_costs = list(TECHWEB_NODE_SURGERY_TOOLS, TECHWEB_NODE_CYTOLOGY)

/datum/design/rna_vial
	name = "Empty RNA vial"
	desc = "An empty RNA vial for storing genetic information."
	id = "rna_vial"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rna_vial
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/rna_extractor
	name = "RNA Extractor Device"
	desc = "An RNA extraction device, use this on any subect you'd like to extract RNA data from, needs RNA vials to work."
	id = "rna_extractor"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rna_extractor
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/board/rna_recombinator
	name = "Machine Design (RNA Recombinator)"
	desc = "The MRNA Recombinator is one of Nanotrasens most advanced technologies and allows the exact recombination of virus RNA."
	id = "rna_recombinator"
	build_path = /obj/item/circuitboard/machine/rna_recombinator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL
