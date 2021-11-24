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
	/// Does this attatchment process with the cell?
	var/processing_attachment = FALSE
	/// How much stability does this cost the cell?
	var/stability_impact = 0

/obj/item/microfusion_cell_attachment/examine(mob/user)
	. = ..()
	. += span_notice("It has a stability impact factor of [stability_impact]%.")

/obj/item/microfusion_cell_attachment/proc/run_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	START_PROCESSING(SSobj, microfusion_cell)
	microfusion_cell.instability += stability_impact
	return

/obj/item/microfusion_cell_attachment/proc/process_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell, delta_time)
	return PROCESS_KILL

/obj/item/microfusion_cell_attachment/proc/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	STOP_PROCESSING(SSobj, microfusion_cell)
	microfusion_cell.instability -= stability_impact
	return

/*
RECHARGABLE ATTACHMENT

Allows the cell to be recharged at a gun recharger OR cell recharger.
*/
/obj/item/microfusion_cell_attachment/rechargeable
	name = "rechargeable microfusion cell attachment"
	desc = "Enables recharging on the microfusion cell its attatched to."
	icon_state = "attachment_rechargeable"
	attachment_overlay_icon_state = "microfusion_rechargeable"
	/// The bonus charge rate by adding this attachment.
	var/charge_rate = 100
	var/initial_charge_rate = 0
	stability_impact = 0.5

/obj/item/microfusion_cell_attachment/rechargeable/run_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	initial_charge_rate = microfusion_cell.chargerate
	microfusion_cell.chargerate += charge_rate

/obj/item/microfusion_cell_attachment/rechargeable/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.chargerate -= initial_charge_rate
	initial_charge_rate = 0

/*
OVERCAPACITY ATTACHMENT

Increases the cell capacity by a set percentage.
*/
/obj/item/microfusion_cell_attachment/overcapacity
	name = "overcapacity microfusion cell attachment"
	desc = "Increases the capacity on the microfusion cell its attatched to."
	icon_state = "attachment_overcapacity"
	attachment_overlay_icon_state = "microfusion_overcapacity"
	/// The amount of capacity adding this attachment to the cell gives.
	var/capacity_increase = 20 //PRECENT
	var/initial_charge_capacity = 0
	stability_impact = 1

/obj/item/microfusion_cell_attachment/overcapacity/run_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
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
STABALISER ATTACHMENT

The cell is stable and will not emit sparks when firing.
*/

/obj/item/microfusion_cell_attachment/stabaliser
	name = "stabalisation microfusion cell attachment"
	desc = "Stabalises the internal fusion reaction of microfusion cells."
	icon_state = "attachment_stabaliser"
	attachment_overlay_icon_state = "microfusion_stabaliser"
	stability_impact = -10

/obj/item/microfusion_cell_attachment/stabaliser/run_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.stabalised = TRUE

/obj/item/microfusion_cell_attachment/stabaliser/remove_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.stabalised = FALSE

/*
SELFCHARGE ATTACHMENT

The cell will charge itself.
If the cell isn't stabalised by a stabaliser, it may emit a radaition pulse.
*/
/obj/item/microfusion_cell_attachment/selfcharging
	name = "self charging microfusion cell attachment"
	desc = "Contains a small amount of infinitely decaying nuclear material, causing the fusion reaction to be self sustaining. WARNING: May cause radiation burns if not stabalised."
	icon_state = "attachment_selfcharge"
	attachment_overlay_icon_state = "microfusion_selfcharge"
	var/self_charge_amount = 20
	stability_impact = 5

/obj/item/microfusion_cell_attachment/selfcharging/process_attachment(obj/item/stock_parts/cell/microfusion/microfusion_cell, delta_time)
	microfusion_cell.charge = clamp(microfusion_cell.charge + (microfusion_cell.chargerate + self_charge_amount * delta_time / 2), 0, microfusion_cell.maxcharge)
	if(istype(microfusion_cell.loc, /obj/item/gun/energy))
		var/obj/item/gun/energy/our_gun = microfusion_cell.loc
		our_gun.update_appearance()
	if(!microfusion_cell.instability && DT_PROB(1, delta_time))
		radiation_pulse(src, 1, RAD_MEDIUM_INSULATION)

