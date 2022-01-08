/atom/proc/marker_act(obj/structure/marker/B)
	var/marker_act_result = SEND_SIGNAL(src, COMSIG_ATOM_MARKER_ACT, B)
	if (marker_act_result & COMPONENT_CANCEL_BLOB_ACT)
		return FALSE
	return TRUE
