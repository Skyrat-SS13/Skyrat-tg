/// Creates a mutable appearance glued to the EMISSIVE_PLAN, using the values from a mutable appearance
/proc/emissive_appearance_copy(mutable_appearance/to_use, appearance_flags = (RESET_COLOR|KEEP_APART))
	var/mutable_appearance/appearance = mutable_appearance(to_use.icon, to_use.icon_state, to_use.layer, EMISSIVE_PLANE, to_use.alpha, to_use.appearance_flags | appearance_flags)
	appearance.color = GLOB.emissive_color
	appearance.pixel_x = to_use.pixel_x
	appearance.pixel_y = to_use.pixel_y
	return appearance
