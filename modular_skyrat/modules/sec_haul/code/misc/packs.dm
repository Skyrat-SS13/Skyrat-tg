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

//Goodies..

/datum/supply_pack/goody/m1911
	name = "Authentic SR Sector M1911"
	desc = "Old but gold, the m1911 chambered in .45 is sure to give anyone daring to fight you, a second thought."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/m1911/gold = 1,
	/obj/item/ammo_box/magazine/m45 = 3,
	)
	cost = PAYCHECK_COMMAND * 24
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/sporting_rifle
	name = "Authentic SR Sector M1911"
	desc = "Old but gold, the m1911 chambered in .45 is sure to give anyone daring to fight you, a second thought."
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/sporting_rifle = 1)
	cost = PAYCHECK_COMMAND * 24
	access_view = ACCESS_WEAPONS
