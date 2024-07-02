/datum/armament_entry/company_import/microstar

// Basic lethal/disabler beam weapons, includes the base mcr

/datum/armament_entry/company_import/microstar/basic_energy_weapons
	subcategory = "Basic Energy Smallarms"

/datum/armament_entry/company_import/microstar/basic_energy_weapons/mini_egun
	item_type = /obj/item/gun/energy/e_gun/mini
	cost = PAYCHECK_CREW * 4

/datum/armament_entry/company_import/microstar/basic_energy_long_weapons
	subcategory = "Basic Energy Longarms"

/datum/armament_entry/company_import/microstar/basic_energy_long_weapons/basic_mcr
	item_type = /obj/item/gun/microfusion/mcr01
	cost = PAYCHECK_COMMAND * 4

// More expensive, unique energy weapons
/datum/armament_entry/company_import/microstar/experimental_energy
	subcategory = "Experimental Energy Weapons"
	cost = PAYCHECK_COMMAND * 6
	restricted = TRUE

/datum/armament_entry/company_import/microstar/experimental_energy/hellfire
	item_type = /obj/item/gun/energy/laser/hellgun
/*
/datum/armament_entry/company_import/microstar/experimental_energy/ion_carbine
	item_type = /obj/item/gun/energy/ionrifle/carbine
*/
/datum/armament_entry/company_import/microstar/experimental_energy/xray_gun
	item_type = /obj/item/gun/energy/xray
/*
/datum/armament_entry/company_import/microstar/experimental_energy/tesla_cannon
	item_type = /obj/item/gun/energy/tesla_cannon
*/
// Preset 'loadout' kits built around a barrel attachment

/datum/armament_entry/company_import/microstar/mcr_attachments
	subcategory = "Microfusion Attachment Kits"
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/microstar/mcr_attachments/hellfire
	name = "microfusion hellfire kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/hellfire

/datum/armament_entry/company_import/microstar/mcr_attachments/scatter
	name = "microfusion scatter kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/scatter

/datum/armament_entry/company_import/microstar/mcr_attachments/lance
	name = "microfusion lance kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/lance

/datum/armament_entry/company_import/microstar/mcr_attachments/repeater
	name = "microfusion repeater kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/repeater

/datum/armament_entry/company_import/microstar/mcr_attachments/tacticool
	name = "microfusion suppressor kit"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_loadout/tacticool

// Improved phase emitters, cells, and cell attachments

/datum/armament_entry/company_import/microstar/mcr_upgrades
	subcategory = "Microfusion Upgrade Kits"

/datum/armament_entry/company_import/microstar/mcr_upgrades/stabilizer
	item_type = /obj/item/microfusion_cell_attachment/stabiliser
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/microstar/mcr_upgrades/enhanced_part_kit
	name = "microfusion enhanced parts"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_parts/enhanced
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/microstar/mcr_upgrades/capacity_booster
	item_type = /obj/item/microfusion_cell_attachment/overcapacity
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/microstar/mcr_upgrades/advanced_part_kit
	name = "microfusion advanced parts"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_parts/advanced
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/microstar/mcr_upgrades/selfcharge
	item_type = /obj/item/microfusion_cell_attachment/selfcharging
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/microstar/mcr_upgrades/bluespace_part_kit
	name = "microfusion bluespace parts"
	item_type = /obj/item/storage/briefcase/secure/white/mcr_parts/bluespace
	cost = PAYCHECK_COMMAND * 6
