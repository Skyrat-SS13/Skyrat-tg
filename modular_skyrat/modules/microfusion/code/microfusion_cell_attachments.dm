/*
MICROFUSION CELL UPGRADE ATTACHMENTS

For adding unique abilities to microfusion cells. These cannot directly interact with the gun.
*/

/obj/item/microfusion_cell_attachment
	name = "microfusion cell attachment"
	desc = "broken"
	icon = 'modular_skyrat/modules/microfusion/icons/microfusion_cells.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	/// The overlay that will be automatically added, must be in the cells icon.
	var/attachment_overlay_icon_state


/obj/item/microfusion_cell_attachment/proc/add_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	START_PROCESSING(SSobj, microfusion_cell)
	return

/obj/item/microfusion_cell_attachment/proc/process_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell, seconds_per_tick)
	return PROCESS_KILL

/obj/item/microfusion_cell_attachment/proc/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	STOP_PROCESSING(SSobj, microfusion_cell)
	return

/*
OVERCAPACITY ATTACHMENT

Increases the cell capacity by a set percentage.
*/

/obj/item/microfusion_cell_attachment/overcapacity
	name = "overcapacity microfusion cell attachment"
	desc = "An attachment which increases the capacity of the microfusion cell it's attached to. These are an additional, smaller capacitor, using a system to automatically switch from the cell to the capacitor as it's depleted, maximizing the weapon's charge."
	icon_state = "attachment_overcapacity"
	attachment_overlay_icon_state = "microfusion_overcapacity"
	/// How much the attachment increases the cell's capacity by, as a percentage
	var/capacity_increase = 20
	/// The initial capacity of the cell before this upgrade is added!
	var/initial_charge_capacity = 0

/obj/item/microfusion_cell_attachment/overcapacity/add_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	initial_charge_capacity = microfusion_cell.maxcharge
	var/capacity_to_add = microfusion_cell.maxcharge / 100 * capacity_increase
	microfusion_cell.maxcharge += capacity_to_add

/obj/item/microfusion_cell_attachment/overcapacity/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.charge = min(microfusion_cell.charge, initial_charge_capacity)
	microfusion_cell.maxcharge = initial_charge_capacity
	initial_charge_capacity = 0

/*
STABILISER ATTACHMENT

The cell is stable and will not emit sparks when firing.
*/

/obj/item/microfusion_cell_attachment/stabiliser
	name = "stabilising microfusion cell attachment"
	desc = "A stabilizer system attachment combining a grounding system with additional containment coils for self-charging purposes, this gives additional safety to the cell it's attached to; preventing both sparks and leakage."
	icon_state = "attachment_stabiliser"
	attachment_overlay_icon_state = "microfusion_stabiliser"

/obj/item/microfusion_cell_attachment/stabiliser/add_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.stabilised = TRUE

/obj/item/microfusion_cell_attachment/stabiliser/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.stabilised = FALSE

/*
SELFCHARGE ATTACHMENT

The cell will charge itself.
If the cell isn't stabilised by a stabiliser, it may emit a radiation pulse.
*/

/obj/item/microfusion_cell_attachment/selfcharging
	name = "self-charging microfusion cell attachment"
	desc = "While microfusion cells are normally shipped without their fuel source, this attachment comes with fifteen grams of hydrogen fuel; allowing the cell to sustain a small, yet active reaction to self-charge. These can keep going for weeks to months in ideal conditions, making them more than enough for most campaigns."
	icon_state = "attachment_selfcharge"
	attachment_overlay_icon_state = "microfusion_selfcharge"
	/// The amount of charge this cell will passively gain!
	var/self_charge_amount = STANDARD_CELL_CHARGE*(0.02)

/obj/item/microfusion_cell_attachment/selfcharging/examine(mob/user)
	. = ..()
	. += span_warning("WARNING: May cause radiation burns and weapon instability if not stabilized with recommended attachment!")

/obj/item/microfusion_cell_attachment/selfcharging/add_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.self_charging = TRUE

/obj/item/microfusion_cell_attachment/selfcharging/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.self_charging = FALSE

/obj/item/microfusion_cell_attachment/selfcharging/process_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell, seconds_per_tick)
	if(!microfusion_cell.parent_gun)
		return
	if(microfusion_cell.charge < microfusion_cell.maxcharge)
		microfusion_cell.give(self_charge_amount * seconds_per_tick)
		microfusion_cell.parent_gun.update_appearance()
	if(!microfusion_cell.stabilised && SPT_PROB(1, seconds_per_tick))
		radiation_pulse(src, 1, RAD_MEDIUM_INSULATION)
