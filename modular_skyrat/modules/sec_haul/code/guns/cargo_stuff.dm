//SKYRAT AND SOL AMMO

/datum/supply_pack/security/lethalsolpistols
	name = ".35 Ammunition Crates"
	desc = "Contains 6 boxes of lethal ammunition for Sol .35 Pistol."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/obj/item/ammo_box/c35sol= 3,
					/obj/item/ammo_box/c35sol/ripper = 3,
				)
	crate_name = ".35 ammo crate"

/datum/supply_pack/security/lethalsolrifles
	name = ".40 Ammunition Crates"
	desc = "Contains 6 boxes of lethal ammunition for Sol .40 Rifle."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/obj/item/ammo_box/c40sol= 4,
					/obj/item/ammo_box/c40sol/pierce = 1,
					/obj/item/ammo_box/c40sol/incendiary = 1,
				)
	crate_name = ".40 ammo crate"

/datum/supply_pack/security/lethalskyratshotgun
	name = "12 Gauge Ammunition Crates"
	desc = "Contains 6 boxes of lethal ammunition for all 12 Gauge Shotguns."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/ammo_box/advanced/s12gauge/buckshot= 3,
					/obj/item/ammo_box/advanced/s12gauge = 3,
				)
	crate_name = "shotgun ammo crate"

/datum/supply_pack/security/armory/exoticskyratammo
	name = "12 Gauge Exotic Ammunition Crates"
	desc = "Contains 6 boxes of exotic ammunition for all 12 Gauge Shotguns."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/ammo_box/advanced/s12gauge/incendiary= 1,
					/obj/item/ammo_box/advanced/s12gauge/flechette = 1,
					/obj/item/ammo_box/advanced/s12gauge/express = 1,
					/obj/item/ammo_box/advanced/s12gauge/magnum = 1,
					/obj/item/ammo_box/advanced/s12gauge/flechette = 1,
					/obj/item/ammo_box/advanced/s12gauge/antitide = 1,
				)
	crate_name = "exotic shotgun ammo crate"
	contraband = TRUE

/datum/supply_pack/security/antiriotskyratshotgunammo
	name = "12 Gauge Anti Riot Ammunition Crates"
	desc = "Contains 6 boxes of anti riot grade ammunition for all 12 Gauge Shotguns."
	cost = CARGO_CRATE_VALUE * 12
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean = 2,
					/obj/item/ammo_box/advanced/s12gauge/beehive = 2,
					/obj/item/ammo_box/advanced/s12gauge/rubber = 2,
				)
	crate_name = "anti riot shotgun ammo crate"

//SOL GUNS

/datum/supply_pack/security/wespe
	name = "Wespe Three-Pack Crates"
	desc = "Contains three case of the .35 sol handgun, magazines included."
	cost = CARGO_CRATE_VALUE * 12
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe = 3,
					/obj/item/ammo_box/c35sol/incapacitator = 3,
				)
	crate_name = "wespe pistols crate"

/datum/supply_pack/security/eland
	name = "Eland Three-Pack Crates"
	desc = "Contains three case of the .35 sol revolver, munition boxes included."
	cost = CARGO_CRATE_VALUE * 12
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/eland = 3,
					/obj/item/ammo_box/c35sol/incapacitator = 3,
				)
	crate_name = "eland pistols crate"

/datum/supply_pack/security/armory/renoster
	name = "Carwo 'Renoster' Shotgun Crate"
	desc = "Contains two Carwo 'Renoster' shotguns. Additional ammmo sold separately."
	cost = CARGO_CRATE_VALUE * 30
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol = 2,
	/obj/item/ammo_box/advanced/s12gauge/buckshot = 2,
	)
	crate_name = "Carwo 'Renoster' Shotgun Crate"

/datum/supply_pack/security/armory/infanterie
	name = "Carwil Battle Rifle Crate"
	desc = "Contains two Carwil Battle Rifles, and two spare each magazines for them."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle = 2,
	/obj/item/ammo_box/magazine/c40sol_rifle = 4,
	)
	crate_name = "Carwil Battle Rifle Crate"
	contraband = TRUE

/datum/supply_pack/security/armory/cmg
	name = "Romulus Technology CMG Assault Rifle Crate"
	desc = "Two CMG-1, chambered in experimental steel flechette."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(
		/obj/item/storage/toolbox/guncase/skyrat/rom_flech,
		/obj/item/storage/toolbox/guncase/skyrat/rom_flech,
	)
	crate_name = "RomTech CMG-1 Crate"

/datum/supply_pack/security/armory/sindano
	name = "Carwo 'Sindano' Submachinegun Crate"
	desc = "Three entirely proprietary Sindano kits, chambered in .35 Sol Short. Each kit contains three empty magazines and a box each of incapacitator and lethal rounds."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(
		/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/sindano,
		/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/sindano,
		/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/sindano,
	)
	crate_name = "Carwo 'Sindano' Submachinegun Crate"

/datum/supply_pack/security/armory/marksman
	name = "Carwil Marksman Rifle Crate"
	desc = "Contains one Carwil Marksman Rifle, as well as 3 spare magazines for it."
	cost = CARGO_CRATE_VALUE * 12
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/marksman = 1,
	/obj/item/ammo_box/magazine/c40sol_rifle = 3,
	)
	crate_name = "Carwil Marksman Rifle Crate"

/datum/supply_pack/security/ammo
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean = 3,
					/obj/item/ammo_box/advanced/s12gauge/rubber = 3,
					/obj/item/ammo_box/c38/trac,
					/obj/item/ammo_box/c38/hotshot,
					/obj/item/ammo_box/c38/iceblox,
				)
	special = FALSE
//This makes the Security ammo crate use the cool advanced ammo boxes instead of the old ones

/datum/supply_pack/security/armory/kiboko
	name = "Kiboko Grenade Launcher Crate"
	cost = CARGO_CRATE_VALUE * 30
	desc = "Contains a Kiboko 25mm grenade launchers. A small dial on the sight allows you to set the length of the grenade fuse."
	contains = list(
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag = 1,
		/obj/item/ammo_box/magazine/c980_grenade/starts_empty = 3
	)
	crate_name = "Kiboko Grenade Launcher Crate"

/datum/supply_pack/security/armory/kiboko_riot
	name = "Kiboko 25mm Riot Pack"
	cost = CARGO_CRATE_VALUE * 8
	desc = "Contains three riot grade ammunition box."
	contains = list(
		/obj/item/ammo_box/c980grenade/riot = 3,
	)

//Goodies

