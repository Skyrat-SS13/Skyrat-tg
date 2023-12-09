/obj/item/gun/ballistic/install_suppressor(obj/item/suppressor/added_suppressor)
	suppressed = added_suppressor
	update_appearance()

/obj/item/gun/ballistic/clear_suppressor()
	if(!can_unsuppress)
		return
	return ..()
