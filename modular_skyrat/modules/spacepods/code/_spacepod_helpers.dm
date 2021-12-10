#define isspacepod(A) (istype(A, /obj/spacepod))

/// Sends a signal when the client detects mouse movement
/client/MouseMove(atom/object, atom/location, control, params)
	. = ..()
	if(mob)
		SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_MOUSE_MOVE, object, location, control, params)

/client/Click(atom/object, atom/location, control, params)
	. = ..()
	if(mob)
		SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_MOUSE_DOWN, object, location, control, params)
