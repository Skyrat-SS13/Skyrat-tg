#define isspacepod(A) (istype(A, /obj/spacepod))
#define isspacepodequipment(A) (istype(A, /obj/item/spacepod_equipment))

/// Sends a signal when the client detects mouse movement
/client/MouseMove(atom/object, atom/location, control, params)
	. = ..()
	if(mob)
		SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_MOUSE_MOVE, object, location, control, params)

/**
 * BYOND returns a floating point error on certain trigonometric calculations, so we need to correct this.
 *
 * We use corrective value epsilon as a threshold.
 */
/proc/corrective_cos_calculation(angle)
	var/cosigne_value = cos(angle)
	return abs(cosigne_value) < TRIGONOMETRIC_EPSILON_THRESHOLD ? 0 : cosigne_value

/proc/corrective_sin_calculation(angle)
	var/sine_value = sin(angle)
	return abs(sine_value) < TRIGONOMETRIC_EPSILON_THRESHOLD ? 0 : sine_value
