/atom
	//Graphical Vars
	//Baseline values. These are used as the zero point for transforms and offsets
	var/default_pixel_x = 0
	var/default_pixel_y = 0
	var/default_rotation = 0
	var/default_alpha = 255
	var/default_scale = 1

/atom/proc/marker_act(obj/structure/marker/B)
	var/marker_act_result = SEND_SIGNAL(src, COMSIG_ATOM_MARKER_ACT, B)
	if (marker_act_result & COMPONENT_CANCEL_BLOB_ACT)
		return FALSE
	return TRUE

