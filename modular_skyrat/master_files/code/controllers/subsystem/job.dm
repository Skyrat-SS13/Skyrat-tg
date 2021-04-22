/datum/controller/subsystem/mapping/proc/get_prisoner_spawns()
	for(var/turf/open/floor/T in world)
		var/area/turf_area = get_area(T)
		if(is_station_level(T.z) && istype(turf_area, /area/security/prison))
			if(!(/obj/structure/grille in turf_area.contents))
				prisoner_spawn_locs += T.loc
