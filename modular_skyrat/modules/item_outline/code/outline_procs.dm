/atom/movable/screen/inventory/proc/add_stored_outline()
	if(hud?.mymob && slot_id)
		var/obj/item/inv_item = hud.mymob.get_item_by_slot(slot_id)
		if(inv_item)
			if(hud?.mymob.incapacitated())
				inv_item.apply_outline(COLOR_RED_GRAY)
			else
				inv_item.apply_outline()

/atom/movable/screen/inventory/proc/remove_stored_outline()
	if(hud?.mymob && slot_id)
		var/obj/item/inv_item = hud.mymob.get_item_by_slot(slot_id)
		if(inv_item)
			inv_item.remove_outline()

/obj/item/proc/apply_outline(colour = null)
	if(!Adjacent(usr) || QDELETED(src))
		return
	if(usr.client)
		if(!usr.client.prefs.outline_enabled)
			return
	if(!colour)
		if(usr.client)
			colour = usr.client.prefs.outline_color
			if(!colour)
				colour = COLOR_BLUE_GRAY
		else
			colour = COLOR_BLUE_GRAY
	if(outline_filter)
		filters -= outline_filter
	outline_filter = filter(type="outline", size=1, color=colour)
	filters += outline_filter

/obj/item/proc/remove_outline()
	if(outline_filter)
		filters -= outline_filter
		outline_filter = null
