	//Graphical Vars
	//Baseline values. These are used as the zero point for transforms and offsets
	var/default_pixel_x = 0
	var/default_pixel_y = 0
	var/default_rotation = 0
	var/default_alpha = 255
	var/default_scale = 1

	/*
		OPTIMISATION
			If set false, this atom will never be checked to recieve collisions. Everything will move through it as if it isnt there and canpass will never be called.

			It can still collide with others when itself is the one moving

			This flag doesn't necessarily mean it will block any specific thing at any specific time, CanPass still handles that.
			Set this true for anything that could ever collide at any time in its normal life
	*/
	var/can_block_movement	=	TRUE
