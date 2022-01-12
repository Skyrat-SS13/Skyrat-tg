/*
    This extension coordinates physical presence for atoms larger than a single tile in size.

    This only applies to collision box. Not visuals.
    Plenty of things extend outside their tile visually but still only have 1x1 collision

	This extension makes a few assumptions
		-Only width and height are supported, no x and y offsets
		-All width and height values are in multiples of WORLD_ICON_SIZE. No remainder
		-Bounding boxes are rectangular and convex in shape
		-Only 2D bounding boxes are supported for now. No creatures spanning multiple zlevels yet
*/
/datum/extension/updating/large_atom
	var/list/turfs_occupied = list()

/datum/extension/updating/large_atom/Initialize()
	var/atom/movable/A = holder
	GLOB.moved_event.register(A, src, /datum/extension/updating/proc/update)


/datum/extension/updating/large_atom/update()

	if (QDELETED(holder))
		return

	//Unregister old tiles
	for (var/turf/T as anything in turfs_occupied)
		LAZYREMOVE(T.movement_blocking_atoms,holder)

	turfs_occupied = list()

	var/atom/movable/A = holder
	var/tile_width = A.bound_width / WORLD_ICON_SIZE
	var/tile_height = A.bound_height / WORLD_ICON_SIZE
	var/turf/T1 = get_turf(A)

	if (!T1)
		return

	var/vector2/coords = get_new_vector(T1.x, T1.y)
	coords.x = min(coords.x + (tile_width -1), world.maxx)
	coords.y = min(coords.y + (tile_height -1), world.maxy)
	var/turf/T2 = locate(coords.x, coords.y, T1.z)

	//Now we have both corners of the bounding box, lets get all the turfs in them
	turfs_occupied = block(T1, T2)

	for (var/turf/T as anything in turfs_occupied)
		LAZYDISTINCTADD(T.movement_blocking_atoms,holder)


/atom/movable/proc/set_bounds(width, height)
	bound_width = width
	bound_height = height

	update_extension(/datum/extension/updating/large_atom, TRUE)