/**
 * Returns the size of the sprite in tiles.
 * Takes the icon size and divides it by the world icon size (default 32).
 * This gives the size of the sprite in tiles.
 *
 * @return size of the sprite in tiles
 */
/proc/get_size_in_tiles(obj/target)
	var/icon/size_check = icon(target.icon, target.icon_state)
	var/size = size_check.Width() / world.icon_size

	return size

/obj/machinery/door/airlock
	/// Whether or not the door is a multi-tile airlock.
	var/multi_tile
	/// A filler object used to fill the space of multi-tile airlocks.
	var/obj/airlock_filler_object/filler

/obj/machinery/door/airlock/Initialize(mapload)
	. = ..()
	multi_tile = get_size_in_tiles(src) > 1
	if(multi_tile)
		set_bounds()
	update_overlays()

/obj/machinery/door/airlock/Move()
	if(multi_tile)
		set_bounds()
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
/obj/machinery/door/airlock/proc/set_bounds()
	if(!multi_tile)
		return
	var/size = get_size_in_tiles(src)
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
	for(var/i in 1 to get_size_in_tiles(src))
		occupied_turfs += current_turf
		current_turf = get_step(current_turf, get_adjusted_dir(dir))
	return occupied_turfs


/obj/machinery/door/airlock/multi_tile
	multi_tile = TRUE
	has_environment_lights = FALSE

/obj/machinery/door/airlock/multi_tile/glass
	name = "large glass airlock"
	icon = 'modular_skyrat/modules/large_doors/icons/glass/multi_tile.dmi'
	overlays_file = 'modular_skyrat/modules/large_doors/icons/glass/overlays.dmi'
	opacity = FALSE
	airlock_material = "glass"
	glass = TRUE
	assemblytype = /obj/structure/door_assembly/multi_tile/glass

/obj/machinery/door/airlock/multi_tile/metal
	name = "large airlock"
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
	/// Whether or not the assembly is for a multi-tile airlock.
	var/multi_tile

/obj/structure/door_assembly/multi_tile/Initialize(mapload)
	. = ..()
	multi_tile = get_size_in_tiles(src) > 1
	if(multi_tile)
		set_bounds()
	update_overlays()


/obj/structure/door_assembly/multi_tile/Move()
	. = ..()
	set_bounds()


/**
 * Updates the bounds of the airlock assembly
 * Sets the bounds of the airlock assembly according to the direction.
 * This ensures that the bounds are always correct, even if the airlock is rotated.
 */
/obj/structure/door_assembly/multi_tile/proc/set_bounds()
	var/size = get_size_in_tiles(src)

	if(dir in list(NORTH, SOUTH))
		bound_width = size * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = size * world.icon_size


/obj/structure/door_assembly/multi_tile/metal
	name = "large airlock assembly"
	base_name = "large airlock"
	icon = 'modular_skyrat/modules/large_doors/icons/metal/multi_tile.dmi'
	overlays_file = 'modular_skyrat/modules/large_doors/icons/metal/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/multi_tile/metal
	glass_type = /obj/machinery/door/airlock/multi_tile/glass

/obj/structure/door_assembly/multi_tile/glass
	name = "large glass airlock assembly"
	base_name = "large glass airlock"
	icon = 'modular_skyrat/modules/large_doors/icons/glass/multi_tile.dmi'
	overlays_file = 'modular_skyrat/modules/large_doors/icons/glass/overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/multi_tile/glass

