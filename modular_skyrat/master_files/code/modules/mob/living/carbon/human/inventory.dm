/mob/living/carbon/human/doUnEquip(obj/item/I, force, newloc, no_move, invdrop, silent)
	. = ..()
	if(!. || !I)
		return

	SEND_SIGNAL(src, COMSIG_HUMAN_UNEQUIPPED_ITEM, I, force, newloc, no_move, invdrop, silent)
