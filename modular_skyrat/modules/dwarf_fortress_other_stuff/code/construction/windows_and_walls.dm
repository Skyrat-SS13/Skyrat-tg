// THE WINDOW

/obj/structure/window/fulltile/material
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/walls/smooth_wall.dmi'
	base_icon_state = "wall"
	icon_state = "wall-0"
	glass_type = null
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/structure/window/fulltile/material/set_custom_materials()
	. = ..()

	if(length(custom_materials))
		glass_type = custom_materials[1].sheet_type

/obj/structure/window/fulltile/material/spawn_debris(location)
	return

// WALLS

/turf/closed/wall/material/dwarf_fortress
	icon_state = "wall-0"
	base_icon_state = "wall"
	girder_type = null

/turf/closed/wall/material/dwarf_fortress/examine()
	. = ..()
	. += span_notice("You could break this down using a <b>pickaxe</b>.")

/turf/closed/wall/material/dwarf_fortress/try_decon(obj/item/item_used, mob/user)
	if(item_used.tool_behaviour != TOOL_MINING)
		return ..()

	if(!item_used.tool_start_check(user, amount = 0))
		return FALSE

	balloon_alert_to_viewers("breaking down...")

	if(!item_used.use_tool(src, user, 5 SECONDS))
		return FALSE
	dismantle_wall()
	return TRUE

/turf/closed/wall/material/dwarf_fortress/smooth
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/walls/smooth_wall.dmi'

/turf/closed/wall/material/dwarf_fortress/brick
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/walls/brick_wall.dmi'

/turf/closed/wall/material/dwarf_fortress/wood
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/walls/wood_wall.dmi'
