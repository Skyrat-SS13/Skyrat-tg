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
	 /// Does this attachment process with the cell?
	var/processing_attachment = FALSE


/obj/item/microfusion_cell_attachment/proc/add_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	START_PROCESSING(SSobj, microfusion_cell)
	return

/obj/item/microfusion_cell_attachment/proc/process_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell, delta_time)
	return PROCESS_KILL

/obj/item/microfusion_cell_attachment/proc/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	STOP_PROCESSING(SSobj, microfusion_cell)
	return

/*
RECHARGABLE ATTACHMENT

Allows the cell to be recharged at a gun recharger OR cell recharger.
*/
/obj/item/microfusion_cell_attachment/rechargeable
	name = "rechargeable microfusion cell attachment"
	desc = "Enables recharging on the microfusion cell it's attached to."
	icon_state = "attachment_rechargeable"
	attachment_overlay_icon_state = "microfusion_rechargeable"
	/// The bonus charge rate by adding this attachment.
	var/bonus_charge_rate = 100

/obj/item/microfusion_cell_attachment/rechargeable/add_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.chargerate += bonus_charge_rate

/obj/item/microfusion_cell_attachment/rechargeable/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.chargerate -= bonus_charge_rate

/*
OVERCAPACITY ATTACHMENT

Increases the cell capacity by a set percentage.
*/
/obj/item/microfusion_cell_attachment/overcapacity
	name = "overcapacity microfusion cell attachment"
	desc = "Increases the capacity on the microfusion cell it's attached to."
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
	name = "stabilisation microfusion cell attachment"
	desc = "Stabilises the internal fusion reaction of microfusion cells."
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
If the cell isn't stabilised by a stabiliser, it may emit a radaition pulse.
*/
/obj/item/microfusion_cell_attachment/selfcharging
	name = "self charging microfusion cell attachment"
	desc = "Contains a small amount of infinitely decaying nuclear material, causing the fusion reaction to be self sustaining. WARNING: May cause radiation burns if not stabilised."
	icon_state = "attachment_selfcharge"
	attachment_overlay_icon_state = "microfusion_selfcharge"
	/// The amount of charge this cell will passively gain!
	var/self_charge_amount = 20

/obj/item/microfusion_cell_attachment/selfcharging/add_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.self_charging = TRUE

/obj/item/microfusion_cell_attachment/selfcharging/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.self_charging = FALSE

/obj/item/microfusion_cell_attachment/selfcharging/process_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell, delta_time)
	if(microfusion_cell.charge < microfusion_cell.maxcharge)
		microfusion_cell.charge = clamp(microfusion_cell.charge + (self_charge_amount * delta_time), 0, microfusion_cell.maxcharge)
		if(microfusion_cell.parent_gun)
			microfusion_cell.parent_gun.update_appearance()
		if(!microfusion_cell.stabilised && DT_PROB(1, delta_time))
			radiation_pulse(src, 1, RAD_MEDIUM_INSULATION)

