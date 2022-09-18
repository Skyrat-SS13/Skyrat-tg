/*
*	INVENTORY SYSTEM EXTENTION
*/

// Just by analogy with the TG code. No ideas for what this is.
/mob/proc/update_inv_vagina()
	return
/mob/proc/update_inv_anus()
	return
/mob/proc/update_inv_nipples()
	return
/mob/proc/update_inv_penis()
	return
/// Helper proc for calling all the lewd slot update_inv_ procs.
/mob/proc/update_inv_lewd()
	update_inv_vagina()
	update_inv_anus()
	update_inv_nipples()
	update_inv_penis()


/// Proc for condoms. Need to prevent cum appearing on the floor.
/mob/proc/is_wearing_condom()
	return FALSE
