// Machine categories

#define FABRICATOR_CATEGORY_FLATPACK_MACHINES "/Flatpacked Machines"
#define FABRICATOR_SUBCATEGORY_MANUFACTURING "/Manufacturing"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"
#define FABRICATOR_SUBCATEGORY_MATERIALS "/Materials"
#define FABRICATOR_SUBCATEGORY_ATMOS "/Atmospherics"

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
		"flatpack_rtg",
		"flatpack_thermo",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000000000000000) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Lets the colony lathe make more colony lathes but at very hihg cost, for fun

/datum/design/flatpack_colony_fabricator
	name = "Flat-packed Colony Fabricator"
	desc = "A deployable fabricator capable of producing other flat-packed machines and other special equipment tailored for \
		rapidly constructing functional structures given resources and power. While it cannot be upgraded, it can be repacked \
		and moved to any location you see fit."
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
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MANUFACTURING,
	)
	construction_time = 30 SECONDS

// Solar panels and trackers

/datum/design/flatpack_solar_panel
	name = "Flat-packed Solar Panel"
	desc = "A deployable solar panel, able to be repacked after placement for relocation or recycling."
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
	name = "Flat-packed Solar Tracker"
	desc = "A deployable solar tracker, able to be repacked after placement for relocation or recycling."
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
	name = "Flat-packed Arc Furnace"
	desc = "A deployable furnace for refining ores. While slower and less safe than conventional refining methods, \
		it multiplies the output of refined materials enough to still outperform simply recycling ore."
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
	name = "Flat-packed Stationary Battery"
	desc = "A deployable station-scale power cell with an overall low capacity, but high input and output rate."
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
	name = "Flat-packed Large Stationary Battery"
	desc = "A deployable station-scale power cell with an overall extremely high capacity, but low input and output rate."
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

// PACMAN generator but epic!!

/datum/design/flatpack_solids_generator
	name = "Flat-Packed S.O.F.I.E. Generator"
	desc = "A deployable plasma-burning generator capable of outperforming even upgraded P.A.C.M.A.N. type generators, \
		at expense of creating hot carbon dioxide exhaust."
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

// Buildable RTG that is quite radioactive

/datum/design/flatpack_rtg
	name = "Flat-packed Radioisotope Thermoelectric Generator"
	desc = "A deployable radioisotope generator capable of producing a practically free trickle of power. \
		Free if you can tolerate the radiation that the machine makes while deployed, that is."
	id = "flatpack_rtg"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/rtg
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Thermomachine with decent temperature change rate, but a limited max/min temperature

/datum/design/flatpack_thermomachine
	name = "Flat-packed Atmospheric Temperature Regulator"
	desc = "A deployable temperature control device for use with atmospherics pipe systems. \
		Limited in its temperature range, however comes with a higher than normal heat capacity."
	id = "flatpack_thermo"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/thermomachine
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_ATMOS,
	)
	construction_time = 20 SECONDS

#undef FABRICATOR_CATEGORY_FLATPACK_MACHINES
#undef FABRICATOR_SUBCATEGORY_MANUFACTURING
#undef FABRICATOR_SUBCATEGORY_POWER
#undef FABRICATOR_SUBCATEGORY_MATERIALS
#undef FABRICATOR_SUBCATEGORY_ATMOS
