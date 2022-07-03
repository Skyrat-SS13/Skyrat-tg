/**
 * Clear everything
 *
 * A more useful version of empty.
 */
/turf/proc/clear_everything(turf_type = /turf/open/space, baseturf_type, list/ignore_typecache, flags, list/ignored_atoms = list(/mob/dead))
	// Remove all atoms except observers, landmarks, docking ports
	var/list/allowed_contents = typecache_filter_list_reverse(get_all_contents_ignoring(ignore_typecache), ignored_atoms)
	allowed_contents -= src
	for(var/i in 1 to allowed_contents.len)
		var/thing = allowed_contents[i]
		qdel(thing, force=TRUE)

	if(turf_type)
		var/turf/newT = ChangeTurf(turf_type, baseturf_type, flags)
		SSair.remove_from_active(newT)
		CALCULATE_ADJACENT_TURFS(newT, KILL_EXCITED)
