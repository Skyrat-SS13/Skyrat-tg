//OVERRIDES

/datum/supply_pack/security/ammo
	special = TRUE

/datum/supply_pack/goody/energy_single
	name = "Energy Gun Single-Pack"
	desc = "Contains one energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = PAYCHECK_COMMAND * 6
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun)

//The price seems silly but do understand that ballistic should  be as restricted as possible
//We should prioritise the availability and viability of energy weapon first and foremost

/datum/supply_pack/goody/laser_single
	name = "Laser Gun Single-Pack"
	desc = "Contains one laser gun, the lethal workhorse of Nanotrasen security everywehere."
	cost = PAYCHECK_COMMAND * 3
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser)

/datum/supply_pack/security/armory/ballistic
	name = "Peacekeeper Combat Shotguns Crates"
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat = 3,
					/obj/item/storage/pouch/ammo = 3,
					/obj/item/storage/belt/bandolier = 3)

/datum/supply_pack/goody/energy_single
	name = "Energy Gun Single-Pack"
	desc = "Contains one energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = PAYCHECK_COMMAND * 12
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun)

/datum/supply_pack/goody/laser_single
	name = "Laser Gun Single-Pack"
	desc = "Contains one laser gun, the lethal workhorse of Nanotrasen security everywehere."
	cost = PAYCHECK_COMMAND * 6
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser)

/datum/supply_pack/security/armory/ionrifle
	name = "Ion Carbine Crate"
	cost = CARGO_CRATE_VALUE * 18 //Same as the energy gun crate
	desc = "Contains two Ion Carbines, for when you need to deal with speedy space tiders, mechs, or upstart silicons."
	contains = list(/obj/item/gun/energy/ionrifle/carbine = 2)
	crate_name = "Ion Carbine Crate"

/datum/supply_pack/security/miniegun
	name = "Mini E-Gun Bulk Crate"
	cost = CARGO_CRATE_VALUE * 2
	desc = "Contains three mini e-guns, cheap and semi-effective, for when you need to arm up on a budget."
	contains = list(/obj/item/gun/energy/e_gun/mini = 3)
	crate_name = "Mini E-Gun Bulk Crate"
//You know the problem is literally nobody want to buy the mini-egun even if it was cheap

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
	name = "Wespe Three-Pack Crates"
	desc = "Contains three case of the .35 sol handgun, magazines included."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe = 3,
					/obj/item/ammo_box/c35sol/incapacitator = 3,
				)
	crate_name = "wespe pistols crate"

/datum/supply_pack/security/eland
	name = "Eland Three-Pack Crates"
	desc = "Contains three case of the .35 sol revolver, munition boxes included."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/eland = 3,
					/obj/item/ammo_box/c35sol/incapacitator = 3,
				)
	crate_name = "eland pistols crate"

/datum/supply_pack/security/armory/cawilmarksmanrifle
	name = "Carwil Marksman Rifle Crates"
	desc = "Contains 2 Cawil Marksman Rifle with spare ammunition."
	cost = CARGO_CRATE_VALUE * 17.5
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/marksman = 2,
					/obj/item/ammo_box/magazine/c40sol_rifle = 4,
				)
	crate_name = "cawil marksman rifle crate"

/datum/supply_pack/security/armory/renoster
	name = "Carwo 'Renoster' Shotgun Crate"
	desc = "Contains two Carwo 'Renoster' shotguns. Additional ammmo sold separately."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol = 2,
	/obj/item/ammo_box/advanced/s12gauge/buckshot = 2,
	)
	crate_name = "Carwo 'Renoster' Shotgun Crate"

/datum/supply_pack/security/armory/sindano
	name = "Sindano Submachinegun Crate"
	cost = CARGO_CRATE_VALUE * 20
	desc = "Contains two Sindano Submachineguns, and four spare magazines for them."
	contains = list(/obj/item/gun/ballistic/automatic/sol_smg = 2,
	/obj/item/ammo_box/magazine/c35sol_pistol = 4,
	)

	crate_name = "Sindano Submachinegun Crate"

/datum/supply_pack/security/armory/infanterie
	name = "Carwil Battle Rifle Crate"
	desc = "Contains two Carwil Battle Rifles, and two spare each magazines for them."
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle = 2,
	/obj/item/ammo_box/magazine/c40sol_rifle = 4,
	)
	crate_name = "Carwil Battle Rifle Crate"

/datum/supply_pack/security/armory/elite
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
	cost = CARGO_CRATE_VALUE * 20
	desc = "Contains two Kiboko 25mm grenade launchers. A small dial on the sight allows you to set the length of the grenade fuse."
	contains = list(
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag = 1,
		/obj/item/ammo_box/magazine/c980_grenade/starts_empty = 3
	)
	crate_name = "Kiboko Grenade Launcher Crate"

/datum/supply_pack/security/armory/kiboko_variety
	name = "Kiboko 25mm Variety Pack"
	cost = CARGO_CRATE_VALUE * 8
	desc = "Contains a variety of ammo types for the Kiboko 25mm Grenade Launcher. three riot box."
	contains = list(
		/obj/item/ammo_box/c980grenade/riot = 3,
	)
