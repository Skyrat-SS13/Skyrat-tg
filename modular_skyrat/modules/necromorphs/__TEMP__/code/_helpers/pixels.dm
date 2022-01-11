//Takes click params as input, returns a vector2 of pixel location relative to client lowerleft corner
/proc/get_screen_pixel_click_location(var/params)
	var/screen_loc = params2list(params)["screen-loc"]
	/* This regex matches a screen-loc of the form
			"[tile_x]:[step_x],[tile_y]:[step_y]"
		given by the "params" argument of the mouse events.
	*/
	var global/regex/ScreenLocRegex = regex("(\\d+):(\\d+),(\\d+):(\\d+)")
	var/vector2/position = get_new_vector(0,0)
	if(ScreenLocRegex.Find(screen_loc))
		var list/data = ScreenLocRegex.group
		//position.x = text2num(data[2]) + (text2num(data[1])) * world.icon_size
		//position.y = text2num(data[4]) + (text2num(data[3])) * world.icon_size

		position.x = text2num(data[2]) + (text2num(data[1]) - 1) * world.icon_size
		position.y = text2num(data[4]) + (text2num(data[3]) - 1) * world.icon_size

	return position

//Gets a global-context pixel location. This requires a client to use
/proc/get_global_pixel_click_location(var/params, var/client/client)

	if (!client)
		return get_new_vector(0,0)

	var/vector2/screen_loc = get_screen_pixel_click_location(params)


	var/vector2/world_loc = client.ViewportToWorldPoint(screen_loc)
	release_vector(screen_loc)
	return world_loc

//This mildly complicated proc attempts to move thing to where the user's mouse cursor is
//Thing must be an atom that is already onscreen - ie, in a client's screen list
/proc/sync_screen_loc_to_mouse(var/atom/movable/thing, var/params, var/tilesnap = FALSE, var/vector2/offset = Vector2.Zero)
	var/screen_loc = params2list(params)["screen-loc"]
	var/global/regex/ScreenLocRegex = regex("(\\d+):(\\d+),(\\d+):(\\d+)")
	if(ScreenLocRegex.Find(screen_loc))
		var/list/data = ScreenLocRegex.group
		if (!tilesnap)
			thing.screen_loc = "[data[1]]:[text2num(data[2])+offset.x],[data[3]]:[text2num(data[4])+offset.y]"
		else
			thing.screen_loc = "[data[1]]:[offset.x],[data[3]]:[offset.y]"
		//This will fill screen loc with a string in the form:
			//"TileX:PixelX,TileY:PixelY"



/*
	Getters

*/


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

/*
	This rather specific proc returns the magnitude of the offset along the normal between the source and target atom
	For example:
		If target is directly west or east, only the X value of the offset is used
		if target is north or south, only the Y value of offset is used

		If target is on a diagonal we'll just use the whole offset, though this is inaccurate and not final behaviour
		Future todo: Project diagonals onto a 45 degree line
*/
/atom/proc/get_normal_pixel_offset(var/atom/from)
	var/vector2/offset = get_global_pixel_offset(from)
	if(x == from.x)
		offset.x = 0

	if (y == from.y)
		offset.y = 0

	.= offset.Magnitude()
	release_vector(offset)

/atom/proc/get_global_pixel_offset_from_vector(var/vector2/fromloc)
	var/vector2/ourloc = get_global_pixel_loc()
	ourloc.SelfSubtract(fromloc)
	return ourloc

//Returns a float value of pixels between two objects
/atom/proc/get_global_pixel_distance(var/atom/from)
	var/vector2/offset = get_global_pixel_loc()
	var/vector2/fromloc = from.get_global_pixel_loc()
	offset.SelfSubtract(fromloc)
	release_vector(fromloc)
	. = offset.Magnitude()
	release_vector(offset)


//Given a set of global pixel coords as input, this moves the atom and sets its pixel offsets so that it sits exactly on the specified point
/atom/movable/proc/set_global_pixel_loc(var/vector2/coords)

	var/vector2/tilecoords = get_new_vector(round(coords.x / world.icon_size)+1, round(coords.y / world.icon_size)+1)
	forceMove(locate(tilecoords.x, tilecoords.y, z))
	pixel_x = (coords.x % world.icon_size)-16
	pixel_y = (coords.y % world.icon_size)-16
	release_vector(tilecoords)


//Takes pixel coordinates relative to a tile. Returns true if those coords would offset an object to outside the tile
/proc/is_outside_cell(var/vector2/newpix)
	if (newpix.x < -16 || newpix.x > 16 || newpix.y < -16 || newpix.y > 16)
		return TRUE

//Takes pixel coordinates relative to a tile. Returns true if those coords would offset an object to more than 8 pixels into an adjacent tile
/proc/is_far_outside_cell(var/vector2/newpix)
	if (newpix.x < -24 || newpix.x > 24 || newpix.y < -24 || newpix.y > 24)
		return TRUE

