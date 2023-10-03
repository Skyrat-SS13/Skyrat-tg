// Machine categories

#define FABRICATOR_CATEGORY_APPLIANCES "/Appliances"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_appliances
	id = "colony_fabricator_applicanes"
	display_name = "Colony Fabricator Appliance Designs"
	description = "Contains all of the colony fabricator's appliance machine designs."
	design_ids = list(
		"wall_multi_cell_rack",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000000000000000) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Lets the colony lathe make more colony lathes but at very hihg cost, for fun

/datum/design/wall_mounted_multi_charger
	name = "Mounted Multi-Cell Charging Rack"
	id = "wall_multi_cell_rack"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/wallframe/cell_charger_multi
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 15 SECONDS

#undef FABRICATOR_CATEGORY_APPLIANCES
#undef FABRICATOR_SUBCATEGORY_POWER
