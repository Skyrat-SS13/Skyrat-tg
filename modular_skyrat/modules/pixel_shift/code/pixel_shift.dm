/mob
	///Whether the mob is pixel shifted or not
	var/is_shifted
	var/shifting //If we are in the shifting setting.

	var/passthroughable = 0

/datum/keybinding/mob/pixel_shift
	hotkey_keys = list("B")
	name = "pixel_shift"
	full_name = "Pixel Shift"
	description = "Shift your characters offset."
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELSHIFT

/datum/keybinding/mob/pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	M.shifting = TRUE
	return TRUE

/datum/keybinding/mob/pixel_shift/up(client/user)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	M.shifting = FALSE
	return TRUE

/mob/proc/unpixel_shift()
	return

/mob/living/unpixel_shift()
	. = ..()
	passthroughable = 0
	if(is_shifted)
		is_shifted = FALSE
		pixel_x = body_position_pixel_x_offset + base_pixel_x
		pixel_y = body_position_pixel_y_offset + base_pixel_y

/mob/proc/pixel_shift(direction)
	return

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state)
	pull_target.unpixel_shift()
	return ..()

/mob/living/reset_pull_offsets(mob/living/pull_target, override)
	pull_target.unpixel_shift()
	return ..()

/mob/living/pixel_shift(direction)
	passthroughable = 0
	switch(direction)
		if(NORTH)
			if(pixel_y <= 16 + base_pixel_y)
				pixel_y++
				is_shifted = TRUE
		if(EAST)
			if(pixel_x <= 16 + base_pixel_x)
				pixel_x++
				is_shifted = TRUE
		if(SOUTH)
			if(pixel_y >= -16 + base_pixel_y)
				pixel_y--
				is_shifted = TRUE
		if(WEST)
			if(pixel_x >= -16 + base_pixel_x)
				pixel_x--
				is_shifted = TRUE

	// Yes, I know this sets it to true for everything if more than one is matched.
	// Movement doesn't check diagonals, and instead just checks EAST or WEST, depending on where you are for those.
	if(pixel_y > 8)
		passthroughable |= EAST | SOUTH | WEST
	if(pixel_x > 8)
		passthroughable |= NORTH | SOUTH | WEST
	if(pixel_y < -8)
		passthroughable |= NORTH | EAST | WEST
	if(pixel_x < -8)
		passthroughable |= NORTH | EAST | SOUTH

/mob/living/CanAllowThrough(atom/movable/mover, border_dir)
	if(passthroughable)
		return passthroughable & border_dir
	return ..()
