/*
MICROFUSION UPGRADE ATTACHMENTS

For adding unique abilities to microfusion cells. These cannot directly interact with the gun.
*/

/obj/item/microfusion_attachment
	name = "microfusion cell attachment"
	desc = "broken"
	icon = 'modular_skyrat/modules/microfusion/icons/microfusion_cells.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	var/attachment_overlay_icon_state

/obj/item/microfusion_attachment/proc/run_upgrade(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	microfusion_cell.update_appearance()
	return

/obj/item/microfusion_attachment/proc/remove_upgrade(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	SHOULD_CALL_PARENT(TRUE)
	microfusion_cell.update_appearance()
	return

/*
RECHARGABLE ATTACHMENT

Allows the cell to be recharged at a gun recharger OR cell recharger.
*/

/obj/item/microfusion_attachment/rechargeable
	name = "rechargeable microfusion upgrade"
	desc = "Enables recharging on the microfusion cell its attatched to."
	icon_state = "attachment_rechargeable"
	/// The bonus charge rate by adding this upgrade.
	var/charge_rate = 100
	var/initial_charge_rate = 0

/obj/item/microfusion_attachment/rechargeable/run_upgrade(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	initial_charge_rate = microfusion_cell.chargerate
	microfusion_cell.chargerate += charge_rate

/obj/item/microfusion_attachment/rechargeable/remove_upgrade(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.chargerate -= initial_charge_rate
	initial_charge_rate = 0

/*
OVERCAPACITY ATTACHMENT

Increases the cell capacity by a set percentage.
*/

/obj/item/microfusion_attachment/overcapacity
	name = "overcapacity microfusion upgrade"
	desc = "increases the capacity on the microfusion cell its attatched to."
	icon_state = "attachment_overcapacity"
	/// The amount of capacity adding this attachment to the cell gives.
	var/capacity_increase = 50 //PRECENT
	var/initial_charge_capacity = 0

/obj/item/microfusion_attachment/overcapacity/run_upgrade(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	initial_charge_capacity = microfusion_cell.maxcharge
	var/capacity_to_add = microfusion_cell.maxcharge / 100 * capacity_increase
	microfusion_cell.maxcharge += capacity_to_add

/obj/item/microfusion_attachment/overcapacity/remove_upgrade(obj/item/stock_parts/cell/microfusion/microfusion_cell)
	. = ..()
	microfusion_cell.charge = min(microfusion_cell.charge, initial_charge_capacity)
	microfusion_cell.maxcharge = initial_charge_capacity
	initial_charge_capacity = 0
