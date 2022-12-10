/obj/structure/crafting_bench/forging
	name = "forging workbench"
	desc = "A crafting bench fitted with tools, securing mechanisms, and a steady surface for working metal"
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_structures.dmi'
	icon_state = "forging_bench"

	allowed_choices = list(
		/datum/crafting_bench_recipe/forging/weapon_completion,
		/datum/crafting_bench_recipe/forging/plate_helmet,
		/datum/crafting_bench_recipe/forging/plate_vest,
		/datum/crafting_bench_recipe/forging/plate_gloves,
		/datum/crafting_bench_recipe/forging/plate_boots,
		/datum/crafting_bench_recipe/forging/borer_cage,
		/datum/crafting_bench_recipe/forging/pavise,
		/datum/crafting_bench_recipe/forging/buckler,
		/datum/crafting_bench_recipe/forging/seed_mesh,
		/datum/crafting_bench_recipe/forging/bow,
	)
