// VISUAL NET
//
// The datum containing all the chunks.

#define CHUNK_SIZE	16

/datum/visualnet
	// The chunks of the map, mapping the areas that an object can see.
	var/list/chunks = list()
	var/list/sources = list()
	var/chunk_type = /datum/chunk
	var/list/valid_source_types

	//Temporary cache. Whenever a chunk updates, it tries to fetch data from here before asking the object directly,
	//This cache is erased at the end of every major chunk update
	var/list/visibility_cache = list()

/datum/visualnet/New()
	..()
	GLOB.visual_nets += src
	if(!valid_source_types)
		valid_source_types = list()

/datum/visualnet/Destroy()
	GLOB.visual_nets -= src
	for(var/source in sources)
		remove_source(source, FALSE)
	sources.Cut()
	for(var/chunk in chunks)
		qdel(chunk)
	chunks.Cut()
	. = ..()

// Checks if a chunk has been Generated in x, y, z.
/datum/visualnet/proc/is_chunk_generated(x, y, z)
	x &= ~0xf
	y &= ~0xf
	var/key = "[x],[y],[z]"
	return !isnull(chunks[key])

// Returns the chunk in the x, y, z.
// If there is no chunk, it creates a new chunk and returns that.
/datum/visualnet/proc/get_chunk(x, y, z)
	x &= ~0xf
	y &= ~0xf
	var/key = "[x],[y],[z]"
	if(!chunks[key])
		chunks[key] = new chunk_type(src, x, y, z)

	return chunks[key]

// Updates what the eye can see. It is recommended you use this when the eye moves or its location is set.

/datum/visualnet/proc/update_eye_chunks(mob/observer/eye/eye, var/full_update = FALSE)
	. = list()
	var/turf/T = get_turf(eye)
	if(T)
		// 0xf = 15
		var/x1 = max(0, T.x - CHUNK_SIZE) & ~0xf
		var/y1 = max(0, T.y - CHUNK_SIZE) & ~0xf
		var/x2 = min(world.maxx, T.x + CHUNK_SIZE) & ~0xf
		var/y2 = min(world.maxy, T.y + CHUNK_SIZE) & ~0xf

		for(var/x = x1; x <= x2; x += CHUNK_SIZE)
			for(var/y = y1; y <= y2; y += CHUNK_SIZE)
				. += get_chunk(x, y, T.z)

	if(full_update)
		eye.visibleChunks.Cut()

	var/list/remove = eye.visibleChunks - .
	var/list/add = . - eye.visibleChunks

	for(var/chunk in remove)
		var/datum/chunk/c = chunk
		c.remove_eye(eye)

	for(var/chunk in add)
		var/datum/chunk/c = chunk
		c.add_eye(eye)

/datum/visualnet/proc/remove_eye(mob/observer/eye/eye)
	for(var/chunk in eye.visibleChunks)
		var/datum/chunk/c = chunk
		c.remove_eye(eye)

// Updates the chunks that the turf is located in. Use this when obstacles are destroyed or	when doors open.

/datum/visualnet/proc/update_visibility(atom/A, var/opacity_check = TRUE)
	if(!ticker || (opacity_check && !A.opacity))
		return
	major_chunk_change(A)

/datum/visualnet/proc/update_visibility_nocheck(atom/A)
	update_visibility(A, FALSE)

// Will check if an atom is on a viewable turf. Returns 1 if it is, otherwise returns 0.
/datum/visualnet/proc/is_visible(var/atom/target)
	// 0xf = 15
	var/turf/position = get_turf(target)
	return position && is_turf_visible(position)

/datum/visualnet/proc/is_turf_visible(var/turf/position)
	if(!position)
		return FALSE
	var/datum/chunk/chunk = get_chunk(position.x, position.y, position.z)
	if(chunk)
		if(chunk.dirty)
			chunk.update(TRUE) // Update now, no matter if it's visible or not.
		if(position in chunk.visibleTurfs)
			return TRUE
	return FALSE

// Never access this proc directly!!!!
// This will update the chunk and all the surrounding chunks.
/datum/visualnet/proc/major_chunk_change(var/atom/source)
	for_all_chunks_in_range(source, /datum/chunk/proc/visibility_changed, list())

