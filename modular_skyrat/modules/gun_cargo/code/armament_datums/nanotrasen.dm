#define ARMAMENT_CATEGORY_NANOTRASEN "Nanotrasen Armories"

/datum/armament_entry/cargo_gun/nanotrasen
	category = ARMAMENT_CATEGORY_NANOTRASEN
	company_bitflag = COMPANY_NANOTRASEN

/datum/armament_entry/cargo_gun/nanotrasen/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/nanotrasen/pistol/thermal_holster
	item_type = /obj/item/storage/belt/holster/thermal
	cost = 1

/datum/armament_entry/cargo_gun/nanotrasen/shotgun
	subcategory = ARMAMENT_SUBCATEGORY_SHOTGUN

/datum/armament_entry/cargo_gun/nanotrasen/shotgun/riot
	item_type = /obj/item/gun/ballistic/shotgun/riot
	cost = 1

/datum/armament_entry/cargo_gun/nanotrasen/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN

/datum/armament_entry/cargo_gun/nanotrasen/smg/saber
	item_type = /obj/item/gun/ballistic/automatic/proto
	cost = 1

/datum/armament_entry/cargo_gun/nanotrasen/smg/cmg
	item_type = /obj/item/gun/ballistic/automatic/c20r/unrestricted/cmg1
	cost = 1

/datum/armament_entry/cargo_gun/nanotrasen/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE

/datum/armament_entry/cargo_gun/nanotrasen/rifle/wtrifle
	item_type = /obj/item/gun/ballistic/automatic/wt550
	cost = 1

/datum/armament_entry/cargo_gun/nanotrasen/rifle/boarder
	item_type = /obj/item/gun/ballistic/automatic/ar
	cost = 1

/datum/armament_entry/cargo_gun/nanotrasen/rifle/model75
	item_type = /obj/item/gun/ballistic/automatic/ar/modular/model75
	cost = 1
