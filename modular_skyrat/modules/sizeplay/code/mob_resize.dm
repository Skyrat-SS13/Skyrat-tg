/datum/movespeed_modifier/bodysize
	variable = TRUE
	flags = IGNORE_NOSLOW

/mob/living
	var/body_size_multiplier = BODY_SIZE_NORMAL
	var/body_size_pixel_y_offset = 0

/mob/living/proc/set_size(new_size)
	new_size = clamp(new_size, CONFIG_GET(number/body_size_max), CONFIG_GET(number/body_size_min))
	if (new_size != body_size_multiplier)
		resize = new_size / body_size_multiplier
		body_size_multiplier = new_size
		if(CONFIG_GET(number/body_size_slowdown_start) > 0)
			//Basically if you take slowdown_start as SS, and slowdown_factor as SF, the thing below is (SS-body_size)/SS * SF
			//And the result's lower boundary is capped to 0, so that bigger sizes don't provide a movespeed buff
			var/slowdown = max(0, (CONFIG_GET(number/body_size_slowdown_start) - body_size_multiplier)/CONFIG_GET(number/body_size_slowdown_start) * CONFIG_GET(number/body_size_slowdown_factor))
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bodysize, multiplicative_slowdown = slowdown)

	var/icon/I = icon(icon)
	var/icon_height = I.Height()

	if(icon_height)
		// We only want to offset macros so that their sprites don't overflow on the bottom of the tile,
		// micros being in the middle of the tile are fine and would only look weird if the icon_height is really large.
		var/new_offset = max(((body_size_multiplier-1)*icon_height)/2, 0)
		set_base_pixel_y(base_pixel_y + new_offset - body_size_pixel_y_offset)
		body_size_pixel_y_offset = new_offset

	update_transform()
