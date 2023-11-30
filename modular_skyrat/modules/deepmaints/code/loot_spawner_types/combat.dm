/obj/effect/spawner/random/deep_maintenance/ammo
	name = "deepmaint ammo spawner"
	replacement_closet = /obj/structure/closet/crate/secure/plasma
	loot = list(
		// Ammo boxes
		/obj/item/ammo_box/c38 = 3,
		/obj/item/ammo_box/c38/dumdum = 1,
		/obj/item/ammo_box/c38/match = 1,
		/obj/item/ammo_box/c35sol = 3,
		/obj/item/ammo_box/c35sol/ripper = 2,
		/obj/item/ammo_box/c40sol = 2,
		/obj/item/ammo_box/c40sol/pierce = 1,
		/obj/item/ammo_box/c585trappiste = 2,
		/obj/item/ammo_box/c585trappiste/hollowpoint = 1,
		/obj/item/ammo_box/c980grenade/smoke = 2,
		/obj/item/ammo_box/c980grenade/shrapnel = 1,
		/obj/item/ammo_box/c980grenade/shrapnel/phosphor = 1,
		/obj/item/ammo_box/strilka310 = 2,
		/obj/item/ammo_box/strilka310/surplus = 3,
		// Magazines
		/obj/item/ammo_box/magazine/c35sol_pistol = 2,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle = 2,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 2,
		/obj/item/ammo_box/magazine/c40sol_rifle/drum = 1,
		/obj/item/ammo_box/magazine/c585trappiste_pistol = 2,
		/obj/item/ammo_box/magazine/c980_grenade = 2,
		/obj/item/ammo_box/magazine/c980_grenade/drum = 1,
		// Shotgun shells
		/obj/item/ammo_box/advanced/s12gauge/beehive = 1,
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 2,
		/obj/item/ammo_box/advanced/s12gauge/express = 2,
		/obj/item/ammo_box/advanced/s12gauge/hp = 1,
		/obj/item/ammo_box/advanced/s12gauge/magnum = 1,
		/obj/item/ammo_box/advanced/s12gauge/pt20 = 1,
		/obj/item/ammo_box/advanced/s12gauge/rip = 1,
	)

/obj/effect/spawner/random/deep_maintenance/weapons_small
	name = "deepmaint small arms spawner"
	spawn_loot_count = 3
	replacement_closet = /obj/structure/closet/crate/secure/weapon
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/sol = 2,
		/obj/item/gun/ballistic/automatic/pistol/sol/evil = 1,
		/obj/item/gun/ballistic/automatic/pistol/trappiste = 1,
		/obj/item/gun/ballistic/revolver/c38 = 2,
		/obj/item/gun/ballistic/revolver/sol = 2,
		/obj/item/gun/ballistic/revolver/takbok = 1,
		/obj/item/gun/ballistic/automatic/sol_smg = 1,
		/obj/item/gun/ballistic/automatic/sol_smg/evil = 1,
		/obj/item/gun/ballistic/automatic/xhihao_smg = 1,
		/obj/item/gun/ballistic/automatic/m6pdw = 1,
	)

/obj/effect/spawner/random/deep_maintenance/weapons_serious
	name = "deepmaint serious arms spawner"
	spawn_loot_count = 3
	replacement_closet = /obj/structure/closet/secure_closet/tac
	loot = list(
		/obj/item/gun/ballistic/automatic/sol_rifle/marksman = 2,
		/obj/item/gun/ballistic/automatic/sol_rifle = 1,
		/obj/item/gun/ballistic/automatic/sol_rifle/evil = 1,
		/obj/item/gun/ballistic/automatic/sol_rifle/machinegun = 1,
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher = 1,
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil = 1,
		/obj/effect/spawner/random/sakhno = 2,
		/obj/item/gun/ballistic/shotgun/riot/sol = 2,
		/obj/item/gun/ballistic/shotgun/riot/sol/evil = 1,
		/obj/item/gun/ballistic/rifle/boltaction/prime = 1,
	)
