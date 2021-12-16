/// Produces a mutable appearance glued to the [EMISSIVE_PLANE] dyed to be the [EMISSIVE_COLOR].
/proc/emissive_appearance(icon, icon_state = "", layer = FLOAT_LAYER, alpha = 255, appearance_flags = NONE)
	var/mutable_appearance/appearance = mutable_appearance(icon, icon_state, layer, EMISSIVE_PLANE, alpha, appearance_flags | EMISSIVE_APPEARANCE_FLAGS)
	appearance.color = GLOB.emissive_color
	return appearance

/// Produces a mutable appearance glued to the [EMISSIVE_PLANE] dyed to be the [EM_BLOCK_COLOR].
/proc/emissive_blocker(icon, icon_state = "", layer = FLOAT_LAYER, alpha = 255, appearance_flags = NONE)
	var/mutable_appearance/appearance = mutable_appearance(icon, icon_state, layer, EMISSIVE_PLANE, alpha, appearance_flags | EMISSIVE_APPEARANCE_FLAGS)
	appearance.color = GLOB.em_block_color
	return appearance

//SKYRAT EDIT ADDITION
/// Creates a mutable appearance glued to the EMISSIVE_PLAN, using the values from a mutable appearance
/proc/emissive_appearance_copy(mutable_appearance/to_use, appearance_flags = (RESET_COLOR|KEEP_APART))
	var/mutable_appearance/appearance = mutable_appearance(to_use.icon, to_use.icon_state, to_use.layer, EMISSIVE_PLANE, to_use.alpha, to_use.appearance_flags | appearance_flags)
	appearance.color = GLOB.emissive_color
	appearance.pixel_x = to_use.pixel_x
	appearance.pixel_y = to_use.pixel_y
	return appearance
