//Redefinitions of the diagonal directions so they can be stored in one var without conflicts
#define NORTH_JUNCTION NORTH //(1<<0)
#define SOUTH_JUNCTION SOUTH //(1<<1)
#define EAST_JUNCTION EAST  //(1<<2)
#define WEST_JUNCTION WEST  //(1<<3)
#define NORTHEAST_JUNCTION (1<<4)
#define SOUTHEAST_JUNCTION (1<<5)
#define SOUTHWEST_JUNCTION (1<<6)
#define NORTHWEST_JUNCTION (1<<7)

#define ALL_JUNCTION_DIRECTIONS list(\
	NORTH_JUNCTION,\
	SOUTH_JUNCTION,\
	EAST_JUNCTION,\
	WEST_JUNCTION,\
	NORTHEAST_JUNCTION,\
	SOUTHEAST_JUNCTION,\
	SOUTHWEST_JUNCTION,\
	NORTHWEST_JUNCTION\
	)

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
	last_day_night_color = subbed_day_night_controller.last_color
	last_day_night_alpha = subbed_day_night_controller.last_alpha

	var/mutable_appearance/appearance_to_add = mutable_appearance('modular_skyrat/modules/overmap/icons/daynight_blend.dmi', "white", DAY_NIGHT_LIGHTING_LAYER, LIGHTING_PLANE, 255, RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM)
	appearance_to_add.color = last_day_night_color
	appearance_to_add.alpha = last_day_night_alpha

	for(var/i in day_night_adjacent_turfs)
		var/turf/iterated_turf = i
		appearance_to_add.icon_state = "[day_night_adjacent_turfs[i]]"
		iterated_turf.underlays += appearance_to_add
		if(subbed_day_night_controller.has_applied_luminosity != last_day_night_luminosity)
			if(subbed_day_night_controller.has_applied_luminosity)
				iterated_turf.luminosity++
			else
				iterated_turf.luminosity--
	last_day_night_luminosity = subbed_day_night_controller.has_applied_luminosity

/area/proc/ClearDayNightTurfs()
	var/mutable_appearance/appearance_to_clear = mutable_appearance('modular_skyrat/modules/overmap/icons/daynight_blend.dmi', "white", DAY_NIGHT_LIGHTING_LAYER, LIGHTING_PLANE, 255, RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM)
	appearance_to_clear.color = last_day_night_color
	appearance_to_clear.alpha = last_day_night_alpha
	for(var/i in day_night_adjacent_turfs)
		var/turf/iterated_turf = i
		appearance_to_clear.icon_state = "[day_night_adjacent_turfs[i]]"
		iterated_turf.underlays -= appearance_to_clear
		if(!subbed_day_night_controller && last_day_night_luminosity)
			iterated_turf.luminosity--
			last_day_night_luminosity = null

/area/proc/UpdateDayNightTurfs(rebuild = FALSE, datum/day_night_controller/newsub, full_unsub = FALSE, find_controller = FALSE)
	if(outdoors)
		return
	if(find_controller)
		if(SSmapping && SSmapping.z_list) //Goddamn areas that initialize out of order?!
			var/datum/space_level/level = SSmapping.z_list[z]
			if(level && level.day_night_controller)
				newsub = level.day_night_controller
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

/area/proc/UpdateDayNightTurfsSimple() //Assumes we have a controller and turfs to do work with
	ClearDayNightTurfs()
	ApplyDayNightTurfs()

#undef NORTH_JUNCTION
#undef SOUTH_JUNCTION
#undef EAST_JUNCTION
#undef WEST_JUNCTION
#undef NORTHEAST_JUNCTION
#undef NORTHWEST_JUNCTION
#undef SOUTHEAST_JUNCTION
#undef SOUTHWEST_JUNCTION

#undef ALL_JUNCTION_DIRECTIONS
