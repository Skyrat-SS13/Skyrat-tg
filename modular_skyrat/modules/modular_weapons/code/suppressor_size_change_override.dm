// Prevents gun sizes from changing due to suppressors
/obj/item/gun/ballistic/install_suppressor(obj/item/suppressor/added_suppressor)
	. = ..()
	// Prevents the w_class of the weapon from actually being increased
	w_class -= added_suppressor.w_class

// Prevents gun sizes from changing due to suppressors
/obj/item/gun/ballistic/clear_suppressor()
	if(!can_unsuppress)
		return
	// Adds to the w_class of the item before its promptly removed, resulting in a net zero w_class change
	if(isitem(suppressed))
		var/obj/item/item_suppressor = suppressed
		w_class += item_suppressor.w_class
	return ..()
