
/datum/armament_entry/company_import/micron
	category = COMPANY_NAME_MICRON_CONTROL_SYSTEMS
	company_bitflag = COMPANY_MICRON

/datum/armament_entry/company_import/micron/rifle
	subcategory = ARMAMENT_SUBCATEGORY_SPECIAL

/datum/armament_entry/company_import/micron/rifle/mcr
	item_type = /obj/item/gun/microfusion/mcr01
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 14


/datum/armament_entry/company_import/micron/ammo
	subcategory = ARMAMENT_SUBCATEGORY_AMMO

/datum/armament_entry/company_import/micron/ammo/cell
	item_type = /obj/item/stock_parts/cell/microfusion
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 1

/datum/armament_entry/company_import/micron/ammo/cell_bulk
	item_type = /obj/item/storage/box/ammo_box/microfusion/bagless
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/company_import/micron/ammo/cell_adv
	item_type = /obj/item/stock_parts/cell/microfusion/advanced
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/company_import/micron/ammo/cell_adv_bulk
	item_type = /obj/item/storage/box/ammo_box/microfusion/advanced/bagless
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/micron/ammo/cell_blue
	item_type = /obj/item/stock_parts/cell/microfusion/bluespace
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/micron/ammo/cell_blue_bulk
	item_type = /obj/item/storage/box/ammo_box/microfusion/bluespace/bagless
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/company_import/micron/part
	subcategory = ARMAMENT_SUBCATEGORY_GUNPART

/datum/armament_entry/company_import/micron/part/grip
	item_type = /obj/item/microfusion_gun_attachment/grip
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/micron/part/scatter
	item_type = /obj/item/microfusion_gun_attachment/scatter
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/company_import/micron/part/scope
	item_type = /obj/item/microfusion_gun_attachment/scope
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/micron/part/rail
	item_type = /obj/item/microfusion_gun_attachment/rail
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/micron/part/heatsink
	item_type = /obj/item/microfusion_gun_attachment/heatsink
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/company_import/micron/part/lance
	item_type = /obj/item/microfusion_gun_attachment/lance
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/company_import/micron/emitter
	subcategory = ARMAMENT_SUBCATEGORY_EMITTER

/datum/armament_entry/company_import/micron/emitter/enh_emitter
	item_type = /obj/item/microfusion_phase_emitter/enhanced
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/company_import/micron/emitter/adv_emitter
	item_type = /obj/item/microfusion_phase_emitter/advanced
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/company_import/micron/emitter/blue_emitter
	item_type = /obj/item/microfusion_phase_emitter/bluespace
	lower_cost = CARGO_CRATE_VALUE * 7
	upper_cost = CARGO_CRATE_VALUE * 10

/datum/armament_entry/company_import/micron/cell_upgrade
	subcategory = ARMAMENT_SUBCATEGORY_CELL_UPGRADE

/datum/armament_entry/company_import/micron/cell_upgrade/recharge
	item_type = /obj/item/microfusion_cell_attachment/rechargeable
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 6

/datum/armament_entry/company_import/micron/cell_upgrade/stabilize
	item_type = /obj/item/microfusion_cell_attachment/stabiliser
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/micron/cell_upgrade/overcapacity
	item_type = /obj/item/microfusion_cell_attachment/overcapacity
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/company_import/micron/cell_upgrade/selfcharge
	item_type = /obj/item/microfusion_cell_attachment/selfcharging
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 6

/datum/armament_entry/company_import/micron/cell_upgrade/tactical
	item_type = /obj/item/microfusion_cell_attachment/tactical
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/micron/cell_upgrade/reloader
	item_type = /obj/item/microfusion_cell_attachment/reloader
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3


/datum/armament_entry/company_import/microstar/mcr_attachments
	subcategory = "Microfusion Attachment Kits"
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/microstar/mcr_attachments/hellfire
	name = "microfusion hellfire kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/hellfire
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/scatter
	name = "microfusion scatter kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/scatter
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/lance
	name = "microfusion lance kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/lance
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/repeater
	name = "microfusion repeater kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/repeater
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_attachments/tacticool
	name = "microfusion suppressor kit"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_loadout/tacticool
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2
	stock_mult = 2

/datum/armament_entry/company_import/microstar/mcr_upgrades/enhanced_part_kit
	name = "microfusion enhanced parts"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_parts/enhanced
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3
	stock_mult = 3
/datum/armament_entry/company_import/microstar/mcr_upgrades/advanced_part_kit
	name = "microfusion advanced parts"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_parts/advanced
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5.5
	interest_required = COMPANY_SOME_INTEREST
	stock_mult = 3

/datum/armament_entry/company_import/microstar/mcr_upgrades/bluespace_part_kit
	name = "microfusion bluespace parts"
	item_type = /obj/item/storage/secure/briefcase/white/mcr_parts/bluespace
	lower_cost = CARGO_CRATE_VALUE * 5.5
	upper_cost = CARGO_CRATE_VALUE * 7
	interest_required = COMPANY_HIGH_INTEREST
	stock_mult = 3
