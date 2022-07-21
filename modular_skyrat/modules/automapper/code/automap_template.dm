/datum/map_template/automap_template
	name = "Automap Template"
	/// Our load turf
	var/turf/load_turf
	/// The map for which we load on
	var/override_map_name

/**
 * Used to calculate the area affected and set up the template for immediate and easy loading.
 */
/datum/map_template/automap_template/proc/preload(map_file, incoming_override_map_name, incoming_load_turf, template_name)
	if(!map_file)
		return
	mappath = map_file

	if(!incoming_override_map_name)
		return
	override_map_name = incoming_override_map_name

	if(template_name)
		name = template_name

	if(incoming_load_turf)
		load_turf = incoming_load_turf

	preload_size(mappath) // We need to preload this so we can get the affected turfs to clear them up.


