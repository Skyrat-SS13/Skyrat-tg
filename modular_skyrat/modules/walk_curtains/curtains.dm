/obj/structure/curtain
	/// whether curtains will toggle their density when toggled
	var/toggle_density = FALSE

/obj/structure/curtain/toggle()
	open = !open
	if(open)
		layer = SIGN_LAYER
		plane = GAME_PLANE
		if(toggle_density)
			set_density(FALSE)
		set_opacity(FALSE)
	else
		layer = WALL_OBJ_LAYER
		plane = GAME_PLANE_UPPER
		if(toggle_density)
			set_density(TRUE)
		if(opaque_closed)
			set_opacity(TRUE)

	update_appearance()
