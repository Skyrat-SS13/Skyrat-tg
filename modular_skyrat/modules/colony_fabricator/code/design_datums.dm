// Machine categories

#define FABRICATOR_CATEGORY_FLATPACK_MACHINES "/Flatpacked Machines"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"
#define FABRICATOR_SUBCATEGORY_MATERIALS "/Materials"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator
	id = "colony_fabricator"
	display_name = "Colony Fabricator Designs"
	description = "Advanced designs for the colony fabricator, though you shouldn't be seeing this."
	design_ids = list(
		"flatpack_solar_panel",
		"flatpack_solar_tracker",
		"flatpack_arc_furnace",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000000000000000) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Solar panels and trackers

/datum/design/flatpack_solar_panel
	name = "Flatpacked Solar Panel"
	id = "flatpack_solar_panel"
	build_type = COLONY_FABRICATOR
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.75, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/flatpacked_machine/solar
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 5 SECONDS

/datum/design/flatpack_solar_tracker
	name = "Flatpacked Solar Tracker"
	id = "flatpack_solar_tracker"
	build_type = COLONY_FABRICATOR
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.5)
	build_path = /obj/item/flatpacked_machine/solar_tracker
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 7 SECONDS

// Arc furance

/datum/design/flatpack_arc_furnace
	name = "Flatpacked Arc Furnace"
	id = "flatpack_arc_furnace"
	build_type = COLONY_FABRICATOR
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/flatpacked_machine/arc_furnace
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 15 SECONDS

#undef FABRICATOR_CATEGORY_FLATPACK_MACHINES
#undef FABRICATOR_SUBCATEGORY_POWER
#undef FABRICATOR_SUBCATEGORY_MATERIALS
