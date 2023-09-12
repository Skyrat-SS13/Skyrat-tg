// Add modular crafting recipes here, NOT IN BASE /tg/ CRAFTING LISTS

/**
 * Add a list of receipes to an existing recipe sublist.
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
	new/datum/stack_recipe("pool floor tile", /obj/item/stack/tile/iron/pool, 1, 4, 20, check_density = FALSE, category = CAT_TILES),
	new/datum/stack_recipe("lowered floor tile", /obj/item/stack/tile/iron/lowered, 1, 4, 20, check_density = FALSE, category = CAT_TILES),
	new/datum/stack_recipe("elevated floor tile", /obj/item/stack/tile/iron/elevated, 1, 4, 20, check_density = FALSE, category = CAT_TILES),
	new/datum/stack_recipe("wrestling turnbuckle", /obj/structure/wrestling_corner, 3, time = 2.5 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_STRUCTURE),
	new/datum/stack_recipe("metal barricade", /obj/structure/deployable_barricade/metal, 2, time = 1 SECONDS, on_solid_ground = TRUE, check_direction = TRUE, category = CAT_STRUCTURE),
	new/datum/stack_recipe("anvil", /obj/structure/reagent_anvil, 10, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_TOOLS),
	new/datum/stack_recipe("forge", /obj/structure/reagent_forge, 10, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_TOOLS),
	new/datum/stack_recipe("throwing wheel", /obj/structure/throwing_wheel, 10, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_TOOLS),
))

GLOBAL_LIST_INIT(skyrat_metal_airlock_recipes, list(
	new /datum/stack_recipe("corporate airlock assembly", /obj/structure/door_assembly/door_assembly_corporate, 4, time = 5 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_DOORS),
	new /datum/stack_recipe("service airlock assembly", /obj/structure/door_assembly/door_assembly_service, 4, time = 5 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_DOORS),
))

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_metal_recipes
	add_recipes_to_sublist(., "airlock assemblies", GLOB.skyrat_metal_airlock_recipes)

// Plasteel

GLOBAL_LIST_INIT(skyrat_plasteel_recipes, list(
	new/datum/stack_recipe("plasteel barricade", /obj/structure/deployable_barricade/metal/plasteel, 2, time = 1 SECONDS, on_solid_ground = TRUE, check_direction = TRUE, category = CAT_STRUCTURE),
))

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_plasteel_recipes

// Rods

GLOBAL_LIST_INIT(skyrat_rod_recipes, list(
	new/datum/stack_recipe("towel bin", /obj/structure/towel_bin/empty, 2, time = 0.5 SECONDS, one_per_turf = FALSE, check_density = FALSE, category = CAT_CONTAINERS),
	new/datum/stack_recipe("guard rail", /obj/structure/deployable_barricade/guardrail, 2, time = 1 SECONDS, on_solid_ground = TRUE, check_direction = TRUE, category = CAT_STRUCTURE),
	new/datum/stack_recipe("wrestling ropes", /obj/structure/railing/wrestling, 3, time = 1.8 SECONDS, on_solid_ground = TRUE, check_direction = TRUE, check_density = FALSE, category = CAT_STRUCTURE),
	new/datum/stack_recipe("crutch", /obj/item/cane/crutch, 3, time = 10, one_per_turf = FALSE, category = CAT_TOOLS),
))

/obj/item/stack/rods/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_rod_recipes

// Wood

GLOBAL_LIST_INIT(skyrat_wood_recipes, list(
	new/datum/stack_recipe("water basin", /obj/structure/reagent_water_basin, 5, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_TOOLS),
	new/datum/stack_recipe("forging work bench", /obj/structure/reagent_crafting_bench, 5, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_TOOLS),
	new/datum/stack_recipe("wooden half-barricade", /obj/structure/deployable_barricade/wooden, 5, time = 2 SECONDS, on_solid_ground = TRUE, check_direction = TRUE, category = CAT_STRUCTURE),
	new/datum/stack_recipe("sauna oven", /obj/structure/sauna_oven, 30, time = 1.5 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_ENTERTAINMENT),
	new/datum/stack_recipe("large wooden mortar", /obj/structure/large_mortar, 10, time = 3 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_TOOLS),
	new/datum/stack_recipe("wooden cutting board", /obj/item/cutting_board, 5, time = 2 SECONDS, check_density = FALSE, category = CAT_TOOLS),
))

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_wood_recipes

// Cloth

GLOBAL_LIST_INIT(skyrat_cloth_recipes, list(
	new/datum/stack_recipe("fancy pillow", /obj/item/fancy_pillow, 3, check_density = FALSE, category = CAT_ENTERTAINMENT),
	new/datum/stack_recipe("towel", /obj/item/towel, 2, check_density = FALSE, category = CAT_CLOTHING),
	new/datum/stack_recipe("eyepatch wrap", /obj/item/clothing/glasses/eyepatch/wrap, 2, check_density = FALSE, category = CAT_CLOTHING),
	new/datum/stack_recipe("eyepatch", /obj/item/clothing/glasses/eyepatch, 2, check_density = FALSE, category = CAT_CLOTHING),
	new/datum/stack_recipe("xenoarch bag", /obj/item/storage/bag/xenoarch, 4, check_density = FALSE, category = CAT_CONTAINERS),
))

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_cloth_recipes

// Leather

GLOBAL_LIST_INIT(skyrat_leather_recipes, list(
))

GLOBAL_LIST_INIT(skyrat_leather_belt_recipes, list(
	new/datum/stack_recipe("xenoarch belt", /obj/item/storage/belt/utility/xenoarch, 4, check_density = FALSE, category = CAT_CONTAINERS),
	new/datum/stack_recipe("medical bandolier", /obj/item/storage/belt/medbandolier, 5, check_density = FALSE, category = CAT_CONTAINERS),
	new/datum/stack_recipe("gear harness", /obj/item/clothing/under/misc/skyrat/gear_harness, 6, check_density = FALSE, category = CAT_CLOTHING),
	new/datum/stack_recipe("ammo pouch", /obj/item/storage/pouch/ammo, 4, check_density = FALSE, category = CAT_CONTAINERS),
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_leather_recipes
	add_recipes_to_sublist(., "belts", GLOB.skyrat_leather_belt_recipes)

// Titanium

GLOBAL_LIST_INIT(skyrat_titanium_recipes, list(
	new/datum/stack_recipe("spaceship plating", /obj/item/stack/sheet/spaceship, 1, time = 5, check_density = FALSE, category = CAT_MISC),
))

/obj/item/stack/sheet/mineral/titanium/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_titanium_recipes

// Snow

GLOBAL_LIST_INIT(skyrat_snow_recipes, list(
	new/datum/stack_recipe("snow barricade", /obj/structure/deployable_barricade/snow, 2, on_solid_ground = TRUE, check_direction = TRUE, category = CAT_STRUCTURE),
))

/obj/item/stack/sheet/mineral/snow/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_snow_recipes