//Returns the turf over which the mob's view is centred. Only relevant if view offset is set
/mob/proc/get_view_centre()
	if (!view_offset)
		return get_turf(src)

	var/vector2/offset = (Vector2.FromDir(dir))*view_offset //Doing the multiply inline here creates a new vector which we need anyway
	var/turf/T = get_turf_at_pixel_offset(offset)
	release_vector(offset)
	return T


//Returns the turf over which the mob's view is centred. Only relevant if view offset is set
/client/proc/get_view_centre()
	return mob.get_view_centre()

//Given a pixel offset relative to this atom, finds the turf under the target point.
//This does not account for the object's existing pixel offsets, roll them into the input first if you wish
/atom/proc/get_turf_at_pixel_offset(var/vector2/newpix)
	//First lets just get the global pixel position of where this atom+newpix is
	var/vector2/new_global_pixel_loc = get_new_vector(((x-1)*world.icon_size) + newpix.x + 16, ((y-1)*world.icon_size) + newpix.y + 16)

	var/turf/T = get_turf_at_pixel_coords(new_global_pixel_loc, z)
	release_vector(new_global_pixel_loc)
	return T



//Global version of the above, requires a zlevel to check on
/proc/get_turf_at_pixel_coords(var/vector2/coords, var/zlevel)
	var/vector2/newcoords = get_new_vector(round(coords.x / world.icon_size)+1, round(coords.y / world.icon_size)+1)
	var/turf/T = locate(newcoords.x, newcoords.y, zlevel)
	release_vector(newcoords)
	return T

/proc/get_turf_at_mouse(var/clickparams, var/client/C)
	var/vector2/pixels = get_global_pixel_click_location(clickparams, C)
	var/turf/T = get_turf_at_pixel_coords(pixels, C.mob.z)
	release_vector(pixels)
	return T



/*
	Setters
*/
//Moves this atom into the specified turf physically, but adjusts its pixel X/Y so that its global pixel loc remains the same
/atom/movable/proc/set_turf_maintain_pixels(var/turf/T)
	var/vector2/offset = get_global_pixel_offset(T)
	//forceMove(T)
	loc = T
	pixel_x = offset.x
	pixel_y = offset.y
	release_vector(offset)

//Inverse of the above, sets our global pixel loc to a specified value, but keeps us within the same turf we're currently in
/atom/movable/proc/set_pixels_maintain_turf(var/vector2/offset)
	var/vector2/ourloc = get_global_pixel_loc()
	var/vector2/ouroffset = offset - ourloc
	pixel_x += ouroffset.x
	pixel_y += ouroffset.y
	release_vector(ourloc)
	release_vector(ouroffset)


//Client Procs

//This proc gets the client's total pixel offset from its eyeobject
/client/proc/get_pixel_offset()
	var/vector2/offset
	if (ismob(eye))
		var/mob/M = eye
		offset = (Vector2.FromDir(M.dir))*M.view_offset
	else
		offset = get_new_vector(0,0)

	offset.x += pixel_x
	offset.y += pixel_y

	return offset


//Figures out the offsets of the bottomleft and topright corners of the game window
/client/proc/get_pixel_bounds()
	var/radius = view_radius * world.icon_size
	var/vector2/bottomleft = get_new_vector(-radius, -radius)
	var/vector2/topright = get_new_vector(radius, radius)
	var/vector2/offset = get_pixel_offset()
	bottomleft.SelfAdd(offset)
	topright.SelfAdd(offset)

	return list("BL" = bottomleft, "TR" = topright, "OFFSET" = offset)


//Figures out the offsets of the bottomleft and topright corners of the game window in tiles
//There are no decimal tiles, it will always be a whole number. Partially visible tiles can be included or excluded
/client/proc/get_tile_bounds(var/include_partial = TRUE)
	var/list/bounds = get_pixel_bounds()
	for (var/thing in bounds)
		var/vector2/corner = bounds[thing]
		corner.SelfDivide(WORLD_ICON_SIZE)
		if (include_partial)
			corner.SelfCeiling()
		else
			corner.SelfFloor()
		bounds[thing] = corner
	return bounds


/atom/proc/set_offset_to(var/atom/target, var/distance)
	pixel_x = 0
	pixel_y = 0
	offset_to(target, distance)

/atom/proc/offset_to(var/atom/target, var/distance, var/square = FALSE)
	if (!square)
		var/vector2/delta = get_offset_to(target, distance)
		pixel_x += delta.x
		pixel_y += delta.y
		release_vector(delta)
	else
		var/x_mult = 0
		var/y_mult = 0
		if (x > target.x)
			x_mult = -1
		else if (x < target.x)
			x_mult = 1

		if (y > target.y)
			y_mult = -1
		else if (y < target.y)
			y_mult = 1

		pixel_x += distance * x_mult
		pixel_y += distance * y_mult