/datum/visualnet/proc/add_source(var/atom/source, var/update_visibility = TRUE, var/opacity_check = FALSE)
	if(!(source && is_type_in_list(source, valid_source_types)))
		log_visualnet("Was given an unhandled source", source)
		return FALSE
	if(source in sources)
		return FALSE

	sources += source
	GLOB.moved_event.register(source, src, /datum/visualnet/proc/source_moved)
	GLOB.destroyed_event.register(source, src, /datum/visualnet/proc/remove_source)
	for_all_chunks_in_range(source, /datum/chunk/proc/add_source, list(source), null, source.get_visualnet_range(src))
	if(update_visibility)
		update_visibility(source, opacity_check)
	return TRUE

/datum/visualnet/proc/remove_source(var/atom/source, var/update_visibility = TRUE, var/opacity_check = FALSE)
	if(!sources.Remove(source))
		return FALSE

	GLOB.moved_event.unregister(source, src, /datum/visualnet/proc/source_moved)
	GLOB.destroyed_event.unregister(source, src, /datum/visualnet/proc/remove_source)
	for_all_chunks_in_range(source, /datum/chunk/proc/remove_source, list(source), null, source.get_visualnet_range(src))
	if(update_visibility)
		update_visibility(source, opacity_check)
	return TRUE

/datum/visualnet/proc/source_moved(var/atom/movable/source, var/old_loc, var/new_loc)
	var/turf/old_turf = get_turf(old_loc)
	var/turf/new_turf = get_turf(new_loc)

	if(old_turf == new_turf)
		return

	// A more proper way would be to figure out which chunks have gone out of range, and which have come into range
	//  and only remove/add to those.
	if(old_turf)
		for_all_chunks_in_range(source, /datum/chunk/proc/remove_source, list(source), old_turf)
	if(new_turf)
		for_all_chunks_in_range(source, /datum/chunk/proc/add_source, list(source), new_turf)


/datum/visualnet/proc/for_all_chunks_in_range(var/atom/source, var/proc_call, var/list/proc_args, var/turf/T, var/range)
	T = T ? T : get_turf(source)
	if(!T)
		return

	if (!range)
		range = CHUNK_SIZE

	var/x1 = floor_to_multiple(max(0, T.x - range), CHUNK_SIZE)// & ~0xf
	var/y1 = floor_to_multiple(max(0, T.y - range), CHUNK_SIZE)// & ~0xf
	var/x2 = ceiling_to_multiple(min(world.maxx, T.x + range), CHUNK_SIZE)// & ~0xf
	var/y2 = ceiling_to_multiple(min(world.maxy, T.y + range), CHUNK_SIZE)// & ~0xf

	for(var/x = x1; x <= x2; x += CHUNK_SIZE)
		for(var/y = y1; y <= y2; y += CHUNK_SIZE)
			var/datum/chunk/c = get_chunk(x, y, T.z)
			call(c, proc_call)(arglist(proc_args))

	//Clear the cache after one major chunk update cycle
	//This means we're getting less efficiency than we could have, but its simple and prevents bugs
	//Possible future todo: Let it be cleared less often
	visibility_cache = list()


/client/proc/view_chunk()
	set name = "View Chunk"
	set category = "Debug"
	var/turf/T = get_turf(mob)
	T.view_chunk()

// Debug verb for VVing the chunk that the turf is in.
/turf/proc/view_chunk()
	set name = "View Chunk"
	set category = "Debug"
	set src in world

	if(GLOB.necrovision.is_chunk_generated(x, y, z))
		var/datum/chunk/chunk = GLOB.necrovision.get_chunk(x, y, z)
		usr.client.debug_variables(chunk)

/client/proc/update_chunk()
	set name = "Update Chunk"
	set category = "Debug"
	var/turf/T = get_turf(mob)
	T.update_chunk()

/turf/proc/update_chunk(var/force_update = TRUE, var/datum/visualnet/V)
	set name = "Update Chunk"
	set category = "Debug"
	set src in world

	if (!V)
		V = GLOB.necrovision

	//Clear the cache when we do this. Its only for batching, not single chunk updates
	V.visibility_cache = list()

	if(V.is_chunk_generated(x, y, z))
		var/datum/chunk/chunk = GLOB.necrovision.get_chunk(x, y, z)
		chunk.visibility_changed(force_update)



/turf/proc/is_in_visualnet(var/datum/visualnet/V)
	for (var/coord as anything in V.chunks)
		var/datum/chunk/C = V.chunks[coord]
		for (var/turf/T as anything in C.visibleTurfs)
			if (T == src)
				return TRUE

	return FALSE