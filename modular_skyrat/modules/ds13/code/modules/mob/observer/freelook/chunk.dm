#define UPDATE_BUFFER 25 // 2.5 seconds

// CHUNK
//
// A 16x16 grid of the map with a list of turfs that can be seen, are visible and are dimmed.
// Allows the Eye to stream these chunks and know what it can and cannot see.

/datum/obfuscation
	var/icon = 'icons/effects/cameravis.dmi'
	var/icon_state = "black"
	var/list/obfuscation_images = list()
	var/static/icon/obfuscation_underlay
	// There is an exploit were clients can memory-edit their local version of the static images, allowing them to see everything. This is a minor attempt to make that more difficult.

/datum/obfuscation/Destroy()
	obfuscation_images.Cut()
	. = ..()

/datum/obfuscation/proc/has_obfuscation(var/turf/T)
	return !isnull(obfuscation_images[T])

/datum/obfuscation/proc/get_obfuscation(var/turf/T)
	var/image/obfuscation = obfuscation_images[T]
	if(!obfuscation)
		obfuscation = image(icon, T, icon_state)
		obfuscation.plane = OBSCURITY_PLANE
		if(!obfuscation_underlay)
			// Creating a new icon of a fairly common icon state, adding some random color to prevent address searching, and hoping being static kills memory locality
			var/turf/floor = /turf/simulated/floor/tiled
			obfuscation_underlay = icon(initial(floor.icon), initial(floor.icon_state))
			obfuscation_underlay.Blend(rgb(rand(0,255),rand(0,255),rand(0,255)))
		obfuscation.underlays += obfuscation_underlay
		obfuscation_images[T] = obfuscation
	return obfuscation

/datum/chunk
	var/datum/visualnet/visualnet
	var/list/obscuredTurfs = list()
	var/list/visibleTurfs = list()
	var/list/obscured = list()
	var/list/turfs = list()
	var/list/seenby = list()
	var/list/sources = list()
	var/dirty = FALSE
	var/updating = FALSE
	var/x = 0
	var/y = 0
	var/z = 0
	var/datum/obfuscation/obfuscation = new()

// Create a new chunk, since the chunks are made as they are needed.
/datum/chunk/New(var/datum/visualnet/visualnet, x, y, z)
	..()
	src.visualnet = visualnet
	SSchunk.chunks += src
	// 0xf = 15
	x &= ~0xf
	y &= ~0xf

	src.x = x
	src.y = y
	src.z = z

	for(var/turf/t in range(10, locate(x + 8, y + 8, z)))
		if(t.x >= x && t.y >= y && t.x < x + 16 && t.y < y + 16)
			turfs[t] = t

	add_sources(visualnet.sources)
	acquire_visible_turfs(visibleTurfs)

	// Removes turf that isn't in turfs.
	visibleTurfs &= turfs
	obscuredTurfs = turfs - visibleTurfs

	for(var/turf in obscuredTurfs)
		var/turf/t = turf
		obscured += obfuscation.get_obfuscation(t)

/datum/chunk/Destroy()
	visualnet = null
	SSchunk.chunks -= src
	. = ..()

/datum/chunk/proc/add_sources(var/list/sources)
	var/turf/center = locate(x + 8, y + 8, z)
	for(var/entry in sources)
		var/atom/A = entry
		if(get_dist(get_turf(A), center) > (8+A.get_visualnet_range()))
			continue
		add_source(A)

/datum/chunk/proc/add_source(var/atom/source)
	if(source in sources)
		return FALSE
	sources += source
	visibility_changed()
	return TRUE

/datum/chunk/proc/remove_source(var/atom/source)
	if(sources.Remove(source))
		visibility_changed()
		return TRUE
	return FALSE

// The visual net is responsible for adding/removing eyes.
/datum/chunk/proc/add_eye(mob/observer/eye/eye)

	seenby |= eye
	eye.visibleChunks |= src
	if (dirty)
		update(FALSE)
	if(eye.owner && eye.owner.client)
		eye.owner.client.images += obscured

/datum/chunk/proc/remove_eye(mob/observer/eye/eye)
	seenby -= eye
	eye.visibleChunks -= src
	if(eye.owner && eye.owner.client)
		eye.owner.client.images -= obscured