/atom/proc/get_offset_to(var/atom/target, var/distance)
	var/vector2/delta = Vector2.NewFromDir(get_dir(src, target))
	delta.SelfMultiply(distance)
	return delta

/atom/proc/modify_pixels(var/vector2/delta)
	pixel_x += delta.x
	pixel_y += delta.y

//Variables:
//Source: The source of the line
//Line: Vector2, the vector we will project ourselves onto
//Mover: The thing that will move onto the line. The magnitude of the line should be measured in pixels and it must be long enough
//Adjusts pixel offsets to place mover onto the nearest point along Line
/proc/place_on_projection_line(var/atom/source, var/vector2/line, var/atom/mover)

	//First of all, where is the mover relative to the source
	var/vector2/pixel_offset = mover.get_global_pixel_offset(source)

	var/vector2/rejection = pixel_offset.Rejection(line)
	mover.modify_pixels(rejection*-1)
	release_vector(pixel_offset)
	release_vector(rejection)






/*
	Pixel motion
	This function moves an object by a number of pixels supplied as a vector2 delta

	In the process of moving, the object's tile location will be updated if it enters a new tile, and it will stop on the edge and trigger
	bumps if it fails to enter a tile

*/
/atom/movable/proc/pixel_move(var/vector2/position_delta, var/time_delta)
	//Now before we do animating, lets check if this movement is going to put us into a different tile
	var/vector2/newpix = get_new_vector((pixel_x + position_delta.x), (pixel_y + position_delta.y))
	var/blocked = FALSE
	.=TRUE
	if (is_outside_cell(newpix))
		//Yes it will, alright we need to do multitile movement


		var/turf/target_tile = get_turf_at_pixel_offset(newpix)

		//There's no tile there? We must be at the edge of the map, abort!
		if (!target_tile)
			return

		var/turf/oldloc = get_turf(src)

		//get all the turfs between us and the target
		var/list/turfs = get_line_between(oldloc, target_tile)

		//Used to track our progress through the list
		var/endpoint = 2

		animate_movement = NO_STEPS

		while (endpoint <= turfs.len)
			oldloc = turfs[endpoint-1]
			var/turf/newloc = turfs[endpoint]

			endpoint++
			var/vector2/cached_global_pixels = get_global_pixel_loc()

			var/moved = Move(newloc)
			if (!moved)
				blocked = TRUE

			else
				set_pixels_maintain_turf(cached_global_pixels)



			//Something blocked us!
			//We will move up to it
			if (blocked)
				.= FALSE
				var/closest_magnitude = INFINITY
				var/vector2/closest_delta

				var/vector2/current_pixel_loc = get_global_pixel_loc()
				var/list/intersections = ray_turf_intersect(current_pixel_loc, position_delta, newloc)
				//This will contain exactly two elements, intersections, but we'll call them deltas here to save on an extra vector
				//We find which one is closest to our current position, that's the face we collide with
				for (var/vector2/delta as anything in intersections)
					delta.SelfSubtract(current_pixel_loc)
					var/mag = delta.Magnitude()
					if (mag < closest_magnitude)
						closest_magnitude = mag
						closest_delta = delta



				//We reduce the magnitude by 1 pixel to prevent glitching through walls
				//closest_delta = closest_delta.ToMagnitude(closest_delta.Magnitude() - 1)

				//Okay now we set newpix to the closest point, but clamp it to within our turf
				newpix.x = clamp(pixel_x + closest_delta.x, -(WORLD_ICON_SIZE/2), (WORLD_ICON_SIZE/2))
				newpix.y = clamp(pixel_y + closest_delta.y, -(WORLD_ICON_SIZE/2), (WORLD_ICON_SIZE/2))

				release_vector(current_pixel_loc)
				closest_delta = null //This will be released from the intersections list
				release_vector_list(intersections)


				//Break out of this loop, we have failed to reach the original target
				break
			else
				//If nothing blocks us, then we're clear to just swooce right into that tile.
				//We'll instantly set our position into the tile and our offset to where we are, this prevents bugginess

				set_turf_maintain_pixels(newloc)
				newpix.x = (pixel_x + position_delta.x)
				newpix.y = (pixel_y + position_delta.y)

			release_vector(cached_global_pixels)


	animate(src, pixel_x = newpix.x, pixel_y = newpix.y, time = time_delta - min(time_delta*0.2, 0.5))
	//To reduce visual artefacts resulting from lag, we want the movement to finish slightly early
	//half a decisecond is ideal, but no more than 20% of the total time

	//We need to reset the animate_movement var, but not immediately,
	set_delayed_move_animation_reset(src, (time_delta+2))
	release_vector(newpix)


//Mobs that get their pixel offset messed up will be able to walk it off
/mob/living/pixel_move(var/vector2/position_delta, var/time_delta)
	.=..()
	set_extension(src, /datum/extension/conditionalmove/pixel_align)


