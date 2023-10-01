/datum/techweb_node/colony_fabricator_special_tools
	id = "colony_fabricator_tools"
	display_name = "Colony Fabricator Tool Designs"
	description = "Contains all of the colony fabricator's tool designs."
	design_ids = list(
		"colony_power_drive",
		"colony_prybar",
		"colony_arc_welder",
		"colony_compact_drill",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000000000000000) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Screw-Wrench-Wirecutter combo machine

/datum/design/colony_power_driver
	name = "Powered Driver"
	id = "colony_power_drive"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/screwdriver/omni_drill
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Crowbar that is completely normal except it can force doors

/datum/design/colony_door_crowbar
	name = "Prybar"
	id = "colony_prybar"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/crowbar/large/doorforcer
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Welder that takes no fuel or power to run but is quite slow, at least it sounds cool as hell

/datum/design/colony_arc_welder
	name = "Arc Welder"
	id = "colony_arc_welder"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/weldingtool/electric/arc_welder
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED,
	)

// Slightly slower drill that fits in backpacks

/datum/design/colony_compact_drill
	name = "Compact Mining Drill"
	id = "colony_compact_drill"
	build_type = COLONY_FABRICATOR
	build_path = /obj/item/pickaxe/drill/compact
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING,
	)

// Various designs that get added to the colony fab

/datum/design/holosignatmos/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/analyzer/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/extinguisher/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/cable_coil/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/airlock_painter/decal/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/airlock_painter/decal/tile/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/holosignengi/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/inducer/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/multitool/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/tscanner/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/pipe_painter/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/rwd/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/bolter_wrench/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/rpd/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/rpd_upgrade/unwrench/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/rtd_loaded/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/rcd_ammo/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/light_replacer/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/rld_mini/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/miningsatchel_holding/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/mining_scanner/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/flashlight/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/ducts/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/plumbing_rcd/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/plunger/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/handlabeler/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/paperroll/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/spraycan/New()
	. = ..()
	build_type |= COLONY_FABRICATOR
