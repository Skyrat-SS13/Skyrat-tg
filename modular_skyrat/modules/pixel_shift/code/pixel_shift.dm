/mob
	///Whether the mob is pixel shifted or not
	var/is_shifted
	var/shifting //If we are in the shifting setting.
	///If true, will make the mob passthroughable.
	var/is_out_of_the_way = FALSE

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
	if(is_shifted)
		is_shifted = FALSE
		pixel_x = body_position_pixel_x_offset + base_pixel_x
		pixel_y = body_position_pixel_y_offset + base_pixel_y
	if(is_out_of_the_way)
		density = TRUE

/mob/proc/pixel_shift(direction)
	return

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state)
	unpixel_shift()
	return ..()

/mob/living/reset_pull_offsets(mob/living/pull_target, override)
	unpixel_shift()
	return ..()

/mob/living/pixel_shift(direction)
	var/was_out_of_the_way = is_out_of_the_way
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
	if(abs(pixel_x > 8))
		is_out_of_the_way = TRUE
	else if(abs(pixel_y > 8))
		is_out_of_the_way = TRUE
	else
		is_out_of_the_way = FALSE


	density = is_out_of_the_way == FALSE // Inverted, cause we want it set to 0 if we *are* out of the way!
