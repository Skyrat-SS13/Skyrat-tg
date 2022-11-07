/obj/item/stack/sheet/mineral/stone
	name = "stone"
	desc = "Stone brick."
	singular_name = "stone block"
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "sheet-stone"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/stone=MINERAL_MATERIAL_AMOUNT)
	throwforce = 10
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/mineral/stone
	grind_results = null
	point_value = 0
	material_type = /datum/material/stone
	matter_amount = 0
	source = null
	walltype = /turf/closed/wall/mineral/stone
	stairs_type = /obj/structure/stairs/stone

GLOBAL_LIST_INIT(stone_recipes, list ( \
	new/datum/stack_recipe("stone brick wall", /turf/closed/wall/mineral/stone, 5, one_per_turf = 1, on_solid_ground = 1, applies_mats = TRUE), \
	new/datum/stack_recipe("stone brick tile", /obj/item/stack/tile/mineral/stone, 1, 4, 20),
	))

/obj/item/stack/sheet/mineral/stone/get_main_recipes()
	. = ..()
	. += GLOB.stone_recipes

/datum/material/stone
	name = "stone"
	desc = "It's stone."
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE, MAT_CATEGORY_ITEM_MATERIAL=TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/stone
	value_per_unit = 0.005
	beauty_modifier = 0.01
	color = "#59595a"
	greyscale_colors = "#59595a"
	value_per_unit = 0.0025
	armor_modifiers = list(MELEE = 0.75, BULLET = 0.5, LASER = 1.25, ENERGY = 0.5, BOMB = 0.5, BIO = 0.25, FIRE = 1.5, ACID = 1.5)
	beauty_modifier = 0.3
	turf_sound_override = FOOTSTEP_PLATING

/obj/item/stack/stone
	name = "rough stone"
	desc = "Large chunks of uncut stone, tough enough to safely build out of... if you could manage to cut them into something usable."
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "stone_ore"
	singular_name = "rough stone boulder"
	mats_per_unit = list(/datum/material/stone=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/stone
	merge_type = /obj/item/stack/stone

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

/turf/open/floor/stone
	desc = "Blocks of stone arranged in a tile-like pattern, odd, really, how it looks like real stone too, because it is!" //A play on the original description for stone tiles
