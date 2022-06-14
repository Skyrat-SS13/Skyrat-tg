/obj/item/stack/sheet/mineral/stone
	name = "stone"
	desc = "Stone brick."
	singular_name = "stone block"
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "sheet-stone"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/stone=MINERAL_MATERIAL_AMOUNT)
	throwforce = 10
//	flags_1 = null
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/mineral/stone
	grind_results = null
	point_value = 0
//	tableVariant = /obj/structure/table/stone
	material_type = /datum/material/stone
	matter_amount = 0
//	cost = 500
	source = null
	walltype = /turf/closed/wall/mineral/stone

GLOBAL_LIST_INIT(stone_recipes, list ( \
	new/datum/stack_recipe("stone brick wall", /turf/closed/wall/mineral/stone, 5, one_per_turf = 1, on_floor = 1, applies_mats = TRUE), \
	new/datum/stack_recipe("stone brick tile", /obj/item/stack/tile/mineral/stone, 1, 4, 20),
	))

/obj/item/stack/sheet/mineral/stone/get_main_recipes()
	. = ..()
	. += GLOB.stone_recipes

/datum/material/stone
	name = "stone"
	desc = "It's stone."
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE, MAT_CATEGORY_ITEM_MATERIAL=TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/stone
	value_per_unit = 0.005
	beauty_modifier = 0.01

/obj/item/stack/ore/stone
	name = "unrefined stone"
	desc = "Chunks of high-quality stone. This could be cut into bricks to form a really good building material."
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "stone_ore"
	inhand_icon_state = "Iron ore"
	singular_name = "unrefined stone chunk"
	points = 1
	mats_per_unit = list(/datum/material/stone=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/stone
	mine_experience = 1
	scan_state = null
	spreadChance = 20
	merge_type = /obj/item/stack/ore/stone

/obj/item/stack/tile/mineral/stone
	name = "stone tile"
	singular_name = "stone floor tile"
	desc = "A tile made of stone bricks, for that fortress look."
	icon_state = "tile_herringbone"
	inhand_icon_state = "tile"
	turf_type = /turf/open/floor/stone
	mineralType = "stone"
	mats_per_unit = list(/datum/material/stone=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/stone

/turf/closed/wall/mineral/stone
	name = "stone wall"
	desc = "A wall made of solid stone brick."
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	sheet_type = /obj/item/stack/sheet/mineral/stone
	slicing_duration = 1.5 SECONDS  //literal rock
	explosion_block = 2
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_STONE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_STONE_WALLS)
	custom_materials = list(/datum/material/stone = 4000)

/turf/closed/indestructible/stone
	name = "stone wall"
	desc = "A wall made of solid stone brick."
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_STONE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_STONE_WALLS)
	custom_materials = list(/datum/material/stone = 4000)

/obj/structure/falsewall/stone
	name = "stone wall"
	desc = "A wall made of solid stone brick."
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	mineral = /obj/item/stack/sheet/mineral/stone
	walltype = /turf/closed/wall/mineral/stone
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_STONE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_STONE_WALLS)
