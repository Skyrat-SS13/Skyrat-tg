/obj/item/autosurgeon/organ/corticalstack
	desc = "A single-use autosurgeon that contains a cortical stack. A screwdriver can be used to remove it, but implants can't be placed back in."
	uses = 1
	starting_organ = /obj/item/organ/corticalstack

/obj/item/organ/corticalstack/syndicate
	name = "blood-red cortical stack"
	desc = "A strange, crystalline storage device containing 'DHF', digitised conciousness. This one has after-market modifications."
	invasive = 0

/obj/item/autosurgeon/organ/syndicate/corticalstack
	desc = "A dual-use autosurgeon that contains a blood-red cortical stack. This implanter is modified to be usable twice."
	uses = 2
	starting_organ = /obj/item/organ/corticalstack/syndicate

/datum/uplink_item/device_tools/corticalstack
	name = "Blood-Red Cortical Stack"
	desc = " A marvel of modern technology; the cortical stack, For when you really want to avoid that death. This one can be removed without killing the user; allowing 'double-sleeving'."
	item = /obj/item/autosurgeon/organ/syndicate/corticalstack
	cost = 5 //Support item

/datum/supply_pack/goody/corticalstack
	name = "Cortical Stack Crate"
	desc = "Important employee's? Unable to afford losing them without the chance of revival? Back them up to these chips that go in the base of the neck. Warranty not included."
	cost = CARGO_CRATE_VALUE * 6 //Expensive.
	contains = list(/obj/item/autosurgeon/organ/corticalstack,/obj/item/autosurgeon/organ/corticalstack,/obj/item/autosurgeon/organ/corticalstack)
	crate_name = "Cortical Stack Crate"

/obj/item/storage/backpack/duffelbag/syndie/loadout/believer/PopulateContents()
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/autosurgeon/organ/syndicate/corticalstack(src)
	new /obj/item/stackremover/syndicate(src)
	new /obj/item/book/granter/martial/cqc(src)
	new /obj/item/clothing/under/syndicate/sniper(src)
	new /obj/item/implanter/storage(src)
	new /obj/item/autosurgeon/organ/syndicate/anti_stun(src)

//Badass section down here
/datum/uplink_item/loadout_skyrat/believer
	name = "Believer Bundle"
	desc = "Named after the infamous collector of souls - the believer bundle, a collection of items to ensure you get that payment on time..."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/believer
	cost = 35
	progression_minimum = 30 MINUTES //+5 minutes for the cqc


