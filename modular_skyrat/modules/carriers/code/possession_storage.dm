/// This item holds all of the items that someone has when anything is removed inside of a carrier.
/obj/item/item_box
	/// Do we need a ckey to open the box?
	var/ckey_locked = TRUE
	// We have this ckey bound in the case that someone has their body destroyed through vore.
	/// What ckey is allowed to open this box?
	var/allowed_ckey = ""

/obj/item/item_box/attack_self(mob/user, modifiers)
	if(!istype(user))
		return

	if(ckey_locked && (user.ckey != allowed_ckey))
		to_chat(user, span_warning("You are not the right person to open this."))
		return

	to_chat(user, span_notice("You open the box, releasing the contents inside."))
	for(var/obj/item/held_item as anything in contents)
		held_item.forceMove(get_turf(user))

	qdel(src)
	return
