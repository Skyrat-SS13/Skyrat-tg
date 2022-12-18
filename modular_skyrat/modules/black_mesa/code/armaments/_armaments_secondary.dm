// SECONDARY WEAPONS
/datum/armament_entry/hecu/secondary
	category = ARMAMENT_CATEGORY_SECONDARY
	category_item_limit = 4
	cost = 5
	mags_to_spawn = 2

/datum/armament_entry/hecu/secondary/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/hecu/secondary/pistol/m1911
	item_type = /obj/item/gun/ballistic/automatic/pistol/m1911
	max_purchase = 4

/datum/armament_entry/hecu/secondary/pistol/glock
	item_type = /obj/item/gun/ballistic/automatic/pistol/g17/mesa
	max_purchase = 4
	mags_to_spawn = 3

/datum/armament_entry/hecu/secondary/pistol/revolver
	item_type = /obj/item/gun/ballistic/revolver/detective
	max_purchase = 4
	cost = 3
	mags_to_spawn = 0
	magazine = /obj/item/storage/box/ammo_box/revolver
	magazine_cost = 4

/obj/item/storage/box/ammo_box/revolver

/obj/item/storage/box/ammo_box/revolver/PopulateContents()
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38/dumdum(src)
	new /obj/item/ammo_box/c38/dumdum(src)
	new /obj/item/ammo_box/c38/match(src)
