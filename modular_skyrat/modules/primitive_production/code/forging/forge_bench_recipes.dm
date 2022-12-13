/datum/crafting_bench_recipe/forging
	relevant_skill = /datum/skill/smithing
	required_tool_type = /obj/item/forging/hammer
	sound_the_tool_makes = 'modular_skyrat/modules/primitive_production/sound/hammer_clang.ogg'

/datum/crafting_bench_recipe/forging/weapon_completion
	recipe_name = "weapon_completion"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 2,
		/obj/item/forging/complete = 1,
	)
	types_to_not_take_materials_from = list(
		/obj/item/stack/sheet/mineral/wood,
	)
	resulting_item = /obj/item/melee/forging_weapon
	required_good_hits = 8
	relevant_skill_reward = 50 // Completing a weapon gives you a bit more than other recipes do

/datum/crafting_bench_recipe/before_finishing(list/recipe_items) // Sets the resulting item to the result of the first weapon head its passed
	for(var/obj/item/forging/complete/complete_forging_item in recipe_items)
		if(!complete_forging_item.spawning_item)
			continue
		resulting_item = complete_forging_item.spawning_item
		return

/datum/crafting_bench_recipe/forging/plate_helmet
	recipe_name = "plate helmet"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 4,
	)
	resulting_item = /obj/item/clothing/head/helmet/forging_plate_helmet
	required_good_hits = 8

/datum/crafting_bench_recipe/forging/plate_vest
	recipe_name = "plate vest"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 6,
	)
	resulting_item = /obj/item/clothing/suit/armor/forging_plate_armor
	required_good_hits = 12

/datum/crafting_bench_recipe/forging/plate_gloves
	recipe_name = "plate gloves"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 2,
	)
	resulting_item = /obj/item/clothing/gloves/forging_plate_gloves
	required_good_hits = 4

/datum/crafting_bench_recipe/forging/plate_boots
	recipe_name = "plate boots"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 4,
	)
	resulting_item = /obj/item/clothing/shoes/forging_plate_boots
	required_good_hits = 8

/datum/crafting_bench_recipe/forging/borer_cage
	recipe_name = "cortical borer cage"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 6,
	)
	resulting_item = /obj/item/cortical_cage
	required_good_hits = 12

/datum/crafting_bench_recipe/forging/pavise
	recipe_name = "tower shield"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 8,
	)
	resulting_item = /obj/item/shield/buckler/forging_shield
	required_good_hits = 16

/datum/crafting_bench_recipe/forging/buckler
	recipe_name = "buckler"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 5,
	)
	resulting_item = /obj/item/shield/buckler/forging_shield/pavise
	required_good_hits = 10

/datum/crafting_bench_recipe/forging/seed_mesh
	recipe_name = "seed mesh"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/forging/complete/chain = 4,
	)
	resulting_item = /obj/item/seed_mesh
	required_good_hits = 10

/datum/crafting_bench_recipe/forging/bow
	recipe_name = "bow"
	recipe_requirements = list(
		/obj/item/stack/sheet/mineral/wood = 4,
	)
	resulting_item = /obj/item/forging/incomplete_bow
	required_good_hits = 8

// Plates, cups, bowls, so on

/datum/crafting_bench_recipe/forging/bowl
	recipe_name = "bowl"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/reagent_containers/cup/bowl/generic_material
	required_good_hits = 4

/datum/crafting_bench_recipe/forging/cup
	recipe_name = "cup"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/reagent_containers/cup/beaker/generic_material/fancy_lookin
	required_good_hits = 4

/datum/crafting_bench_recipe/forging/small_food_plate
	recipe_name = "appetizer plate"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/plate/small/generic_material
	required_good_hits = 2

/datum/crafting_bench_recipe/forging/normal_food_plate
	recipe_name = "plate"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/plate/generic_material
	required_good_hits = 3

/datum/crafting_bench_recipe/forging/big_food_plate
	recipe_name = "buffet plate"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 2,
	)
	resulting_item = /obj/item/plate/large/generic_material
	required_good_hits = 4

/datum/crafting_bench_recipe/forging/oven_tray
	recipe_name = "oven_tray"
	recipe_requirements = list(
		/obj/item/forging/complete/plate = 1,
	)
	resulting_item = /obj/item/plate/oven_tray/generic_material
	required_good_hits = 3
