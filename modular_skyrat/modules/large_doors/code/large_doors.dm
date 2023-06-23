/obj/machinery/door/airlock
	/// Whether or not the door is a multi-tile airlock.
	var/multi_tile = FALSE
	/// How many tiles the airlock takes up.
	var/size = 1
	/// A filler object used to fill the space of multi-tile airlocks.
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

/**
 * Sets the bounds of the airlock. For use with multi-tile airlocks.
 * If the airlock is multi-tile, it will set the bounds to be the size of the airlock.
 * If the airlock doesn't already have a filler object, it will create one.
 * If the airlock already has a filler object, it will move it to the correct location.
 */
/obj/machinery/door/airlock/proc/SetBounds()
	if(!multi_tile)
		return
	bound_width = (get_adjusted_dir(dir) == NORTH) ? world.icon_size : size * world.icon_size
	bound_height = (get_adjusted_dir(dir) == NORTH) ? size * world.icon_size : world.icon_size
	if(!filler)
		filler = new(get_step(src, get_adjusted_dir(dir)))
		filler.parent_airlock = src
	else
		filler.loc = get_step(src, get_adjusted_dir(dir))

	filler.density = density
	filler.set_opacity(opacity)

/**
 * Checks which way the airlock is facing and adjusts the direction accordingly.
 * For use with multi-tile airlocks.
 *
 * @param dir direction to adjust
 * @return adjusted direction
 */
/obj/machinery/door/proc/get_adjusted_dir(dir)
	if(dir in list(NORTH, SOUTH))
		return EAST
	else
		return NORTH

/**
 * Returns a list of turfs that the door occupies.
 * If the door is multi-tile, it will return a list of turfs that the door occupies.
 * If the door is not multi-tile, it will return only the current turf.
 *
 * @return list of turfs the door occupies
 */
/obj/machinery/door/airlock/proc/get_turfs()
	var/turf/current_turf = get_turf(src)
	if(!multi_tile)
		return current_turf
	var/list/occupied_turfs = list()
	for(var/i in 1 to size)
		occupied_turfs += current_turf
		current_turf = get_step(current_turf, get_adjusted_dir(dir))
	return occupied_turfs


/obj/machinery/door/airlock/multi_tile
	multi_tile = TRUE
	size = 2
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
	/// How many tiles the airlock takes up.
	var/size = 2

/obj/structure/door_assembly/multi_tile/Initialize(mapload)
	. = ..()
	update_dir()

/obj/structure/door_assembly/multi_tile/Move()
	. = ..()
	update_dir()

/obj/structure/door_assembly/multi_tile/proc/update_dir()
	if(dir in list(NORTH, SOUTH))
		bound_width = size * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = size * world.icon_size

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

