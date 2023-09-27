// Machine categories

#define FABRICATOR_CATEGORY_FLATPACK_MACHINES "/Flatpacked Machines"
#define FABRICATOR_SUBCATEGORY_MANUFACTURING "/Manufacturing"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"
#define FABRICATOR_SUBCATEGORY_MATERIALS "/Materials"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_flatpacks
	id = "colony_fabricator_flatpacks"
	display_name = "Colony Fabricator Flatpack Designs"
	description = "Contains all of the colony fabricator's flatpack machine designs."
	design_ids = list(
		"flatpack_solar_panel",
		"flatpack_solar_tracker",
		"flatpack_arc_furnace",
		"flatpack_colony_fab",
		"flatpack_station_battery",
		"flatpack_station_battery_large",
		"flatpack_fuel_generator",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000000000000000) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Lets the colony lathe make more colony lathes but at very hihg cost, for fun

/datum/design/flatpack_colony_fabricator
	name = "Flatpacked Colony Fabricator"
	id = "flatpack_colony_fab"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Solar panels and trackers

/datum/design/flatpack_solar_panel
	name = "Flatpacked Solar Panel"
	id = "flatpack_solar_panel"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1,
	)
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
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.5,
	)
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
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/flatpacked_machine/arc_furnace
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 15 SECONDS

// Power storage structures

/datum/design/flatpack_power_storage
	name = "Flatpacked Stationary Battery"
	id = "flatpack_station_battery"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/station_battery
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 20 SECONDS

/datum/design/flatpack_power_storage_large
	name = "Flatpacked Large Stationary Battery"
	id = "flatpack_station_battery_large"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/large_station_battery
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 40 SECONDS

// Power storage structures

/datum/design/flatpack_solids_generator
	name = "Flatpacked Solid Fuel Generator"
	id = "flatpack_fuel_generator"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/fuel_generator
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

#undef FABRICATOR_CATEGORY_FLATPACK_MACHINES
#undef FABRICATOR_SUBCATEGORY_MANUFACTURING
#undef FABRICATOR_SUBCATEGORY_POWER
#undef FABRICATOR_SUBCATEGORY_MATERIALS
