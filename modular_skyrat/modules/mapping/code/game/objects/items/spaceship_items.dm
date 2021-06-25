/obj/item/stack/sheet/spaceship
	name = "spaceship plating"
	icon_state = "sheet-titanium"
	inhand_icon_state = "sheet-titanium"
	singular_name = "spaceship plate"
	sheettype = "spaceship"
	merge_type = /obj/item/stack/sheet/spaceship
	walltype = /turf/closed/wall/mineral/titanium/spaceship

/obj/item/stack/sheet/spaceshipglass
	name = "spaceship window plates"
	desc = "A glass sheet made out of a titanium-silicate alloy, rivited for use in spaceship window frames"
	singular_name = "spaceship window plate"
	icon_state = "sheet-titaniumglass"
	inhand_icon_state = "sheet-titaniumglass"
	merge_type = /obj/item/stack/sheet/spaceshipglass

GLOBAL_LIST_INIT(spaceshipglass_recipes, list(
	new/datum/stack_recipe("spaceship window", /obj/structure/window/shuttle/spaceship/unanchored, 2, time = 4 SECONDS, on_floor = TRUE, window_checks = TRUE), \
	))

/obj/item/stack/sheet/spaceshipglass/get_main_recipes()
	. = ..()
	. += GLOB.spaceshipglass_recipes
