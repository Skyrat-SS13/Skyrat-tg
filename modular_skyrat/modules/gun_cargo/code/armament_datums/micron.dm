#define ARMAMENT_CATEGORY_MICRON "Micron Control Systems"

/datum/armament_entry/cargo_gun/micron
	category = ARMAMENT_CATEGORY_MICRON
	company_bitflag = COMPANY_MICRON

/datum/armament_entry/cargo_gun/micron/rifle
	subcategory = ARMAMENT_SUBCATEGORY_ASSAULTRIFLE

/datum/armament_entry/cargo_gun/micron/rifle/mcr
	item_type = /obj/item/gun/microfusion/mcr01
	cost = 1

/datum/armament_entry/cargo_gun/micron/ammo
	subcategory = ARMAMENT_SUBCATEGORY_AMMO
	is_gun = FALSE

/datum/armament_entry/cargo_gun/micron/ammo/cell
	item_type = /obj/item/stock_parts/cell/microfusion
	cost = 1

/datum/armament_entry/cargo_gun/micron/ammo/cell_bulk //NOTE: make bulk like, 2.5x instead of flat 3x price
	item_type = /obj/item/storage/box/ammo_box/microfusion/bagless
	cost = 1

/datum/armament_entry/cargo_gun/micron/ammo/cell_adv
	item_type = /obj/item/stock_parts/cell/microfusion/advanced
	cost = 1

/datum/armament_entry/cargo_gun/micron/ammo/cell_adv_bulk
	item_type = /obj/item/storage/box/ammo_box/microfusion/advanced/bagless
	cost = 1

/datum/armament_entry/cargo_gun/micron/part
	subcategory = ARMAMENT_SUBCATEGORY_GUNPART
	is_gun = FALSE

/datum/armament_entry/cargo_gun/micron/part/grip
	item_type = /obj/item/microfusion_gun_attachment/grip
	cost = 1

/datum/armament_entry/cargo_gun/micron/part/scatter
	item_type = /obj/item/microfusion_gun_attachment/scatter
	cost = 1

/datum/armament_entry/cargo_gun/micron/part/scope
	item_type = /obj/item/microfusion_gun_attachment/scope
	cost = 1

/datum/armament_entry/cargo_gun/micron/part/lance
	item_type = /obj/item/microfusion_gun_attachment/lance
	cost = 1

/datum/armament_entry/cargo_gun/micron/part/tac_load
	item_type = /obj/item/microfusion_cell_attachment/tactical
	cost = 1

/datum/armament_entry/cargo_gun/micron/part/rail
	item_type = /obj/item/microfusion_gun_attachment/rail
	cost = 1


