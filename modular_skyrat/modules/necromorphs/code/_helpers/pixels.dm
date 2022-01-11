/atom/proc/get_global_pixel_loc()
	return get_new_vector(((x-1)*world.icon_size) + pixel_x + 16, ((y-1)*world.icon_size) + pixel_y + 16)

//A slightly less efficient wrapper for the above which accounts for the possibility of src not being on a turf
/atom/proc/get_toplevel_global_pixel_loc()
	if (isturf(loc))
		return get_global_pixel_loc()

	else
		var/atom/A = get_toplevel_atom()
		return A.get_global_pixel_loc()

//Turfs cant be inside things
/turf/get_toplevel_global_pixel_loc()
	return get_global_pixel_loc()

/atom/proc/get_global_pixel_offset(var/atom/from)
	var/vector2/ourloc = get_global_pixel_loc()
	var/vector2/fromloc = from.get_global_pixel_loc()
	ourloc.SelfSubtract(fromloc)
	release_vector(fromloc)
	return ourloc
