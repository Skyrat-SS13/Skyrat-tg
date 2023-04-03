/obj/item/stack/tile/material/dwarf_fortress
	turf_type = /turf/open/floor/material
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	merge_type = /obj/item/stack/tile/material/dwarf_fortress

/turf/open/floor/material/dwarf_fortress
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/floors.dmi'
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	floor_tile = /obj/item/stack/tile/material/dwarf_fortress

/turf/open/floor/material/dwarf_fortress/spawn_tile() // We just spawn the base material sheet of whatever we are made out of
	for(var/material as anything in custom_materials)
		var/datum/material/found_material = material
		new found_material.sheet_type(src, FLOOR(custom_materials[found_material] / MINERAL_MATERIAL_AMOUNT, 1))

/turf/open/floor/material/dwarf_fortress/wood
	icon_state = "wood"

/turf/open/floor/material/dwarf_fortress/stone
	icon_state = "stone"

/turf/open/floor/material/dwarf_fortress/metal
	icon_state = "metal"
