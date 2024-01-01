/datum/supply_pack/vending/sectech
	name = "Peacekeeper Equipment Supply Crate"
	desc = "Armadyne branded Peacekeeper supply crate, filled with things you need to restock the equipment vendor."
	crate_name = "Peacekeeper equipment supply crate"

/datum/supply_pack/vending/wardrobes/security
	name = "Peacekeeper Wardrobe Supply Crate"
	desc = "This crate contains refills for the Peacekeeper Outfitting Station, DetDrobe, and LawDrobe."

/datum/supply_pack/vending/wardrobes/command
	name = "Command Wardrobe Supply Crate"
	desc = "This crate contains refills for the Command Outfitting Station."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/vending_refill/wardrobe/comm_wardrobe,
	)
	crate_name = "Commandrobe Resupply Crate"
