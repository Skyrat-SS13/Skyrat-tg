#define ARMAMENT_CATEGORY_BOLT "Bolt Fabrications"

/datum/armament_entry/cargo_gun/bolt
	category = ARMAMENT_CATEGORY_BOLT
	company_bitflag = COMPANY_BOLT

/datum/armament_entry/cargo_gun/bolt/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/bolt/pistol/responder
	item_type = /obj/item/gun/energy/disabler/bolt_disabler
	cost = 1

/datum/armament_entry/cargo_gun/bolt/pistol/m1911
	item_type = /obj/item/gun/ballistic/automatic/pistol/m1911
	cost = 1

/datum/armament_entry/cargo_gun/bolt/pistol/pepperball
	item_type = /obj/item/gun/ballistic/automatic/pistol/pepperball
	cost = 1

/datum/armament_entry/cargo_gun/bolt/pistol/spurchamber
	item_type = /obj/item/gun/ballistic/revolver/zeta
	cost = 1

/datum/armament_entry/cargo_gun/bolt/pistol/spurmaster
	item_type = /obj/item/gun/ballistic/revolver/revolution
	cost = 1

/datum/armament_entry/cargo_gun/bolt/shotgun
	subcategory = ARMAMENT_SUBCATEGORY_SHOTGUN

/datum/armament_entry/cargo_gun/bolt/m23
	item_type = /obj/item/gun/ballistic/shotgun/m23
	cost = 1

/datum/armament_entry/cargo_gun/bolt/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN

/datum/armament_entry/cargo_gun/bolt/smg/pcr
	item_type = /obj/item/gun/energy/pcr
	cost = 1

/datum/armament_entry/cargo_gun/bolt/smg/pitbull
	item_type = /obj/item/gun/energy/pitbull
	cost = 1
