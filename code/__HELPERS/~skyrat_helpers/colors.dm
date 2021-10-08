/proc/get_alpha_padded_color(color)
	if (length_char(color) == 3)
		return "[color]0"
	else if (length_char(color) == 6)
		return "[color]00"
	return null
