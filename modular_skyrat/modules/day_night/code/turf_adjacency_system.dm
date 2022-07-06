/area
	/// Lazy list of all turfs adjacent to a day/night cycle. Associative from turf to bitfield (8 bit smoothing bitmap)
	var/list/day_night_adjacent_turfs
	/// Lazy list of all turfs affected by day/night blending associative to their applied appearance.
	var/list/day_night_turf_appearance_translation
	var/last_day_night_color
	var/last_day_night_alpha
	var/last_day_night_luminosity
	var/datum/day_night_controller/subbed_day_night_controller

//Very, VERYYY expensive, unless used on small areas
/area/proc/InitDayNightAdjacentTurfs()
	LAZYCLEARLIST(day_night_adjacent_turfs)
	LAZYINITLIST(day_night_adjacent_turfs)
	for(var/turf/iterated_turf in contents)
		var/bitfield = NONE
		for(var/bit_step in ALL_JUNCTION_DIRECTIONS)
			var/turf/target_turf
			switch(bit_step)
				if(NORTH_JUNCTION)
					target_turf = locate(iterated_turf.x, iterated_turf.y + 1, iterated_turf.z)
				if(SOUTH_JUNCTION)
					target_turf = locate(iterated_turf.x, iterated_turf.y - 1, iterated_turf.z)
				if(EAST_JUNCTION)
					target_turf = locate(iterated_turf.x + 1, iterated_turf.y, iterated_turf.z)
				if(WEST_JUNCTION)
					target_turf = locate(iterated_turf.x - 1, iterated_turf.y, iterated_turf.z)
				if(NORTHEAST_JUNCTION)
					if(bitfield & NORTH_JUNCTION || bitfield & EAST_JUNCTION)
						continue
					target_turf = locate(iterated_turf.x + 1, iterated_turf.y + 1, iterated_turf.z)
				if(SOUTHEAST_JUNCTION)
					if(bitfield & SOUTH_JUNCTION || bitfield & EAST_JUNCTION)
						continue
					target_turf = locate(iterated_turf.x + 1, iterated_turf.y - 1, iterated_turf.z)
				if(SOUTHWEST_JUNCTION)
					if(bitfield & SOUTH_JUNCTION || bitfield & WEST_JUNCTION)
						continue
					target_turf = locate(iterated_turf.x - 1, iterated_turf.y - 1, iterated_turf.z)
				if(NORTHWEST_JUNCTION)
					if(bitfield & NORTH_JUNCTION || bitfield & WEST_JUNCTION)
						continue
					target_turf = locate(iterated_turf.x - 1, iterated_turf.y + 1, iterated_turf.z)
			if(!target_turf)
				continue
			var/area/target_area = target_turf.loc
			if(target_area == src)
				continue
			if(!target_area.outdoors || target_area.underground)
				continue
			bitfield ^= bit_step

		if(!bitfield)
			continue
		day_night_adjacent_turfs[iterated_turf] = bitfield

	UNSETEMPTY(day_night_adjacent_turfs)

/area/proc/ApplyDayNightTurfs()
	LAZYINITLIST(day_night_turf_appearance_translation)

	var/datum/day_night_controller/controller = subbed_day_night_controller
	last_day_night_color = controller.last_color
	last_day_night_alpha = controller.last_alpha
	last_day_night_luminosity = controller.last_luminosity

	for(var/i in day_night_adjacent_turfs)
		var/turf/iterated_turf = i
		var/mutable_appearance/appearance_to_add = mutable_appearance('icons/effects/daynight_blend.dmi', "white", DAY_NIGHT_LIGHTING_LAYER, LIGHTING_PLANE, 255, RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM)
		appearance_to_add.icon_state = "[day_night_adjacent_turfs[i]]"
		appearance_to_add.color = last_day_night_color
		appearance_to_add.alpha = last_day_night_alpha
		day_night_turf_appearance_translation[iterated_turf] = appearance_to_add
		iterated_turf.underlays += appearance_to_add
		if(iterated_turf.lighting_object)
			iterated_turf.lighting_object.daynight_area = src
		if(last_day_night_luminosity)
			iterated_turf.luminosity = 1

/area/proc/ClearDayNightTurfs()
	for(var/i in day_night_adjacent_turfs)
		var/turf/iterated_turf = i
		iterated_turf.underlays -= day_night_turf_appearance_translation[iterated_turf]
		if(iterated_turf.lighting_object)
			iterated_turf.lighting_object.daynight_area = null
	day_night_turf_appearance_translation = null

/area/proc/UpdateDayNightTurfs(rebuild = FALSE, datum/day_night_controller/newsub, full_unsub = FALSE, find_controller = FALSE)
	if(outdoors)
		return
	if(find_controller)
		if(SSmapping && SSmapping.z_list) //Goddamn areas that initialize out of order?!
			var/datum/map_zone/mapzone = get_map_zone()
			if(mapzone && mapzone.day_night_controller)
				newsub = mapzone.day_night_controller
				rebuild = TRUE
		if(!newsub && subbed_day_night_controller)
			full_unsub = TRUE
	if(full_unsub)
		if(subbed_day_night_controller)
			subbed_day_night_controller.unsubscribe_blend_area(src)
	if(day_night_adjacent_turfs)
		ClearDayNightTurfs()
	if(rebuild)
		InitDayNightAdjacentTurfs()
	if(!day_night_adjacent_turfs)
		if(subbed_day_night_controller)
			subbed_day_night_controller.unsubscribe_blend_area(src)
		return
	if(newsub)
		if(subbed_day_night_controller)
			subbed_day_night_controller.unsubscribe_blend_area(src)
		newsub.subscribe_blend_area(src)
	if(subbed_day_night_controller)
		ApplyDayNightTurfs()
