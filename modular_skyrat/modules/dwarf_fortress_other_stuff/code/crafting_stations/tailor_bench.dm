/obj/structure/reagent_crafting_bench/tailoring
	name = "tailoring station"
	desc = "A bench fitted with sewing needles, patterns, and all sorts of other equipment you might want when making clothes."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "crafting_bench_empty"

	finishes_forging_weapons = FALSE
	required_tool = /obj/item/scissors
	working_sound = 'modular_skyrat/modules/salon/sound/haircut.ogg'
	allowed_choices = list(
		/datum/crafting_bench_recipe/clothing/pantsed_uniform,
		/datum/crafting_bench_recipe/clothing/high_pantsed_uniform,
		/datum/crafting_bench_recipe/clothing/skirt_uniform,
		/datum/crafting_bench_recipe/clothing/robes,
		/datum/crafting_bench_recipe/clothing/armwraps,
	)

// DA RECIPEZE

/datum/crafting_bench_recipe/clothing
	transfers_materials = TRUE
	required_good_hits = 4
	relevant_skill = /datum/skill/production

/datum/crafting_bench_recipe/clothing/pantsed_uniform
	recipe_name = "pants with shirt"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth = 2,
		/obj/item/stack/dwarf_certified/thread = 1,
	)
	resulting_item = /obj/item/clothing/under/costume/buttondown/event_clothing/workpants


/datum/crafting_bench_recipe/clothing/high_pantsed_uniform
	recipe_name = "high waist pants with shirt"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth = 2,
		/obj/item/stack/dwarf_certified/thread = 1,
	)
	resulting_item = /obj/item/clothing/under/costume/buttondown/event_clothing/longpants

/datum/crafting_bench_recipe/clothing/skirt_uniform
	recipe_name = "skirt with shirt"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth = 2,
		/obj/item/stack/dwarf_certified/thread = 1,
	)
	resulting_item = /obj/item/clothing/under/costume/buttondown/event_clothing/skirt

/datum/crafting_bench_recipe/clothing/robes
	recipe_name = "robes"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth/fabric = 2,
		/obj/item/stack/dwarf_certified/thread = 1,
	)
	resulting_item = /obj/item/clothing/under/costume/skyrat/bathrobe/event

/datum/crafting_bench_recipe/clothing/jacket
	recipe_name = "jacket"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth/fabric = 2,
	)
	resulting_item = /obj/item/clothing/suit/toggle/jacket/sweater/df_event

/datum/crafting_bench_recipe/clothing/armwraps
	recipe_name = "arm wraps"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth = 1,
	)
	resulting_item = /obj/item/clothing/gloves/fingerless/df_armwraps

/datum/crafting_bench_recipe/clothing/gloves
	recipe_name = "gloves"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth = 1,
	)
	resulting_item = /obj/item/clothing/gloves/color/black/dwarf_gloves

/datum/crafting_bench_recipe/clothing/sandals
	recipe_name = "sandals"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth/leather = 1,
	)
	resulting_item = /obj/item/clothing/shoes/colorable_sandals/df_event

/datum/crafting_bench_recipe/clothing/shoes
	recipe_name = "shoes"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth/leather = 1,
	)
	resulting_item = /obj/item/clothing/shoes/colorable_laceups/df_event

/datum/crafting_bench_recipe/clothing/boots
	recipe_name = "boots"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth/leather = 1,
	)
	resulting_item = /obj/item/clothing/shoes/jackboots/recolorable/df_event

/datum/crafting_bench_recipe/clothing/backpack
	recipe_name = "backpack"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth = 2,
	)
	resulting_item = /obj/item/storage/backpack/industrial/event

/datum/crafting_bench_recipe/clothing/satchel
	recipe_name = "satchel"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth = 2,
	)
	resulting_item = /obj/item/storage/backpack/satchel/eng/event

/datum/crafting_bench_recipe/clothing/leather_armor
	recipe_name = "leather armor"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth/leather = 2,
	)
	resulting_item = /obj/item/clothing/suit/armor/df_plate_armor

/datum/crafting_bench_recipe/clothing/leather_helmet
	recipe_name = "leather helmet"
	recipe_requirements = list(
		/obj/item/stack/dwarf_certified/leather_or_cloth/leather = 2,
	)
	resulting_item = /obj/item/clothing/head/helmet/df_plate_helmet
