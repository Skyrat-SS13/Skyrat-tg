/mob/living
	var/body_size_multiplier = BODY_SIZE_NORMAL
	var/body_size_pixel_y_offset = 0


/mob/living/proc/set_size(new_size)
	new_size = clamp(new_size, CONFIG_GET(number/body_size_max), CONFIG_GET(number/body_size_min))
	if (new_size != body_size_multiplier)
		resize = new_size / body_size_multiplier
		body_size_multiplier = new_size

	var/icon/I = icon(icon, icon_state, dir)
	var/icon_height = I.Height()

	if(icon_height)
		// We only want to offset macros so that their sprites don't overflow on the bottom of the tile,
		// micros being in the middle of the tile are fine and would only look weird if the icon_height is really large.
		var/new_offset = clamp(((body_size_multiplier-1)*icon_height)/2, 0, INFINITY)
		set_base_pixel_y(base_pixel_y + new_offset - body_size_pixel_y_offset)
		body_size_pixel_y_offset = new_offset

	update_transform()
