/mob
	///Whether the mob is pixel shifted or not
	var/is_shifted

/datum/keybinding/mob/shift_north
	hotkey_keys = list("CtrlShiftW", "CtrlShiftNorth")
	name = "pixel_shift_north"
	full_name = "Pixel Shift North"
	description = ""
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELSHIFT_NORTH

/datum/keybinding/mob/shift_north/down(client/user)
	var/mob/M = user.mob
	M.northshift()
	return TRUE

/datum/keybinding/mob/shift_east
	hotkey_keys = list("CtrlShiftD", "CtrlShiftEast")
	name = "pixel_shift_east"
	full_name = "Pixel Shift East"
	description = ""
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELSHIFT_EAST

/datum/keybinding/mob/shift_east/down(client/user)
	var/mob/M = user.mob
	M.eastshift()
	return TRUE

/datum/keybinding/mob/shift_south
	hotkey_keys = list("CtrlShiftS", "CtrlShiftSouth")
	name = "pixel_shift_south"
	full_name = "Pixel Shift South"
	description = ""
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELSHIFT_SOUTH

/datum/keybinding/mob/shift_south/down(client/user)
	var/mob/M = user.mob
	M.southshift()
	return TRUE

/datum/keybinding/mob/shift_west
	hotkey_keys = list("CtrlShiftA", "CtrlShiftWest")
	name = "pixel_shift_west"
	full_name = "Pixel Shift West"
	description = ""
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELSHIFT_WEST

/datum/keybinding/mob/shift_west/down(client/user)
	var/mob/M = user.mob
	M.westshift()
	return TRUE

/mob/proc/eastshift()
	if(!canface())
		return FALSE
	if(pixel_x <= 16)
		pixel_x++
		is_shifted = TRUE

/mob/proc/westshift()
	if(!canface())
		return FALSE
	if(pixel_x >= -16)
		pixel_x--
		is_shifted = TRUE

/mob/proc/northshift()
	if(!canface())
		return FALSE
	if(pixel_y <= 16)
		pixel_y++
		is_shifted = TRUE

/mob/proc/southshift()
	if(!canface())
		return FALSE
	if(pixel_y >= -16)
		pixel_y--
		is_shifted = TRUE
