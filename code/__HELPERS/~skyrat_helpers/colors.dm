/proc/get_alpha_padded_color(color)
	var/add = color[1] == "#" ? 1 : 0
	if (length_char(color) == 3+add)
		return "[color]0"
	else if (length_char(color) == 6+add)
		return "[color]00"
	return null
