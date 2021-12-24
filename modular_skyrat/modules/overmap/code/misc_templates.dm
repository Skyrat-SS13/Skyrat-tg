/datum/misc_template
	var/name = "Misc Template"
	/// Map path to file to supply for the planet to be loaded from
	var/map_path
	/// Name of the map file
	var/map_file
	// ALTERNATIVELY you can supply an area and a map generator
	/// Traits that the levels will recieve
	var/default_traits_input
	/// The type of the overmap object that will be created
	var/datum/overmap_object/overmap_type = /datum/overmap_object/shuttle

/datum/misc_template/proc/LoadTemplate(datum/overmap_sun_system/system, coordinate_x, coordinate_y)
	var/datum/overmap_object/linked_overmap_object = new overmap_type(system, coordinate_x, coordinate_y)
	if(map_path)
		if(!map_file)
			WARNING("No map file passed on map generation")
		SSmapping.LoadGroup(null,
							name,
							map_path,
							map_file,
							default_traits = default_traits_input,
							ov_obj = linked_overmap_object
		)

/datum/misc_template/ncv_titan
	name = "NCV Titan"
	map_path = "map_files/generic"
	map_file = "ncv_titan.dmm"
	overmap_type = /datum/overmap_object/shuttle/ship/ncv_titan
