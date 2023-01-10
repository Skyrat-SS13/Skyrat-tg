//
// Holomap generation.
// Based on /vg/station but trimmed down (without antag stuff) and massively optimized (you should have seen it before!) ~Leshana
//

// Define what criteria makes a turf a path or not

// Turfs that will be colored as HOLOMAP_ROCK
#define IS_ROCK(tile) (istype(tile, /turf/closed/mineral) && tile.density)

// Turfs that will be colored as HOLOMAP_OBSTACLE
#define IS_OBSTACLE(tile) (istype(tile, /turf/closed) ||  (locate(/obj/structure/window) in tile))

// Turfs that will be colored as HOLOMAP_SOFT_OBSTACLE
#define IS_SOFT_OBSTACLE(tile) ((locate(/obj/structure/grille) in tile) || (locate(/obj/structure/lattice) in tile))

// Turfs that will be colored as HOLOMAP_PATH
#define IS_PATH(tile) istype(tile, /turf/open/floor)

/// Generates all the holo minimaps, initializing it all nicely, probably.
/datum/controller/subsystem/holomaps/proc/generateHoloMinimaps()
	//var/start_time = world.timeofday

	// Starting over if we're running midround (it runs real fast, so that's possible)
	holoMiniMaps.Cut()
	extraMiniMaps.Cut()

	// Build the base map for each z level
	// for (var/z = 1 to world.maxz)
	// 	holoMiniMaps |= z
	// 	holoMiniMaps[z] = generateHoloMinimap(z)

	// Generate the area overlays, small maps, etc for the station levels.

	for (var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
		generateHoloMinimap(z)
		generateStationMinimap(z)

// Generates the "base" holomap for one z-level, showing only the physical structure of walls and paths.
/datum/controller/subsystem/holomaps/proc/generateHoloMinimap(var/zLevel = 1)
	// Sanity checks - Better to generate a helpful error message now than have DrawBox() runtime
	var/icon/canvas = icon(HOLOMAP_ICON, "blank")
	if(world.maxx > canvas.Width())
		stack_trace("Minimap for z=[zLevel] : world.maxx ([world.maxx]) must be <= [canvas.Width()]")
	if(world.maxy > canvas.Height())
		stack_trace("Minimap for z=[zLevel] : world.maxy ([world.maxy]) must be <= [canvas.Height()]")

	for(var/x = 1 to world.maxx)
		for(var/y = 1 to world.maxy)
			var/turf/tile = locate(x, y, zLevel)
			if(tile && tile.loc:holomapAlwaysDraw())
				var/offset_x = HOLOMAP_CENTER_X + x
				var/offset_y = HOLOMAP_CENTER_Y + y

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

	holoMiniMaps["[zLevel]"] = canvas

// Okay, what does this one do?
// This seems to do the drawing thing, but draws only the areas, having nothing to do with the tiles.
// Leshana: I'm guessing this map will get overlayed on top of the base map at runtime? We'll see.
// Wait, seems we actually blend the area map on top of it right now! Huh.
/datum/controller/subsystem/holomaps/proc/generateStationMinimap(zLevel)
	// Sanity checks - Better to generate a helpful error message now than have DrawBox() runtime
	var/icon/canvas = icon(HOLOMAP_ICON, "blank")
	if(world.maxx > canvas.Width())
		stack_trace("Minimap for z=[zLevel] : world.maxx ([world.maxx]) must be <= [canvas.Width()]")
	if(world.maxy > canvas.Height())
		stack_trace("Minimap for z=[zLevel] : world.maxy ([world.maxy]) must be <= [canvas.Height()]")

	for(var/x = 1 to world.maxx)
		for(var/y = 1 to world.maxy)
			var/turf/tile = locate(x, y, zLevel)
			if(tile && tile.loc)
				var/area/areaToPaint = tile.loc
				if(areaToPaint.holomap_color)
					canvas.DrawBox(areaToPaint.holomap_color, HOLOMAP_CENTER_X + x, HOLOMAP_CENTER_Y + y)

	// Save this nice area-colored canvas in case we want to layer it or something I guess
	extraMiniMaps["[HOLOMAP_EXTRA_STATIONMAPAREAS]_[zLevel]"] = canvas

	var/icon/map_base = icon(holoMiniMaps["[zLevel]"])
	map_base.Blend(HOLOMAP_HOLOFIER, ICON_MULTIPLY)

	// Generate the full sized map by blending the base and areas onto the backdrop
	var/icon/big_map = icon(HOLOMAP_ICON, "stationmap")
	big_map.Blend(map_base, ICON_OVERLAY)
	big_map.Blend(canvas, ICON_OVERLAY)
	extraMiniMaps["[HOLOMAP_EXTRA_STATIONMAP]_[zLevel]"] = big_map

	// Generate the "small" map (I presume for putting on wall map things?)
	var/icon/small_map = icon(HOLOMAP_ICON, "blank")
	small_map.Blend(map_base, ICON_OVERLAY)
	small_map.Blend(canvas, ICON_OVERLAY)
	small_map.Scale(32, 32)

	// And rotate it in every direction of course!
	var/icon/actual_small_map = icon(small_map)
	actual_small_map.Insert(new_icon = small_map, dir = SOUTH)
	actual_small_map.Insert(new_icon = turn(small_map, 90), dir = WEST)
	actual_small_map.Insert(new_icon = turn(small_map, 180), dir = NORTH)
	actual_small_map.Insert(new_icon = turn(small_map, 270), dir = EAST)
	extraMiniMaps["[HOLOMAP_EXTRA_STATIONMAPSMALL]_[zLevel]"] = actual_small_map

#undef IS_ROCK
#undef IS_OBSTACLE
#undef IS_SOFT_OBSTACLE
#undef IS_PATH
