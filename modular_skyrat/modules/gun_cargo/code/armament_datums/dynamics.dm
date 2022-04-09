#define ARMAMENT_CATEGORY_DYNAMICS "Armament Dynamics Inc."

/datum/armament_entry/cargo_gun/dynamics
	category = ARMAMENT_CATEGORY_DYNAMICS
	company_bitflag = COMPANY_DYNAMICS
	is_gun = FALSE
	stock_mult = 2 //To compensate for their interest being fairly low most of the time

/datum/armament_entry/cargo_gun/dynamics/ammo
	subcategory = ARMAMENT_SUBCATEGORY_AMMO

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm
	item_type = /obj/item/ammo_box/c9mm
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm_ap
	item_type = /obj/item/ammo_box/c9mm/ap
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm_hp
	item_type = /obj/item/ammo_box/c9mm/hp
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm_in
	item_type = /obj/item/ammo_box/c9mm/fire
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm
	item_type = /obj/item/ammo_box/c10mm
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm_ap
	item_type = /obj/item/ammo_box/c10mm/ap
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm_hp
	item_type = /obj/item/ammo_box/c10mm/hp
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm_in
	item_type = /obj/item/ammo_box/c10mm/fire
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c12ga
	item_type = /obj/item/storage/box/lethalshot
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c12ga_rub
	item_type = /obj/item/storage/box/rubbershot
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c12ga_bean
	item_type = /obj/item/storage/box/beanbag
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c46mm
	item_type = /obj/item/ammo_box/c46x30mm
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c46mm_ap
	item_type = /obj/item/ammo_box/c46x30mm/ap
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c46mm_rub
	item_type = /obj/item/ammo_box/c46x30mm/rubber
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c32
	item_type = /obj/item/ammo_box/c32
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c32_ap
	item_type = /obj/item/ammo_box/c32/ap
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c32_in
	item_type = /obj/item/ammo_box/c32/fire
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c32_rub
	item_type = /obj/item/ammo_box/c32/rubber
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c38
	item_type = /obj/item/ammo_box/c38
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c38_dum
	item_type = /obj/item/ammo_box/c38/dumdum
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c38_hot
	item_type = /obj/item/ammo_box/c38/hotshot
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c38_ice
	item_type = /obj/item/ammo_box/c38/iceblox
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c38_mat
	item_type = /obj/item/ammo_box/c38/match
	cost = 1

/datum/armament_entry/cargo_gun/dynamics/ammo/c38_trc
	item_type = /obj/item/ammo_box/c38/trac
	cost = 1

/*
/datum/armament_entry/cargo_gun/dynamics/misc
	subcategory = ARMAMENT_SUBCATEGORY_
	is_gun = FALSE
*/

/datum/armament_entry/cargo_gun/dynamics/bandolier
	item_type = /obj/item/storage/belt/bandolier
	cost = 1
