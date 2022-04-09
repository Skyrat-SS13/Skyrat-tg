#define ARMAMENT_CATEGORY_SCARBOROUGH "Scarborough Arms"

/datum/armament_entry/cargo_gun/scarborough
	category = ARMAMENT_CATEGORY_SCARBOROUGH
	company_bitflag = COMPANY_SCARBOROUGH

/datum/armament_entry/cargo_gun/scarborough/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/cargo_gun/scarborough/pistol/makarov
	item_type = /obj/item/gun/ballistic/automatic/pistol
	cost = 1

/datum/armament_entry/cargo_gun/scarborough/pistol/aps
	item_type = /obj/item/gun/ballistic/automatic/pistol/aps
	cost = 1

/datum/armament_entry/cargo_gun/scarborough/shotgun
	subcategory = ARMAMENT_SUBCATEGORY_SHOTGUN

/datum/armament_entry/cargo_gun/scarborough/shotgun/bulldog
	item_type = /obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	cost = 1

/datum/armament_entry/cargo_gun/scarborough/smg
	subcategory = ARMAMENT_SUBCATEGORY_SUBMACHINEGUN

/datum/armament_entry/cargo_gun/scarborough/smg/c20r
	item_type = /obj/item/gun/ballistic/automatic/c20r/unrestricted
	cost = 1

/datum/armament_entry/cargo_gun/scarborough/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE

/datum/armament_entry/cargo_gun/scarborough/rifle/m90gl
	item_type = /obj/item/gun/ballistic/automatic/m90/unrestricted
	cost = 1

/datum/armament_entry/cargo_gun/scarborough/part
	subcategory = ARMAMENT_SUBCATEGORY_GUNPART

/datum/armament_entry/cargo_gun/scarborough/part/suppressor
	item_type = /obj/item/suppressor
	cost = 1
