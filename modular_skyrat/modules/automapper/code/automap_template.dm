/datum/map_template/automap_template
	name = "Automap Template"

/datum/map_template/automap_template/load(turf/T, centered = FALSE, map_file = null, clear_everything)
	if(!map_file)
		return

	mappath = map_file

	preload_size(mappath) // We need to preload this so we can get the affected turfs to clear them up.

	if(clear_everything)
		var/list/turfs_to_annihilate = get_affected_turfs(T, centered)
		for(var/turf/iterating_turf as anything in turfs_to_annihilate)
			iterating_turf.clear_everything()
	. = ..()
