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
	desc = "Old but gold, the classic pistol from the golden age of SR, whatever that place is. The M1911 chambered in .460 Ceres. It is sure to give anyone daring to fight you, a second thought. Note that this is a reproduction model by Romulus Federation and may be commonly found in the hand of a Kayit"
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/m1911_gold = 1,
	)
	cost = PAYCHECK_COMMAND * 25 //The pistol is more expensive than rifle because of portability. Not Lethality
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/ceremonial_rifle
	name = "Romulus Sporting Rifle"
	desc = "A sporting rifle made of light polymer material chambered in Sol .40, poor recoil handling but quite accurate."
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/ceremonial_rifle = 1)
	cost = PAYCHECK_COMMAND * 20
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/nt_shotgun
	name = "NanoTrasen Woodstock Shotgun"
	desc = "A classic Shotgun used by hunters, police and frontiersmen alike, now at an affordable price."
	cost = PAYCHECK_COMMAND * 20
	contains = list(/obj/item/gun/ballistic/shotgun/riot, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/hunter)

/datum/supply_pack/goody/rensoter_shotgun
	name = "Renoster Shotgun Single-Pack"
	desc = "A common modern shotgun used by Solarian State Police."
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/rubber)
	cost = PAYCHECK_COMMAND * 22

/datum/supply_pack/goody/double_barrel
	name = "Double-barreled Shotgun Single-Pack"
	desc = "Lost your beloved bunny to a demonic invasion? Clown broke in and stole your beloved gun? No worries! Get a new gun as long as you can pay the absurd fees."
	cost = PAYCHECK_COMMAND * 14 //This is outclassed by peacekeeper combat shotgun
