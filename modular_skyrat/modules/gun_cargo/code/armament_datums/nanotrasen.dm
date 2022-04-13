#define ARMAMENT_CATEGORY_NANOTRASEN "Nanotrasen Armories"

/datum/armament_entry/cargo_gun/nanotrasen
	category = ARMAMENT_CATEGORY_NANOTRASEN
	company_bitflag = COMPANY_NANOTRASEN

/datum/armament_entry/cargo_gun/nanotrasen/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/nanotrasen/pistol/thermal_holster
	item_type = /obj/item/storage/belt/holster/thermal
	lower_cost = CARGO_CRATE_VALUE * 8
	upper_cost = CARGO_CRATE_VALUE * 12

/datum/armament_entry/cargo_gun/nanotrasen/shotgun
	subcategory = ARMAMENT_SUBCATEGORY_SHOTGUN

/datum/armament_entry/cargo_gun/nanotrasen/shotgun/riot
	item_type = /obj/item/gun/ballistic/shotgun/riot
	lower_cost = CARGO_CRATE_VALUE * 8
	upper_cost = CARGO_CRATE_VALUE * 12

/datum/armament_entry/cargo_gun/nanotrasen/shotgun/combat
	item_type = /obj/item/gun/ballistic/shotgun/automatic/combat
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 14

/datum/armament_entry/cargo_gun/nanotrasen/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN

/datum/armament_entry/cargo_gun/nanotrasen/smg/saber
	item_type = /obj/item/gun/ballistic/automatic/proto
	lower_cost = CARGO_CRATE_VALUE * 12
	upper_cost = CARGO_CRATE_VALUE * 18

/datum/armament_entry/cargo_gun/nanotrasen/smg/cmg //change when cobalt's CMG changes go through
	item_type = /obj/item/gun/ballistic/automatic/c20r/unrestricted/cmg1
	lower_cost = CARGO_CRATE_VALUE * 8
	upper_cost = CARGO_CRATE_VALUE * 13

/datum/armament_entry/cargo_gun/nanotrasen/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE

/datum/armament_entry/cargo_gun/nanotrasen/rifle/wtrifle
	item_type = /obj/item/gun/ballistic/automatic/wt550
	lower_cost = CARGO_CRATE_VALUE * 12
	upper_cost = CARGO_CRATE_VALUE * 16

/datum/armament_entry/cargo_gun/nanotrasen/rifle/boarder
	item_type = /obj/item/gun/ballistic/automatic/ar
	lower_cost = CARGO_CRATE_VALUE * 20
	upper_cost = CARGO_CRATE_VALUE * 24

/datum/armament_entry/cargo_gun/nanotrasen/rifle/model75
	item_type = /obj/item/gun/ballistic/automatic/ar/modular/model75
	lower_cost = CARGO_CRATE_VALUE * 14
	upper_cost = CARGO_CRATE_VALUE * 20
