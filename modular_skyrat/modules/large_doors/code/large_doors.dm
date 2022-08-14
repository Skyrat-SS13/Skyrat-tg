/obj/machinery/door/airlock
	var/multi_tile = FALSE
	var/width = 1
	var/obj/airlock_filler_object/filler

/obj/machinery/door/airlock/Move()
	if(multi_tile)
		SetBounds()
	return ..()

/obj/machinery/door/airlock/Destroy()
	if(filler)
		qdel(filler)
		filler = null
	return ..()

/obj/machinery/door/airlock/proc/SetBounds()
	if(!multi_tile)
		return
	if(dir in list(NORTH, SOUTH))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
		if(!filler)
			filler = new(get_step(src,EAST))
			filler.parent_airlock = src
		else
			filler.loc = get_step(src,EAST)
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size
		if(!filler)
			filler = new(get_step(src,NORTH))
			filler.parent_airlock = src
		else
			filler.loc = get_step(src,NORTH)
	filler.density = density
	filler.set_opacity(opacity)

/obj/machinery/door/airlock/multi_tile
	multi_tile = TRUE
	width = 2
	has_environment_lights = FALSE

/obj/machinery/door/airlock/multi_tile/glass
	name = "Large Glass Airlock"
	icon = 'modular_skyrat/modules/large_doors/icons/glass/multi_tile.dmi'
	overlays_file = 'modular_skyrat/modules/large_doors/icons/glass/overlays.dmi'
	opacity = FALSE
	airlock_material = "glass"
	glass = TRUE
	assemblytype = /obj/structure/door_assembly/multi_tile/glass

/obj/machinery/door/airlock/multi_tile/metal
	name = "Large Airlock"
	icon = 'modular_skyrat/modules/large_doors/icons/metal/multi_tile.dmi'
	overlays_file = 'modular_skyrat/modules/large_doors/icons/metal/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/multi_tile/metal

/obj/airlock_filler_object
	name = ""
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	can_atmos_pass = ATMOS_PASS_DENSITY
	var/parent_airlock

/obj/airlock_filler_object/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(.)
		return
	// Snowflake handling for PASSGLASS.
	if(istype(mover) && (mover.pass_flags & PASSGLASS))
		return !opacity

/obj/airlock_filler_object/can_be_pulled(user, grab_state, force)
	return FALSE

/obj/airlock_filler_object/singularity_act()
	return

/obj/airlock_filler_object/singularity_pull(S, current_size)
	return

/obj/airlock_filler_object/Destroy(force)
	if(parent_airlock)
		parent_airlock = null
	return ..()

//ASSEMBLYS!
/obj/structure/door_assembly/multi_tile
	dir = EAST
	var/width = 1

/obj/structure/door_assembly/multi_tile/Initialize(mapload)
	. = ..()
	update_dir()

/obj/structure/door_assembly/multi_tile/Move()
	. = ..()
	update_dir()

/obj/structure/door_assembly/multi_tile/proc/update_dir()
	if(dir in list(NORTH, SOUTH))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size

/obj/structure/door_assembly/multi_tile/metal
	name = "Large Airlock Assembly"
	icon = 'modular_skyrat/modules/large_doors/icons/metal/multi_tile.dmi'
	base_name = "Large Airlock"
	overlays_file = 'modular_skyrat/modules/large_doors/icons/metal/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/multi_tile/metal
	glass_type = /obj/machinery/door/airlock/multi_tile/glass

/obj/structure/door_assembly/multi_tile/glass
	name = "Large Glass Airlock Assembly"
	icon = 'modular_skyrat/modules/large_doors/icons/glass/multi_tile.dmi'
	base_name = "Large Glass Airlock"
	overlays_file = 'modular_skyrat/modules/large_doors/icons/glass/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/multi_tile/glass

