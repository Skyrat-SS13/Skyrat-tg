/*
	This click handler is for an emplaced gun which turns to face the mouse cursor
	it can be full auto or not, as desired
*/
/datum/click_handler/gun/tracked
	has_mousemove = TRUE

	var/automatic = TRUE

/datum/click_handler/gun/tracked/MouseDown(object,location,control,params)
	var/list/modifiers = params2list(params)
	if(modifiers["left"])
		left_mousedown = TRUE
		update_clickparams(params)
		object = resolve_world_target(object, params)
		if (object)
			set_target(object)
			if (automatic)
				start_firing()
			else
				fire()
			return FALSE
	return TRUE


/datum/click_handler/gun/tracked/MouseUp(object,location,control,params)
	var/list/modifiers = params2list(params)
	if(modifiers["left"])
		stop_firing()
	return TRUE

/datum/click_handler/gun/tracked/MouseMove(object,location,control,params)
	object = resolve_world_target(object, params)
	if (object)
		set_target(object)
	return TRUE


/datum/click_handler/gun/tracked/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)
	update_clickparams(params)
	over_object = resolve_world_target(over_object, params)
	if (over_object)
		set_target(over_object)
		return FALSE
	return TRUE