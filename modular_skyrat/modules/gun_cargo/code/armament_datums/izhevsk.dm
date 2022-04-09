#define ARMAMENT_CATEGORY_IZHEVSK "Izhevsk Coalition"

/datum/armament_entry/cargo_gun/izhevsk
	category = ARMAMENT_CATEGORY_IZHEVSK
	company_bitflag = COMPANY_IZHEVSK

/datum/armament_entry/cargo_gun/izhevsk/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/izhevsk/pistol/makarov
	item_type = /obj/item/gun/ballistic/automatic/pistol/makarov
	cost = 1

/datum/armament_entry/cargo_gun/izhevsk/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN

/datum/armament_entry/cargo_gun/izhevsk/smg/surplus
	item_type = /obj/item/gun/ballistic/automatic/plastikov
	cost = 1

/datum/armament_entry/cargo_gun/izhevsk/smg/croon
	item_type = /obj/item/gun/ballistic/automatic/croon
	cost = 1

/datum/armament_entry/cargo_gun/izhevsk/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE

/datum/armament_entry/cargo_gun/izhevsk/rifle/akm
	item_type = /obj/item/gun/ballistic/automatic/akm
	cost = 1

/datum/armament_entry/cargo_gun/izhevsk/rifle/surplus
	item_type = /obj/item/gun/ballistic/automatic/surplus
	cost = 1

/datum/armament_entry/cargo_gun/izhevsk/rifle/mosin
	item_type = /obj/item/gun/ballistic/rifle/boltaction
	cost = 1

/datum/armament_entry/cargo_gun/izhevsk/rifle/revrifle
	item_type = /obj/item/gun/ballistic/revolver/rifle
	cost = 1
