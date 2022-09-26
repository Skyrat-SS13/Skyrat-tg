// Add modular crafting recipes here, NOT IN BASE /tg/ CRAFTING LISTS
// Sublists are unfortunately still stuck in their own lists in the base global lists. Painful I know

// Iron

GLOBAL_LIST_INIT(skyrat_metal_recipes, list ( \
	new/datum/stack_recipe("pool floor tile", /obj/item/stack/tile/iron/pool, 1, 1, 4), \
	new/datum/stack_recipe("lowered floor tile", /obj/item/stack/tile/iron/lowered, 1, 1, 4), \
	new/datum/stack_recipe("elevated floor tile", /obj/item/stack/tile/iron/elevated, 1, 1, 4), \
	new/datum/stack_recipe("wrestling turnbuckle", /obj/structure/wrestling_corner, 3, time = 2.5 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE), \
	new/datum/stack_recipe("metal barricade", /obj/structure/deployable_barricade/metal, 2, time = 1 SECONDS, on_solid_ground = TRUE), \
	null, \
	new/datum/stack_recipe("anvil", /obj/structure/reagent_anvil, 10, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE), \
	new/datum/stack_recipe("forge", /obj/structure/reagent_forge, 10, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE), \
	new/datum/stack_recipe("throwing wheel", /obj/structure/throwing_wheel, 10, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE),
))

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_metal_recipes

// Plasteel

GLOBAL_LIST_INIT(skyrat_plasteel_recipes, list ( \
	new/datum/stack_recipe("plasteel barricade", /obj/structure/deployable_barricade/metal/plasteel, 2, time = 1 SECONDS, on_solid_ground = TRUE),
))

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_plasteel_recipes

// Wood

GLOBAL_LIST_INIT(skyrat_wood_recipes, list ( \
	new/datum/stack_recipe("wooden barricade", /obj/structure/deployable_barricade/wooden, 2, time = 1 SECONDS, on_solid_ground = TRUE), \
	new/datum/stack_recipe("water basin", /obj/structure/reagent_water_basin, 5, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE), \
	new/datum/stack_recipe("forging work bench", /obj/structure/reagent_crafting_bench, 5, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE), \
	new/datum/stack_recipe("wooden half-barricade", /obj/structure/deployable_barricade/wooden, 5, time = 2 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE), \
		new/datum/stack_recipe("sauna oven", /obj/structure/sauna_oven, 30, time = 1.5 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE), \
))

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_wood_recipes

// Cloth

GLOBAL_LIST_INIT(skyrat_cloth_recipes, list ( \
	new/datum/stack_recipe("xenoarch bag", /obj/item/storage/bag/xenoarch, 4), \
	new/datum/stack_recipe("pillow", /obj/item/pillow, 3), \
	new/datum/stack_recipe("eyepatch wrap", /obj/item/clothing/glasses/eyepatch/wrap, 2), \
	new/datum/stack_recipe("eyepatch", /obj/item/clothing/glasses/eyepatch, 2), \
))

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.skyrat_cloth_recipes
