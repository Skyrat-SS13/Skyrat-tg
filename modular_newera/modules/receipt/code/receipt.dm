/obj/item/receipt
	name = "receipt"
	icon = 'modular_newera/modules/receipt/icons/receipt.dmi'
	icon_state = "receipt"
	desc = "This is an receipt issued by an vending machine."
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE

/obj/machinery/vending/proc/issue_receipt(item, id, cost, machine, location)
    var/obj/item/receipt/r = new /obj/item/receipt(get_turf(src))
    r.desc += " This one says that an [item] was sold by [cost] credits and paid by [id]. Issued by [machine] at [location]."