/obj/structure/window/reinforced/colony_fabricator
	name = "prefabricated window"
	desc = "A conservatively built metal frame with a thick sheet of space-grade glass slotted into it."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/prefab_window.dmi'
	icon_state = "prefab-0"
	base_icon_state = "prefab"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_WINDOW_FULLTILE_SHUTTLE
	canSmoothWith = SMOOTH_GROUP_WINDOW_FULLTILE_SHUTTLE
	glass_type = /obj/item/stack/sheet/plastic_wall_panel
	glass_amount = 1
