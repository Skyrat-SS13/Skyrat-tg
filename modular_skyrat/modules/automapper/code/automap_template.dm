/datum/map_template/automap_template
	name = "Automap Template"
	/// Our load turf
	var/turf/load_turf

/datum/map_template/automap_template/proc/preload(map_file = null, incoming_load_turf, incoming_clear = FALSE, template_name)
	if(!map_file)
		return

	if(template_name)
		name = template_name

	mappath = map_file

	if(incoming_load_turf)
		load_turf = incoming_load_turf

	preload_size(mappath) // We need to preload this so we can get the affected turfs to clear them up.
