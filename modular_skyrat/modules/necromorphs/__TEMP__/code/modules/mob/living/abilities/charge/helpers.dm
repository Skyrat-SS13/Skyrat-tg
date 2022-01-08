/*
	Called when a mob gets launched
	This cancels any ongoing abilities which make the mob move. Including:
		Charge/Lunge
		Leap
		High Leap
*/
/atom/movable/proc/cancel_movement_abilities()
	var/datum/extension/charge/C = get_extension_of_type(src, /datum/extension/charge)
	if (C)
		C.stop_peter_out()