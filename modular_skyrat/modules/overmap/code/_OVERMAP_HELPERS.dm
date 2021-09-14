/proc/GetLandmarksInZLevel(landmark_type, datum/space_level/z_level)
	var/list/compiled_list = list()
	for(var/i in GLOB.landmarks_list)
		var/obj/effect/landmark/landmark = i
		if(z_level.z_value == landmark.z && istype(landmark, landmark_type))
			compiled_list += landmark
	return compiled_list

/proc/GetRandomTurfInZLevelWithMargin(margin, datum/space_level/z_level)
	var/low_x = 1 + margin
	var/high_x = world.maxx - margin
	var/low_y = 1 + margin
	var/high_y = world.maxy - margin
	var/turf/located = locate(rand(low_x, high_x), rand(low_y, high_y), z_level.z_value)
	return located

//Gets the overmap object that is having the atom inside
/proc/GetHousingOvermapObject(atom/atom_insider)
	var/datum/overmap_object/overmap_object
	var/datum/space_level/level = SSmapping.z_list[atom_insider.z]
	if(level.related_overmap_object )
		overmap_object = level.related_overmap_object 
	else if(SSshuttle.is_in_shuttle_bounds(atom_insider))
		var/obj/docking_port/mobile/mobile_shuttle = SSshuttle.get_containing_shuttle(atom_insider)
		if(mobile_shuttle && mobile_shuttle.my_overmap_object)
			overmap_object = mobile_shuttle.my_overmap_object
	return overmap_object
