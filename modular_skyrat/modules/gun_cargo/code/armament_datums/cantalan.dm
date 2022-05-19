#define ARMAMENT_CATEGORY_CANTALAN "Cantalan Federal Arms"

/datum/armament_entry/cargo_gun/cantalan
	category = ARMAMENT_CATEGORY_CANTALAN
	company_bitflag = COMPANY_CANTALAN

/datum/armament_entry/cargo_gun/cantalan/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/cantalan/pistol/glock17
	item_type = /obj/item/gun/ballistic/automatic/pistol/g17
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 6

/datum/armament_entry/cargo_gun/cantalan/pistol/glock18
	item_type = /obj/item/gun/ballistic/automatic/pistol/g18
	lower_cost = CARGO_CRATE_VALUE * 15
	upper_cost = CARGO_CRATE_VALUE * 18
	interest_required = PASSED_INTEREST
	restricted = TRUE

/datum/armament_entry/cargo_gun/cantalan/pistol/snub
	item_type = /obj/item/gun/ballistic/automatic/pistol/cfa_snub
	lower_cost = CARGO_CRATE_VALUE * 8
	upper_cost = CARGO_CRATE_VALUE * 9

/datum/armament_entry/cargo_gun/cantalan/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN
	restricted = TRUE

/datum/armament_entry/cargo_gun/cantalan/smg/lynx
	item_type = /obj/item/gun/ballistic/automatic/cfa_lynx
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 13

/datum/armament_entry/cargo_gun/cantalan/smg/wildcat
	item_type = /obj/item/gun/ballistic/automatic/cfa_wildcat
	lower_cost = CARGO_CRATE_VALUE * 8
	upper_cost = CARGO_CRATE_VALUE * 10

/datum/armament_entry/cargo_gun/cantalan/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE
	interest_required = HIGH_INTEREST
	restricted = TRUE

/datum/armament_entry/cargo_gun/cantalan/rifle/catanheim
	item_type = /obj/item/gun/ballistic/automatic/cfa_rifle
	lower_cost = CARGO_CRATE_VALUE * 26
	upper_cost = CARGO_CRATE_VALUE * 30

/datum/armament_entry/cargo_gun/cantalan/ammo
	subcategory = ARMAMENT_SUBCATEGORY_AMMO
	stock_mult = 2
	interest_addition = COMPANY_INTEREST_AMMO
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/cargo_gun/cantalan/ammo/c34
	item_type = /obj/item/ammo_box/c34

/datum/armament_entry/cargo_gun/cantalan/ammo/c34_ap
	item_type = /obj/item/ammo_box/c34/ap

/datum/armament_entry/cargo_gun/cantalan/ammo/c34_in
	item_type = /obj/item/ammo_box/c34/fire

/datum/armament_entry/cargo_gun/cantalan/ammo/c34_rub
	item_type = /obj/item/ammo_box/c34/rubber

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm
	item_type = /obj/item/ammo_box/c12mm

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm_ap
	item_type = /obj/item/ammo_box/c12mm/ap

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm_in
	item_type = /obj/item/ammo_box/c12mm/fire

/datum/armament_entry/cargo_gun/cantalan/ammo/c12mm_hp
	item_type = /obj/item/ammo_box/c12mm/hp
