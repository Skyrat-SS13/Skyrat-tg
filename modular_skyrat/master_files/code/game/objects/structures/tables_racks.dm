// Lets cyborgs move dragged objects onto tables
/obj/structure/table/attack_robot(mob/user, list/modifiers)
	if(!in_range(src, user))
		return
	return attack_hand(user, modifiers)
