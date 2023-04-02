/obj/structure/reagent_crafting_bench/tailoring
	name = "tailoring station"
	desc = "A bench fitted with sewing needles, patterns, and all sorts of other equipment you might want when making clothes."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "crafting_bench_empty"

	finishes_forging_weapons = FALSE
	required_tool = /obj/item/scissors
	working_sound = 'modular_skyrat/modules/salon/sound/haircut.ogg'
	allowed_choices = list(
		/datum/crafting_bench_recipe/pantsed_uniform,
		/datum/crafting_bench_recipe/high_pantsed_uniform,
		/datum/crafting_bench_recipe/skirt_uniform,
	)

// DA RECIPEZE

/datum/crafting_bench_recipe/pantsed_uniform
	recipe_name = "pants with shirt"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/fabric = 1,
		/obj/item/stack/dwarf_certified/thread = 1,
	)
	resulting_item = /obj/item/clothing/under/costume/buttondown/event_clothing/workpants
	transfers_materials = TRUE
	required_good_hits = 4
	relevant_skill = /datum/skill/production

/datum/crafting_bench_recipe/high_pantsed_uniform
	recipe_name = "high waist pants with shirt"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/fabric = 1,
		/obj/item/stack/dwarf_certified/thread = 1,
	)
	resulting_item = /obj/item/clothing/under/costume/buttondown/event_clothing/longpants
	transfers_materials = TRUE
	required_good_hits = 4
	relevant_skill = /datum/skill/production

/datum/crafting_bench_recipe/skirt_uniform
	recipe_name = "skirt with shirt"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/fabric = 1,
		/obj/item/stack/dwarf_certified/thread = 1,
	)
	resulting_item = /obj/item/clothing/under/costume/buttondown/event_clothing/skirt
	transfers_materials = TRUE
	required_good_hits = 4
	relevant_skill = /datum/skill/production
