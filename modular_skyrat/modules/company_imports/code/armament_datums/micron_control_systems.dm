
/datum/armament_entry/company_import/micron
	category = COMPANY_NAME_MICRON_CONTROL_SYSTEMS
	company_bitflag = CARGO_COMPANY_MICRON

/datum/armament_entry/company_import/micron/rifle
	subcategory = ARMAMENT_SUBCATEGORY_SPECIAL

/*
/datum/armament_entry/company_import/micron/rifle/mcr
	item_type = /obj/item/gun/microfusion/mcr01
	cost = PAYCHECK_COMMAND * 4

*/

/datum/armament_entry/company_import/micron/ammo
	subcategory = ARMAMENT_SUBCATEGORY_AMMO

/datum/armament_entry/company_import/micron/ammo/cell
	item_type = /obj/item/stock_parts/power_store/cell/microfusion
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/micron/ammo/cell_bulk
	item_type = /obj/item/storage/box/ammo_box/microfusion/bagless
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/micron/ammo/cell_adv
	item_type = /obj/item/stock_parts/power_store/cell/microfusion/advanced
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/micron/ammo/cell_adv_bulk
	item_type = /obj/item/storage/box/ammo_box/microfusion/advanced/bagless
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/micron/ammo/cell_blue
	item_type = /obj/item/stock_parts/power_store/cell/microfusion/bluespace
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/micron/ammo/cell_blue_bulk
	item_type = /obj/item/storage/box/ammo_box/microfusion/bluespace/bagless
	cost = PAYCHECK_CREW * 4

/datum/armament_entry/company_import/micron/part
	subcategory = ARMAMENT_SUBCATEGORY_GUNPART

/datum/armament_entry/company_import/micron/part/grip
	item_type = /obj/item/microfusion_gun_attachment/grip
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/micron/part/scatter
	item_type = /obj/item/microfusion_gun_attachment/barrel/scatter
	cost = PAYCHECK_CREW * 4

/datum/armament_entry/company_import/micron/part/scope
	item_type = /obj/item/microfusion_gun_attachment/scope
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/micron/part/rail
	item_type = /obj/item/microfusion_gun_attachment/rail
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/micron/part/heatsink
	item_type = /obj/item/microfusion_gun_attachment/heatsink
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/micron/part/lance
	item_type = /obj/item/microfusion_gun_attachment/barrel/lance
	cost = PAYCHECK_CREW * 4

/datum/armament_entry/company_import/micron/emitter
	subcategory = ARMAMENT_SUBCATEGORY_EMITTER

/datum/armament_entry/company_import/micron/emitter/enh_emitter
	item_type = /obj/item/microfusion_phase_emitter/enhanced
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/micron/emitter/adv_emitter
	item_type = /obj/item/microfusion_phase_emitter/advanced
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/micron/emitter/blue_emitter
	item_type = /obj/item/microfusion_phase_emitter/bluespace
	cost = PAYCHECK_CREW * 7

/datum/armament_entry/company_import/micron/cell_upgrade
	subcategory = ARMAMENT_SUBCATEGORY_CELL_UPGRADE

/datum/armament_entry/company_import/micron/cell_upgrade/recharge
	item_type = /obj/item/microfusion_cell_attachment/rechargeable
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/micron/cell_upgrade/stabilize
	item_type = /obj/item/microfusion_cell_attachment/stabiliser
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/micron/cell_upgrade/overcapacity
	item_type = /obj/item/microfusion_cell_attachment/overcapacity
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/micron/cell_upgrade/selfcharge
	item_type = /obj/item/microfusion_cell_attachment/selfcharging
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/micron/cell_upgrade/tactical
	item_type = /obj/item/microfusion_cell_attachment/tactical
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/micron/cell_upgrade/reloader
	item_type = /obj/item/microfusion_cell_attachment/reloader
	cost = PAYCHECK_CREW * 2


/datum/armament_entry/company_import/micron/mcr_attachments
	subcategory = "Microfusion Attachment Kits"

/datum/armament_entry/company_import/micron/mcr_attachments/hellfire
	name = "microfusion hellfire kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/hellfire
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/micron/mcr_attachments/scatter
	name = "microfusion scatter kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/scatter
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/micron/mcr_attachments/lance
	name = "microfusion lance kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/lance
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/micron/mcr_attachments/repeater
	name = "microfusion repeater kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/repeater
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/micron/mcr_attachments/tacticool
	name = "microfusion suppressor kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/tacticool
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/micron/mcr_upgrades/enhanced_part_kit
	name = "microfusion enhanced parts"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_parts/enhanced
	cost = PAYCHECK_CREW * 1.5


/datum/armament_entry/company_import/micron/mcr_upgrades/advanced_part_kit
	name = "microfusion advanced parts"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_parts/advanced
	cost = PAYCHECK_CREW * 3


/datum/armament_entry/company_import/micron/mcr_upgrades/bluespace_part_kit
	name = "microfusion bluespace parts"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_parts/bluespace
	cost = PAYCHECK_CREW * 5.5

