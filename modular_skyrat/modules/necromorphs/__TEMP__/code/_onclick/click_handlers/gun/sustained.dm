/****************************
	Sustained Fire
*****************************/
/datum/click_handler/gun/sustained
//Useful for ripper and kinesis. Intended for things
//Works similar to full auto, but:
	//Constant firing events are not generated
	//Firing events are generated on every mousedrag
	//Firing events are generated on every mousemove
	var/atom/target = null
	var/firing = FALSE



	has_mousemove = FALSE

//Subtype which has mousemove
/datum/click_handler/gun/sustained/move
	has_mousemove = TRUE


/datum/click_handler/gun/sustained/MouseDown(object,location,control,params)
	var/list/modifiers = params2list(params)
	if(modifiers["left"])
		left_mousedown = TRUE
		update_clickparams(params)
		object = resolve_world_target(object, params)
		if (object)
			set_target(object)
			start_firing()
			return FALSE
	return TRUE

/datum/click_handler/gun/sustained/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)
	update_clickparams(params)
	over_object = resolve_world_target(over_object, params)
	if (over_object && is_firing())
		set_target(over_object)
		return FALSE
	return TRUE

/datum/click_handler/gun/sustained/MouseMove(object,location,control,params)
	update_clickparams(params)
	object = resolve_world_target(object, params)
	if (object && is_firing())
		set_target(location)
		return FALSE
	return TRUE



/datum/click_handler/gun/sustained/MouseUp(object,location,control,params)
	var/list/modifiers = params2list(params)
	if(modifiers["left"])
		left_mousedown = FALSE
		stop_firing()
	return TRUE

/datum/click_handler/gun/sustained/Destroy()
	stop_firing()//Without this it keeps firing in an infinite loop when deleted
	.=..()


