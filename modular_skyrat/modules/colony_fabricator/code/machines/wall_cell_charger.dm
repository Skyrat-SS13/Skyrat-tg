/obj/machinery/cell_charger_multi/wall_mounted
	name = "mounted multi-cell charging rack"
	desc = "The innovative technology of a cell charging rack, but mounted neatly on a wall out of the way!"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/cell_charger.dmi'
	icon_state = "wall_charger"
	circuit = null
	flags_1 = NODECONSTRUCT_1
	max_batteries = 3
	charge_rate = 750
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/wallframe/cell_charger_multi

/obj/machinery/cell_charger_multi/wall_mounted/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	find_and_hang_on_wall()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/cell_charger_multi/wall_mounted, 32)

/obj/machinery/cell_charger_multi/wall_mounted/RefreshParts()
	. = ..()
	charge_rate = 750 // Nuh uh!

// Item for creating the arc furnace or carrying it around

/obj/item/wallframe/cell_charger_multi
	name = "unmounted wall multi-cell charging rack"
	desc = "The innovative technology of a cell charging rack, but able to be mounted neatly on a wall out of the way!"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/packed_machines.dmi'
	icon_state = "cell_charger_packed"
	w_class = WEIGHT_CLASS_NORMAL
	result_path = /obj/machinery/cell_charger_multi/wall_mounted
	pixel_shift = 32
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
