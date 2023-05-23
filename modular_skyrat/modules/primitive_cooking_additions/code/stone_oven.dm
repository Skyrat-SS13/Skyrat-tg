#define OVEN_TRAY_Y_OFFSET -12

/obj/machinery/oven/stone
	name = "stone oven"
	desc = "Sorry buddy, all this stone used up the budget that would have normally gone to garfield comic jokes."
	icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/stone_kitchen_machines.dmi'
	circuit = null
	use_power = FALSE

	/// A list of the different oven trays we can spawn with
	var/static/list/random_oven_tray_types = list(
		/obj/item/plate/oven_tray/material/fake_copper,
		/obj/item/plate/oven_tray/material/fake_brass,
		/obj/item/plate/oven_tray/material/fake_tin,
	)

/obj/machinery/oven/stone/Initialize(mapload)
	. = ..()

	if(!mapload)
		return

	if(used_tray) // We have to get rid of normal generic tray that normal ovens spawn with
		QDEL_NULL(used_tray)

	var/new_tray_type_to_use = pick(random_oven_tray_types)
	add_tray_to_oven(new new_tray_type_to_use(src))

/obj/machinery/oven/stone/add_tray_to_oven(obj/item/plate/oven_tray, mob/baker)
	used_tray = oven_tray

	if(!open)
		oven_tray.vis_flags |= VIS_HIDE
	vis_contents += oven_tray
	oven_tray.flags_1 |= IS_ONTOP_1
	oven_tray.vis_flags |= VIS_INHERIT_PLANE
	oven_tray.pixel_y = OVEN_TRAY_Y_OFFSET

	RegisterSignal(used_tray, COMSIG_MOVABLE_MOVED, PROC_REF(on_tray_moved))
	update_baking_audio()
	update_appearance()

/obj/machinery/oven/stone/set_smoke_state(new_state)
	. = ..()

	if(particles)
		particles.position = list(0, 10, 0)

#undef OVEN_TRAY_Y_OFFSET
