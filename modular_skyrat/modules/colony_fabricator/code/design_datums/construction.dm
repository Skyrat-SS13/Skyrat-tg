// Look, I had to make its name start with A so it'd be top of the list, fight me

#define FABRICATOR_SUBCATEGORY_STRUCTURES "/Autofab Structures"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_structures
	id = "colony_fabricator_structures"
	display_name = "Colony Fabricator Structure Designs"
	description = "Contains all of the colony fabricator's structure designs."
	design_ids = list(
		"prefab_airlock_kit",
		"prefab_shutters_kit",
		"prefab_catwalk_kit",
		"prefab_floor_tile",
		"prefab_cat_floor_tile",
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
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
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
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 30 SECONDS

// Catwalk kit

/datum/design/prefab_catwalk_kit
	name = "Prefab Catwalk"
	id = "prefab_catwalk_kit"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/catwalk_kit
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 15 SECONDS

// Catwalk kit

/datum/design/prefab_wall_kit
	name = "Prefab Wall Kit"
	id = "prefab_wall_kit"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/flatpacked_machine/wall_kit
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 15 SECONDS

// Fancy floor tiles

/datum/design/prefab_floor_tile
	name = "Prefab Floor Tile"
	id = "prefab_floor_tile"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/stack/tile/iron/colony/lathe_spawn
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 15 SECONDS

// Fancy catwalk floor tiles

/datum/design/prefab_cat_floor_tile
	name = "Prefab Catwalk Plating"
	id = "prefab_cat_floor_tile"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/stack/tile/catwalk_tile/colony_lathe/lathe_spawn
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_APPLIANCES + FABRICATOR_SUBCATEGORY_POWER,
	)
	construction_time = 15 SECONDS

