#define ARMAMENT_CATEGORY_CANTALAN "Cantalan Federal Arms"

/datum/armament_entry/cargo_gun/cantalan
	category = ARMAMENT_CATEGORY_CANTALAN
	company_bitflag = COMPANY_CANTALAN

/datum/armament_entry/cargo_gun/cantalan/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/cantalan/pistol/glock17
	item_type = /obj/item/gun/ballistic/automatic/pistol/g17
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/pistol/glock18
	item_type = /obj/item/gun/ballistic/automatic/pistol/g18
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/pistol/snub
	item_type = /obj/item/gun/ballistic/automatic/pistol/cfa_snub
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/pistol/ruby
	item_type = /obj/item/gun/ballistic/automatic/pistol/cfa_ruby
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN

/datum/armament_entry/cargo_gun/cantalan/smg/lynx
	item_type = /obj/item/gun/ballistic/automatic/cfa_lynx
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/smg/wildcat
	item_type = /obj/item/gun/ballistic/automatic/cfa_wildcat
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE

/datum/armament_entry/cargo_gun/cantalan/rifle/catanheim
	item_type = /obj/item/gun/ballistic/automatic/cfa_rifle
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo
	subcategory = ARMAMENT_SUBCATEGORY_AMMO
	stock_mult = 2
	is_gun = FALSE

/datum/armament_entry/cargo_gun/cantalan/ammo/c34
	item_type = /obj/item/ammo_box/c34
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo/c34_ap
	item_type = /obj/item/ammo_box/c34/ap
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo/c34_in
	item_type = /obj/item/ammo_box/c34/fire
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo/c34_rub
	item_type = /obj/item/ammo_box/c34/rubber
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm
	item_type = /obj/item/ammo_box/c12mm
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm_ap
	item_type = /obj/item/ammo_box/c12mm/ap
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm_in
	item_type = /obj/item/ammo_box/c12mm/fire
	cost = 1

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm_hp
	item_type = /obj/item/ammo_box/c12mm/hp
	cost = 1
