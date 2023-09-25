// Machine categories

#define FABRICATOR_CATEGORY_FLATPACK_MACHINES "/Flatpacked Machines"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"

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
