/datum/armament_entry/hecu/primary
	category = ARMAMENT_CATEGORY_PRIMARY
	category_item_limit = 4
	slot_to_equip = ITEM_SLOT_SUITSTORE
	cost = 10

/datum/armament_entry/hecu/primary/submachinegun
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN
	mags_to_spawn = 4

/datum/armament_entry/hecu/primary/submachinegun/p90
	item_type = /obj/item/gun/ballistic/automatic/p90
	max_purchase = 4
	cost = 7

/datum/armament_entry/hecu/primary/submachinegun/mp5
	item_type = /obj/item/gun/ballistic/automatic/mp5
	max_purchase = 2
	cost = 8

/datum/armament_entry/hecu/primary/assaultrifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE
	mags_to_spawn = 3

/datum/armament_entry/hecu/primary/assaultrifle/m16
	item_type = /obj/item/gun/ballistic/automatic/m16
	max_purchase = 1
	cost = 14
	magazine = /obj/item/ammo_box/magazine/m16

/datum/armament_entry/hecu/primary/assaultrifle/m16_but_horrible
	item_type = /obj/item/gun/ballistic/automatic/m16/oldarms
	max_purchase = 2
	cost = 11
	magazine = /obj/item/ammo_box/magazine/m16/vintage/oldarms

/datum/armament_entry/hecu/primary/shotgun
	subcategory = ARMAMENT_SUBCATEGORY_SHOTGUN
	mags_to_spawn = 1
	magazine = /obj/item/storage/box/ammo_box/shotgun_12g
	magazine_cost = 4

/datum/armament_entry/hecu/primary/shotgun/shotgun_highcap
	item_type = /obj/item/gun/ballistic/shotgun/m23
	max_purchase = 2
	cost = 5

/datum/armament_entry/hecu/primary/shotgun/autoshotgun_pump
	item_type = /obj/item/gun/ballistic/shotgun/automatic/as2
	max_purchase = 1
	cost = 7

/datum/armament_entry/hecu/primary/special
	subcategory = ARMAMENT_SUBCATEGORY_SPECIAL
	mags_to_spawn = 2

/datum/armament_entry/hecu/primary/special/sniper_rifle
	item_type = /obj/item/gun/ballistic/automatic/cfa_rifle
	max_purchase = 1
	cost = 16

/datum/armament_entry/hecu/primary/special/hmg
	item_type = /obj/item/mounted_machine_gun_folded
	max_purchase = 1
	cost = 20
	magazine = /obj/item/ammo_box/magazine/mmg_box
	mags_to_spawn = 1
	magazine_cost = 2

/obj/item/storage/box/ammo_box/shotgun_12g

/obj/item/storage/box/ammo_box/shotgun_12g/PopulateContents()
	var/funshell = pick(/obj/item/ammo_box/advanced/s12gauge/pt20,
						/obj/item/ammo_box/advanced/s12gauge/incendiary,
						/obj/item/ammo_box/advanced/s12gauge/flechette,
						/obj/item/ammo_box/advanced/s12gauge/beehive,
						/obj/item/ammo_box/advanced/s12gauge/iceblox,
						/obj/item/ammo_box/advanced/s12gauge/rip,)
	new /obj/item/ammo_box/advanced/s12gauge/magnum(src)
	new /obj/item/ammo_box/advanced/s12gauge(src)
	new funshell(src)
