
/datum/component/storage
	screen_start_x = 3 //These two are where the storage starts being rendered, screen_loc wise.
	screen_start_y = 1

/datum/action_group/ButtonNumberToScreenCoords(number, landing = FALSE) // THIS IS THE TG PROC AS OF APRIL 21st 2022. DO NOT . = ..()
	var/row = round(number / column_max)
	row -= row_offset // If you're less then 0, you don't get to render, this lets us "scroll" rows ya feel?
	if(row < 0)
		return null

	// Could use >= here, but I think it's worth noting that the two start at different places, since row is based on number here
	if(row > max_rows - 1)
		if(!landing) // If you're not a landing, go away please. thx
			return null
		// We always want to render landings, even if their action button can't be displayed.
		// So we set a row equal to the max amount of rows + 1. Willing to overrun that max slightly to properly display the landing spot
		row = max_rows // Remembering that max_rows indexes at 1, and row indexes at 0

		// We're going to need to set our column to match the first item in the last row, so let's set number properly now
		number = row * column_max

	var/visual_row = row + north_offset
	var/coord_row = visual_row ? "-[visual_row]" : "+0"

	var/visual_column = number % column_max
	var/coord_col = "+[visual_column]"
	var/coord_col_offset = 4 + 2 * (visual_column + 1)
	return "LEFT[coord_col]:[coord_col_offset],TOP[coord_row]:-[pixel_north_offset]" // The actual differing part.

//code/datums/components/storage/storage.dm

/datum/component/storage/standard_orient_objs(rows, cols, list/obj/item/numerical_display_contents) // Thanks Kevinz000 - OG Author of this proc, modified slightly in this override
	boxes.screen_loc = "LEFT+[screen_start_x]:[screen_pixel_x],BOTTOM+[screen_start_y]:[screen_pixel_y] to LEFT+[screen_start_x+cols-1]:[screen_pixel_x],BOTTOM+[screen_start_y+rows-1]:[screen_pixel_y]"
	var/cx = screen_start_x
	var/cy = screen_start_y
	if(islist(numerical_display_contents))
		for(var/type in numerical_display_contents)
			var/datum/numbered_display/ND = numerical_display_contents[type]
			ND.sample_object.mouse_opacity = MOUSE_OPACITY_OPAQUE
			ND.sample_object.screen_loc = "LEFT+[cx]:[screen_pixel_x],BOTTOM+[cy]:[screen_pixel_y]"
			ND.sample_object.maptext = MAPTEXT("<font color='white'>[(ND.number > 1)? "[ND.number]" : ""]</font>")
			ND.sample_object.plane = ABOVE_HUD_PLANE
			cx++
			if(cx - screen_start_x >= cols)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break
	else
		var/atom/real_location = real_location()
		for(var/obj/O in real_location)
			if(QDELETED(O))
				continue
			O.mouse_opacity = MOUSE_OPACITY_OPAQUE //This is here so storage items that spawn with contents correctly have the "click around item to equip"
			O.screen_loc = "LEFT+[cx]:[screen_pixel_x],BOTTOM+[cy]:[screen_pixel_y]"
			O.maptext = ""
			O.plane = ABOVE_HUD_PLANE
			cx++
			if(cx - screen_start_x >= cols)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break
	closer.screen_loc = "LEFT+[screen_start_x + cols]:[screen_pixel_x],BOTTOM+[screen_start_y]:[screen_pixel_y]"

/datum/component/storage/orient_objs(tx, ty, mx, my)
	var/atom/real_location = real_location()
	var/cx = tx
	var/cy = ty
	boxes.screen_loc = "LEFT+[tx]:,BOTTOM+[ty] to LEFT+[mx],BOTTOM+[my]"
	for(var/obj/O in real_location)
		if(QDELETED(O))
			continue
		O.screen_loc = "LEFT+[cx],BOTTOM+[cy]"
		O.plane = ABOVE_HUD_PLANE
		cx++
		if(cx > mx)
			cx = tx
			cy--
	closer.screen_loc = "LEFT+[mx+1],BOTTOM+[my]"

/datum/view_data/apply(string)
	if((chief.prefs.read_preference(/datum/preference/toggle/widescreen)))
		return
	. = ..()

/datum/view_data/resetFormat()
	if((chief.prefs.read_preference(/datum/preference/toggle/widescreen)))
		return
	. = ..()

/datum/view_data/setZoomMode()
	if((chief.prefs.read_preference(/datum/preference/toggle/widescreen)))
		return
	. = ..()

// code/modules/buildmode/buttons.dm

/atom/movable/screen/buildmode/mode
	screen_loc = "TOP,LEFT"

/atom/movable/screen/buildmode/help
	screen_loc = "TOP,LEFT+1"

/atom/movable/screen/buildmode/bdir
	screen_loc = "TOP,LEFT+2"

/atom/movable/screen/buildmode/quit

	screen_loc = "TOP,LEFT+3"

//code/_onclick/hud/screen_objects.dm overrides
/atom/movable/screen/storage
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

/atom/movable/screen/splash
	screen_loc = "CENTER-7,CENTER-7" // Why here? The old is 1,1 - which makes it at the bottom left corner. Jank! This will avoid alignment issues altogether.

// code/_onclick/hud/fullscreen.dm overrides.

/atom/movable/screen/fullscreen/flash
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

/atom/movable/screen/fullscreen/flash/black
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

/atom/movable/screen/fullscreen/flash/static
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

/atom/movable/screen/fullscreen/high
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

/atom/movable/screen/fullscreen/color_vision
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

/atom/movable/screen/fullscreen/bluespace_sparkle
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

/atom/movable/screen/fullscreen/cinematic_backdrop
	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"


