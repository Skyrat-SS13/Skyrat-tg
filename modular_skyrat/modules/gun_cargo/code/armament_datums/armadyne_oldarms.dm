#define ARMAMENT_CATEGORY_OLDARMS "Armadyne Oldarms"

/datum/armament_entry/cargo_gun/oldarms
	category = ARMAMENT_CATEGORY_OLDARMS
	company_bitflag = COMPANY_OLDARMS

/datum/armament_entry/cargo_gun/oldarms/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/oldarms/pistol/nagant
	item_type =/obj/item/gun/ballistic/revolver/nagant
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/pistol/luger
	item_type = /obj/item/gun/ballistic/automatic/pistol/luger
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN

/datum/armament_entry/cargo_gun/oldarms/smg/mp40
	item_type = /obj/item/gun/ballistic/automatic/mp40
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/smg/uzi
	item_type = /obj/item/gun/ballistic/automatic/mini_uzi
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/smg/ppsh
	item_type = /obj/item/gun/ballistic/automatic/ppsh
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/smg/thompson
	item_type = /obj/item/gun/ballistic/automatic/tommygun
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE

/datum/armament_entry/cargo_gun/oldarms/rifle/vintorez
	item_type = /obj/item/gun/energy/vintorez
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/rifle/stg
	item_type = /obj/item/gun/ballistic/automatic/stg
	cost = 1

/datum/armament_entry/cargo_gun/oldarms/rifle/g11
	item_type = /obj/item/gun/ballistic/automatic/g11
	cost = 1
