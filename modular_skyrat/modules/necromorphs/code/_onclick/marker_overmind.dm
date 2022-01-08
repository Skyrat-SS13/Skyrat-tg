// Marker Overmind Controls


/mob/camera/marker/ClickOn(atom/A, params) //Expand blob
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		MiddleClickOn(A, params)
		return
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		AltClickOn(A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		CtrlClickOn(A)
		return
	var/turf/T = get_turf(A)
	if(T)
		expand_marker(T)

/mob/camera/marker/MiddleClickOn(atom/A) //Rally spores


/mob/camera/marker/CtrlClickOn(atom/A) //Create a shield


/mob/camera/marker/AltClickOn(atom/A) //Remove a blob
	var/turf/T = get_turf(A)
	if(T)
		remove_marker(T)
