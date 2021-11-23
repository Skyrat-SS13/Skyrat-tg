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
	maxcharge = 700 //7 shots
	chargerate = 0 //Standard microfusion cells can't be recharged, they're single use.

	var/list/attatched_upgrades = list()

/obj/item/stock_parts/cell/microfusion/Destroy()
	if(attatched_upgrades.len)
		for(var/obj/item/iterating_item in attatched_upgrades)
			iterating_item.forceMove(get_turf(src))
		attatched_upgrades = null
	return ..()

/obj/item/stock_parts/cell/microfusion/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/microfusion_attatchment))
		attatch_upgrade(attacking_item, user)
		return
	return ..()

/obj/item/stock_parts/cell/microfusion/update_overlays()
	. = ..()
	for(var/obj/item/microfusion_attatchment/microfusion_attatchment in attatched_upgrades)
		. += microfusion_attatchment.attatchment_overlay_icon_state

/obj/item/stock_parts/cell/microfusion/screwdriver_act(mob/living/user, obj/item/tool)
	remove_upgrades()
	to_chat(user, span_notice("You remove the upgrades from [src]."))

/obj/item/stock_parts/cell/microfusion/proc/attatch_upgrade(obj/item/microfusion_attatchment/microfusion_attatchment, mob/living/user)
	if(microfusion_attatchment in attatched_upgrades)
		to_chat(user, span_warning("[src] already has [microfusion_attatchment] installed!"))
		return FALSE
	attatched_upgrades += microfusion_attatchment
	microfusion_attatchment.forceMove(src)
	microfusion_attatchment.run_upgrade(src)
	to_chat(user, span_notice("You successfully install [microfusion_attatchment] onto [src]!"))
	return TRUE

/obj/item/stock_parts/cell/microfusion/proc/remove_upgrades()
	for(var/obj/item/microfusion_attatchment/microfusion_attatchment in attatched_upgrades)
		microfusion_attatchment.remove_upgrade(src)
		microfusion_attatchment.forceMove(get_turf(src))
		attatched_upgrades -= microfusion_attatchment

/obj/item/stock_parts/cell/microfusion/enhanced
	name = "enhanced microfusion cell"
	desc = "An enhanced microfusion cell."
	icon_state = "microfusion_enhanced"
	maxcharge = 1400

/obj/item/stock_parts/cell/microfusion/advanced
	name = "advanced microfusion cell"
	desc = "An advanced microfusion cell."
	icon_state = "microfusion_advanced"
	maxcharge = 2100

/obj/item/stock_parts/cell/microfusion/bluespace
	name = "bluespace microfusion cell"
	desc = "An advanced microfusion cell."
	icon_state = "microfusion_advanced"
	maxcharge = 2800


