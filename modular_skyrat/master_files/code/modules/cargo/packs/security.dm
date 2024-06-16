//OVERRIDES

/datum/supply_pack/security/ammo
	special = TRUE

/datum/supply_pack/security/armor
	special = TRUE

/datum/supply_pack/security/disabler
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/security/helmets
	special = TRUE

/datum/supply_pack/security/securityclothes
	special = TRUE

/datum/supply_pack/security/armory/thermal
	access = ACCESS_SECURITY
	access_view = ACCESS_SECURITY

/datum/supply_pack/security/armory/ballistic
	name = "Peacekeeper Combat Shotguns Crates"
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat = 3,
					/obj/item/storage/pouch/ammo = 3,
					/obj/item/storage/belt/bandolier = 3)

//SKYRAT AND SOL AMMO

/datum/supply_pack/security/armory/lethalsolpistols
	name = ".35 Ammunition Crates"
	desc = "Contains 6 boxes of lethal ammunition for Sol .35 Pistol."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/ammo_box/c35sol= 3,
					/obj/item/ammo_box/c35sol/ripper = 3,
				)
	crate_name = ".35 ammo crate"

/datum/supply_pack/security/armory/lethalsolrifles
	name = ".40 Ammunition Crates"
	desc = "Contains 6 boxes of lethal ammunition for Sol .40 Rifle."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/ammo_box/c40sol= 4,
					/obj/item/ammo_box/c40sol/pierce = 1,
					/obj/item/ammo_box/c40sol/incendiary = 1,
				)
	crate_name = ".40 ammo crate"

/datum/supply_pack/security/armory/lethalskyratshotgun
	name = "12 Gauge Ammunition Crates"
	desc = "Contains 6 boxes of lethal ammunition for all 12 Gauge Shotguns."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/ammo_box/advanced/s12gauge/buckshot= 3,
					/obj/item/ammo_box/advanced/s12gauge = 3,
				)
	crate_name = "shotgun ammo crate"

/datum/supply_pack/security/armory/exoticskyratammo
	name = "12 Gauge Exotic Ammunition Crates"
	desc = "Contains 5 boxes of exotic ammunition for all 12 Gauge Shotguns."
	cost = CARGO_CRATE_VALUE * 12
	contains = list(/obj/item/ammo_box/advanced/s12gauge/incendiary= 1,
					/obj/item/ammo_box/advanced/s12gauge/flechette = 1,
					/obj/item/ammo_box/advanced/s12gauge/express = 1,
					/obj/item/ammo_box/advanced/s12gauge/magnum = 1,
					/obj/item/ammo_box/advanced/s12gauge/flechette = 1,

				)
	crate_name = "exotic shotgun ammo crate"
	contraband = TRUE

/datum/supply_pack/security/antiriotskyratshotgunammo
	name = "12 Gauge Anti Riot Ammunition Crates"
	desc = "Contains 6 boxes of anti riot grade ammunition for all 12 Gauge Shotguns."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean = 2,
					/obj/item/ammo_box/advanced/s12gauge/beehive = 2,
					/obj/item/ammo_box/advanced/s12gauge/antitide = 2,

				)
	crate_name = "anti riot shotgun ammo crate"

//SOL GUNS

/datum/supply_pack/security/wespe
	name = "Wespe Crates"
	desc = "Contains three case of the .35 sol handgun, magazines included."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe = 3,
					/obj/item/ammo_box/c35sol/incapacitator = 3,
				)
	crate_name = "wespe pistols crate"

/datum/supply_pack/security/eland
	name = "Eland Crate"
	desc = "Contains three case of the .35 sol revolver, munition boxes included."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/eland = 3,
					/obj/item/ammo_box/c35sol/incapacitator = 3,
				)
	crate_name = "eland pistols crate"

/datum/supply_pack/security/armory/cawilmarksmanrifle
	name = "Cawil Marksman Rifle Crates"
	desc = "Contains 2 Cawil Marksman Rifle with spare ammunition."
	cost = CARGO_CRATE_VALUE * 17.5
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/marksman = 2,
					/obj/item/ammo_box/magazine/c40sol_rifle = 4,
				)
	crate_name = "cawil marksman rifle crate"
