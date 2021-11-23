/*
MICROFUSION CELL SYSTEM

Microfusion cells are small battery units that house controlled nuclear fusion within, and that fusion is converted into useable energy.

They cannot be charged as standard, and require upgrades to do so.

These are basically advanced cells.
*/

/obj/item/stock_parts/cell/microfusion //Just a standard cell.
	name = "microfusion cell"
	desc = "A compact microfusion cell."
	icon = 'modular_skyrat/modules/microfusion/icons/microfusion_cells.dmi'
	charge_overlay_icon = 'modular_skyrat/modules/microfusion/icons/microfusion_cells.dmi'
	icon_state = "microfusion"
	w_class = WEIGHT_CLASS_NORMAL
	maxcharge = 1200 //12 shots
	chargerate = 0 //Standard microfusion cells can't be recharged, they're single use.

	var/list/attached_upgrades = list()

/obj/item/stock_parts/cell
	/// Is this cell stabalised? (used in microfusion guns)
	var/stabalised = FALSE

/obj/item/stock_parts/cell/microfusion/Destroy()
	if(attached_upgrades.len)
		for(var/obj/item/iterating_item in attached_upgrades)
			iterating_item.forceMove(get_turf(src))
		attached_upgrades = null
	return ..()

/obj/item/stock_parts/cell/microfusion/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/microfusion_cell_attachment))
		attatch_upgrade(attacking_item, user)
		return
	return ..()

/obj/item/stock_parts/cell/microfusion/update_overlays()
	. = ..()
	for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
		. += microfusion_cell_attachment.attachment_overlay_icon_state

/obj/item/stock_parts/cell/microfusion/screwdriver_act(mob/living/user, obj/item/tool)
	remove_upgrades()
	playsound(src, 'sound/items/screwdriver.ogg', 70, TRUE)
	to_chat(user, span_notice("You remove the upgrades from [src]."))

/obj/item/stock_parts/cell/microfusion/process(delta_time)
	for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
		microfusion_cell_attachment.process_upgrade(src, delta_time)
	return ..()

/obj/item/stock_parts/cell/microfusion/examine(mob/user)
	. = ..()
	if(attached_upgrades.len)
		for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
			. += span_notice("It has a [microfusion_cell_attachment.name] installed.")
		. += span_notice("Use a <b>screwdriver</b> to remove the upgrades.")


/obj/item/stock_parts/cell/microfusion/proc/attatch_upgrade(obj/item/microfusion_cell_attachment/microfusion_cell_attachment, mob/living/user)
	if(is_type_in_list(microfusion_cell_attachment, attached_upgrades))
		to_chat(user, span_warning("[src] already has [microfusion_cell_attachment] installed!"))
		return FALSE
	attached_upgrades += microfusion_cell_attachment
	microfusion_cell_attachment.forceMove(src)
	microfusion_cell_attachment.run_upgrade(src)
	to_chat(user, span_notice("You successfully install [microfusion_cell_attachment] onto [src]!"))
	playsound(src, 'sound/effects/structure_stress/pop2.ogg', 70, TRUE)
	return TRUE

/obj/item/stock_parts/cell/microfusion/proc/remove_upgrades()
	for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
		microfusion_cell_attachment.remove_upgrade(src)
		microfusion_cell_attachment.forceMove(get_turf(src))
		attached_upgrades -= microfusion_cell_attachment

/obj/item/stock_parts/cell/microfusion/enhanced
	name = "enhanced microfusion cell"
	desc = "An enhanced microfusion cell."
	icon_state = "microfusion_enhanced"
	maxcharge = 1500

/obj/item/stock_parts/cell/microfusion/advanced
	name = "advanced microfusion cell"
	desc = "An advanced microfusion cell."
	icon_state = "microfusion_advanced"
	maxcharge = 1700

/obj/item/stock_parts/cell/microfusion/bluespace
	name = "bluespace microfusion cell"
	desc = "An advanced microfusion cell."
	icon_state = "microfusion_advanced"
	maxcharge = 2000

