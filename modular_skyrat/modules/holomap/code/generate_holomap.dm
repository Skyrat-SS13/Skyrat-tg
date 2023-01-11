// Holomap generation.

/// Turfs that will be colored as HOLOMAP_ROCK
#define IS_ROCK(tile) (istype(tile, /turf/closed/mineral) && tile.density)

/// Turfs that will be colored as HOLOMAP_OBSTACLE
#define IS_OBSTACLE(tile) (istype(tile, /turf/closed) ||  (locate(/obj/structure/window) in tile))

/// Turfs that will be colored as HOLOMAP_SOFT_OBSTACLE
#define IS_SOFT_OBSTACLE(tile) ((locate(/obj/structure/grille) in tile) || (locate(/obj/structure/lattice) in tile))

/// Turfs that will be colored as HOLOMAP_PATH
#define IS_PATH(tile) istype(tile, /turf/open/floor)

/// Turfs that contain a Z transition, like ladders and stairs. They show with special animations on the map.
#define HAS_Z_TRANSITION(tile) ((locate(/obj/structure/ladder) in tile) || (locate(/obj/structure/stairs) in tile))

/// Generates all the holo minimaps, initializing it all nicely, probably.
/datum/controller/subsystem/holomaps/proc/generate_holomaps()
	. = TRUE
	// Starting over if we're running midround (it runs real fast, so that's possible)
	holomaps.Cut()
	extra_holomaps.Cut()

	for(var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
		if(!generate_holomap(z))
			. = FALSE

	return .

/// Generates the base holomap and the area holomap, before passing the latter to setup_station_map to tidy it up for viewing.
/datum/controller/subsystem/holomaps/proc/generate_holomap(var/z_level = 1)
	// Sanity checks - Better to generate a helpful error message now than have DrawBox() runtime
	var/icon/canvas = icon(HOLOMAP_ICON, "blank")
	var/icon/area_canvas = icon(HOLOMAP_ICON, "blank")
	var/list/z_transition_positions = list()
	var/list/position_to_name = list()
	if(world.maxx > canvas.Width())
		stack_trace("Minimap for z=[z_level] : world.maxx ([world.maxx]) must be <= [canvas.Width()]")
	if(world.maxy > canvas.Height())
		stack_trace("Minimap for z=[z_level] : world.maxy ([world.maxy]) must be <= [canvas.Height()]")

	for(var/x = 1 to world.maxx)
		for(var/y = 1 to world.maxy)
			var/turf/tile = locate(x, y, z_level)
			var/offset_x = HOLOMAP_CENTER_X + x
			var/offset_y = HOLOMAP_CENTER_Y + y

			if(!tile)
				continue

			if(tile.loc && tile.loc:holomap_color) // No var casting cause that costs precious time.
				area_canvas.DrawBox(tile.loc:holomap_color, HOLOMAP_CENTER_X + x, HOLOMAP_CENTER_Y + y)
				position_to_name["[offset_x]:[offset_y]"] = tile.loc:holomap_color == HOLOMAP_AREACOLOR_MAINTENANCE ? "Maintenance" : tile.loc.name

			if(tile.loc:holomapAlwaysDraw())
				if(HAS_Z_TRANSITION(tile))
					z_transition_positions += "[offset_x]:[offset_y]"

				if(IS_ROCK(tile))
					canvas.DrawBox(HOLOMAP_ROCK, offset_x, offset_y)
					continue

				if(IS_OBSTACLE(tile))
					canvas.DrawBox(HOLOMAP_OBSTACLE, offset_x, offset_y)
					continue

				if(IS_SOFT_OBSTACLE(tile))
					canvas.DrawBox(HOLOMAP_SOFT_OBSTACLE, offset_x, offset_y)
					continue

				if(IS_PATH(tile))
					canvas.DrawBox(HOLOMAP_PATH, offset_x, offset_y)

		// Check sleeping after each row to avoid *completely* destroying the server
		CHECK_TICK

	holomaps["[z_level]"] = canvas
	holomap_z_transitions["[z_level]"] = z_transition_positions
	holomap_position_to_name["[z_level]"] = position_to_name
	return setup_station_map(area_canvas, z_level)


/// Draws the station area overlay. Required to be run if you want the map to be viewable on a station map viewer.
/// Takes the area canvas, and the Z-level value.
/datum/controller/subsystem/holomaps/proc/setup_station_map(icon/canvas, z_level)
	// Save this nice area-colored canvas in case we want to layer it or something I guess
	extra_holomaps["[HOLOMAP_EXTRA_STATIONMAPAREAS]_[z_level]"] = canvas

	var/icon/map_base = icon(holomaps["[z_level]"])
	map_base.Blend(HOLOMAP_HOLOFIER, ICON_MULTIPLY)

	// Generate the full sized map by blending the base and areas onto the backdrop
	var/icon/big_map = icon(HOLOMAP_ICON, "stationmap")
	big_map.Blend(map_base, ICON_OVERLAY)
	big_map.Blend(canvas, ICON_OVERLAY)
	extra_holomaps["[HOLOMAP_EXTRA_STATIONMAP]_[z_level]"] = big_map

	// Generate the "small" map (I presume for putting on wall map things?)
	var/icon/small_map = icon(HOLOMAP_ICON, "blank")
	small_map.Blend(map_base, ICON_OVERLAY)
	small_map.Blend(canvas, ICON_OVERLAY)
	small_map.Scale(40, 40)
	small_map.Crop(5, 5, 36, 36)

	// And rotate it in every direction of course!
	var/icon/actual_small_map = icon(small_map)
	actual_small_map.Insert(new_icon = small_map, dir = SOUTH)
	actual_small_map.Insert(new_icon = turn(small_map, 90), dir = WEST)
	actual_small_map.Insert(new_icon = turn(small_map, 180), dir = NORTH)
	actual_small_map.Insert(new_icon = turn(small_map, 270), dir = EAST)
	extra_holomaps["[HOLOMAP_EXTRA_STATIONMAPSMALL]_[z_level]"] = actual_small_map
	return TRUE

#undef IS_ROCK
#undef IS_OBSTACLE
#undef IS_SOFT_OBSTACLE
#undef IS_PATH
