// Look, I had to make its name start with A so it'd be top of the list, fight me

#define FABRICATOR_SUBCATEGORY_STRUCTURES "/Autofab Structures"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_structures
	id = "colony_fabricator_structures"
	display_name = "Colony Fabricator Structure Designs"
	description = "Contains all of the colony fabricator's structure designs."
	design_ids = list(
		"prefab_airlock_kit",
		"prefab_manual_airlock_kit",
		"prefab_shutters_kit",
		"prefab_floor_tile",
		"prefab_cat_floor_tile",
		"colony_fab_plastic_wall_panel",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000000000000000) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Airlock kit

/datum/design/prefab_airlock_kit
	name = "Prefab Airlock"
	id = "prefab_airlock_kit"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/flatpacked_machine/airlock_kit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 30 SECONDS

// Manul Airlock kit

/datum/design/prefab_manual_airlock_kit
	name = "Prefab Manual Airlock"
	id = "prefab_manual_airlock_kit"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/flatpacked_machine/airlock_kit_manual
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 30 SECONDS

// Shutters kit

/datum/design/prefab_shutters_kit
	name = "Prefab Shutters"
	id = "prefab_shutters_kit"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/flatpacked_machine/shutter_kit
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 30 SECONDS

// Fancy floor tiles

/datum/design/prefab_floor_tile
	name = "Prefab Floor Tile x4"
	id = "prefab_floor_tile"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/stack/tile/iron/colony/lathe_spawn
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 15 SECONDS

// Fancy catwalk floor tiles

/datum/design/prefab_cat_floor_tile
	name = "Prefab Catwalk Plating x4"
	id = "prefab_cat_floor_tile"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/stack/tile/catwalk_tile/colony_lathe/lathe_spawn
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 15 SECONDS

// Plastic wall panels, twice the wall for the same price in plastic, efficient!

/datum/design/colony_fab_plastic_wall_panel
	name = "Plastic Paneling x10"
	id = "colony_fab_plastic_wall_panel"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5
	)
	build_path = /obj/item/stack/sheet/plastic_wall_panel/ten
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + FABRICATOR_SUBCATEGORY_STRUCTURES,
	)
	construction_time = 15 SECONDS

#undef FABRICATOR_SUBCATEGORY_STRUCTURES