// Updates the chunk, makes sure that it doesn't update too much. If the chunk isn't being watched it will
// instead be flagged to update the next time an AI Eye moves near it.

SUBSYSTEM_DEF(chunk)
	name = "Chunks"
	priority = SS_PRIORITY_CHUNKS
	wait = 1.25 SECONDS //You may want to change this to 3 if it needs throttling, but the MC will choke this down if it gets too laggy anyway.
	flags = SS_POST_FIRE_TIMING
	var/list/chunks = list() //Chunks that we're processing.

/datum/controller/subsystem/chunk/fire()
	if(!chunks.len) //Well, yeah, no need right?
		return
	for(var/datum/chunk/C in chunks)
		if(C.dirty && C.seenby.len) //Only update the chunks that are in view, and are marked as needing an update.
			C.update()

//Wrapper proc to mark the chunk as dirty and in need of updating.
/datum/chunk/proc/visibility_changed()
	dirty = TRUE

// The actual updating.

/datum/chunk/proc/update(force=FALSE)
	//Allow the other chunks to update async.
	set waitfor = FALSE
	//If we're not forced to update, don't. The subsystem should be running quickly enough to mean that we don't even really need to force update.
	if(!dirty || updating && !force)
		return FALSE
	updating = TRUE	//Immediately set updating true to block additional attempts
	dirty = FALSE // We're already updating this chunk, so no need to re-re update it.

	var/list/newVisibleTurfs = new()
	acquire_visible_turfs(newVisibleTurfs)

	// Removes turf that isn't in turfs.
	newVisibleTurfs &= turfs

	var/list/visAdded = newVisibleTurfs - visibleTurfs
	var/list/visRemoved = visibleTurfs - newVisibleTurfs

	visibleTurfs = newVisibleTurfs
	obscuredTurfs = turfs - newVisibleTurfs
	var/list/obfuscation_to_add = list()
	var/list/obfuscation_to_remove = list()

	for(var/turf/t in visAdded)
		if(obfuscation.has_obfuscation(t))
			var/image/obfuscation_image = obfuscation.get_obfuscation(t)
			obscured -= obfuscation_image
			obfuscation_to_remove += obfuscation_image

	for(var/turf/t in visRemoved)
		if(obscuredTurfs[t])
			var/image/obfuscation_image = obfuscation.get_obfuscation(t)
			obscured += obfuscation_image
			obfuscation_to_add += obfuscation_image

	if(obfuscation_to_add.len)
		apply_visibility(FALSE, obfuscation_to_add)
	if(obfuscation_to_remove.len)
		apply_visibility(TRUE, obfuscation_to_remove)
	updating = FALSE

/datum/chunk/proc/apply_visibility(remove=TRUE, list/update_list)
	set waitfor = FALSE
	//There's no way of getting around this, we'll have to take the hit, however this shouldn't be too bad as each chunk is relatively small.
	for(var/image/obfuscation_image in update_list)
		for(var/eye in seenby)
			var/mob/observer/eye/m = eye
			if(m && m.owner && m.owner.client)
				if(remove)
					m.owner.client.images -= obfuscation_image
				else
					m.owner.client.images += obfuscation_image

/datum/chunk/proc/acquire_visible_turfs(var/list/visible)
	return

//Attempt to fetch from cache before asking the object to recalculate things
/datum/chunk/proc/get_datum_visible_turfs(var/datum/A)
	if (!visualnet.visibility_cache[A])
		visualnet.visibility_cache[A] = A.get_visualnet_tiles(visualnet)
	return visualnet.visibility_cache[A]

/proc/seen_turfs_in_range(var/source, var/range)
	var/turf/pos = get_turf(source)
	var/list/things = hear(range, pos)
	for (var/a in things)
		if (!isturf(a))
			things.Remove(a)

/datum/chunk/proc/debug_mark(var/marktype = "all", var/duration = 20 SECONDS)
	var/list/to_mark = list()
	if (marktype == "all")
		to_mark = turfs
	if (marktype == "visible")
		to_mark = visibleTurfs
	if (marktype == "obscured")
		to_mark = obscuredTurfs


	for (var/T in to_mark)
		debug_mark_turf(T, duration)

#undef UPDATE_BUFFER
