/obj/item/autosurgeon/organ/corticalstack
	desc = "A single use autosurgeon that contains a cortical stack. A screwdriver can be used to remove it, but implants can't be placed back in."
	uses = 1
	starting_organ = /obj/item/organ/corticalstack

/datum/uplink_item/device_tools/corticalstack
	name = "Cortical Stack"
	desc = " A marvel of modern technology; the cortical stack, For when you really want to avoid that death..."
	item = /obj/item/autosurgeon/organ/corticalstack
	cost = 5 //Support item

/datum/supply_pack/corticalstack
	name = "Cortical Stack Crate"
	desc = "Important employee's? Unable to afford losing them without the chance of revival? Back them up to these chips that go in the base of the neck. Warranty not included."
	cost = CARGO_CRATE_VALUE * 6 //Expensive.
	contains = list(/obj/item/autosurgeon/organ/corticalstack,/obj/item/autosurgeon/organ/corticalstack,/obj/item/autosurgeon/organ/corticalstack)
	crate_name = "Cortical Stack Crate"
