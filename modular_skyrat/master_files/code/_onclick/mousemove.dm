/client/MouseMove(object, location, control, params)
	SEND_SIGNAL(src, COMSIG_CLIENT_MOUSEMOVE, object, location, control, params)
	return ..()
