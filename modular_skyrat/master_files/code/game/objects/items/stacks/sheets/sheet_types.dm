// Add modular crafting recipes here, NOT IN BASE /tg/ CRAFTING LISTS

/**
 * Add a list of recipes to an existing recipe sublist.
 *
 * Arguments:
 * * stack_recipes - the existing list of stack recipes.
 * * recipe_list_title - the title for the recipe list we're adding to
 * * appent_recipes - Add these recipes to the given recipe list.
 */
/proc/add_recipes_to_sublist(list/stack_recipes, recipe_list_title, list/append_recipes)
	for(var/datum/stack_recipe_list/sublist in stack_recipes)
		if(sublist.title != recipe_list_title)
			continue

		sublist.recipes += append_recipes
		return

	CRASH("Could not find recipe sublist [recipe_list_title] to add more recipes!")

// Iron

GLOBAL_LIST_INIT(skyrat_metal_recipes, list(
	new/datum/stack_recipe("wall mounted fire-safety closet", /obj/item/wallframe/firecloset, 2, time = 1.5 SECONDS, category = CAT_FURNITURE),
	new/datum/stack_recipe("wall mounted emergency closet", /obj/item/wallframe/emcloset, 2, time = 1.5 SECONDS,category = CAT_FURNITURE),
	new/datum/stack_recipe("wall mounted closet", /obj/item/wallframe/closet, 2, time = 1.5 SECONDS, category = CAT_FURNITURE),
	new/datum/stack_recipe("pool floor tile", /obj/item/stack/tile/iron/pool, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("lowered floor tile", /obj/item/stack/tile/iron/lowered, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("elevated floor tile", /obj/item/stack/tile/iron/elevated, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("wrestling turnbuckle", /obj/structure/wrestling_corner, 3, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("metal barricade", /obj/structure/deployable_barricade/metal, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("metal shelf", /obj/structure/rack/shelf, 1, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("anvil", /obj/structure/reagent_anvil, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("forge", /obj/structure/reagent_forge, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("throwing wheel", /obj/structure/throwing_wheel, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
))

GLOBAL_LIST_INIT(skyrat_metal_airlock_recipes, list(
	new /datum/stack_recipe("corporate airlock assembly", /obj/structure/door_assembly/door_assembly_corporate, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
	new /datum/stack_recipe("service airlock assembly", /obj/structure/door_assembly/door_assembly_service, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
))

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_metal_recipes
	add_recipes_to_sublist(., "airlock assemblies", GLOB.skyrat_metal_airlock_recipes)

// Plasteel

GLOBAL_LIST_INIT(skyrat_plasteel_recipes, list(
	new/datum/stack_recipe("plasteel barricade", /obj/structure/deployable_barricade/metal/plasteel, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
))

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_plasteel_recipes

// Rods

GLOBAL_LIST_INIT(skyrat_rod_recipes, list(
	new/datum/stack_recipe("towel bin", /obj/structure/towel_bin/empty, 2, time = 0.5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_CONTAINERS),
	new/datum/stack_recipe("guard rail", /obj/structure/deployable_barricade/guardrail, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("wrestling ropes", /obj/structure/railing/wrestling, 3, time = 1.8 SECONDS, crafting_flags = CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("crutch", /obj/item/cane/crutch, 3, time = 1 SECONDS, category = CAT_TOOLS),
))

/obj/item/stack/rods/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_rod_recipes

// Wood

GLOBAL_LIST_INIT(skyrat_wood_recipes, list(
	new/datum/stack_recipe("water basin", /obj/structure/reagent_water_basin, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("forging work bench", /obj/structure/reagent_crafting_bench, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("wooden half-barricade", /obj/structure/deployable_barricade/wooden, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
	new/datum/stack_recipe("sauna oven", /obj/structure/sauna_oven, 30, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT),
	new/datum/stack_recipe("large wooden mortar", /obj/structure/large_mortar, 10, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("wooden cutting board", /obj/item/cutting_board, 5, time = 2 SECONDS, category = CAT_TOOLS),
	new/datum/stack_recipe("wooden shelf", /obj/structure/rack/wooden, 2, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("seed shelf", /obj/machinery/smartfridge/wooden/seed_shelf, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("produce bin", /obj/machinery/smartfridge/wooden/produce_bin, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("produce display", /obj/machinery/smartfridge/wooden/produce_display, 10, time = 2 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("ration shelf", /obj/machinery/smartfridge/wooden/ration_shelf, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("storage barrel", /obj/structure/closet/crate/wooden/storage_barrel, 4, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("worm barrel", /obj/structure/wormfarm, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
	new/datum/stack_recipe("gutlunch trough", /obj/structure/ore_container/food_trough/gutlunch_trough, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("sturdy wooden fence", /obj/structure/railing/wooden_fencing, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("sturdy wooden fence gate", /obj/structure/railing/wooden_fencing/gate, 5, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("large wooden gate", /obj/structure/mineral_door/wood/large_gate, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
))


/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_wood_recipes

// Cloth

GLOBAL_LIST_INIT(skyrat_cloth_recipes, list(
	new/datum/stack_recipe("fancy pillow", /obj/item/fancy_pillow, 3, category = CAT_ENTERTAINMENT),
	new/datum/stack_recipe("towel", /obj/item/towel, 2, category = CAT_CLOTHING),
	new/datum/stack_recipe("eyepatch wrap", /obj/item/clothing/glasses/eyepatch/wrap, 2, category = CAT_CLOTHING),
	new/datum/stack_recipe("eyepatch", /obj/item/clothing/glasses/eyepatch, 2, category = CAT_CLOTHING),
	new/datum/stack_recipe("xenoarch bag", /obj/item/storage/bag/xenoarch, 4, category = CAT_CONTAINERS),
))

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_cloth_recipes

// Leather

GLOBAL_LIST_INIT(skyrat_leather_recipes, list(
))

GLOBAL_LIST_INIT(skyrat_leather_belt_recipes, list(
	new/datum/stack_recipe("xenoarch belt", /obj/item/storage/belt/utility/xenoarch, 4, category = CAT_CONTAINERS),
	new/datum/stack_recipe("medical bandolier", /obj/item/storage/belt/medbandolier, 5, category = CAT_CONTAINERS),
	new/datum/stack_recipe("gear harness", /obj/item/clothing/under/misc/skyrat/gear_harness, 6, category = CAT_CLOTHING),
	new/datum/stack_recipe("ammo pouch", /obj/item/storage/pouch/ammo, 4, category = CAT_CONTAINERS),
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_leather_recipes
	add_recipes_to_sublist(., "belts", GLOB.skyrat_leather_belt_recipes)

// Titanium

GLOBAL_LIST_INIT(skyrat_titanium_recipes, list(
	new/datum/stack_recipe("spaceship plating", /obj/item/stack/sheet/spaceship, 1, time = 5, category = CAT_MISC),
))

/obj/item/stack/sheet/mineral/titanium/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_titanium_recipes

// Snow

GLOBAL_LIST_INIT(skyrat_snow_recipes, list(
	new/datum/stack_recipe("snow barricade", /obj/structure/deployable_barricade/snow, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_STRUCTURE),
))

/obj/item/stack/sheet/mineral/snow/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_snow_recipes

// Sand

GLOBAL_LIST_INIT(skyrat_sand_recipes, list(
	new/datum/stack_recipe("ant farm", /obj/structure/antfarm, 20, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS),
))

/obj/item/stack/ore/glass/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_sand_recipes
