/datum/armament_entry/company_import/allstar
	category = COMPANY_NAME_ALLSTAR_ENERGY
	company_bitflag = CARGO_COMPANY_ALLSTAR_ENERGY

// Basic lethal/disabler beam weapons, includes the base mcr

/datum/armament_entry/company_import/allstar/basic_energy_weapons
	subcategory = "Basic Energy Smallarms"
	restricted = TRUE

/datum/armament_entry/company_import/allstar/basic_energy_weapons/disabler
	item_type = /obj/item/gun/energy/disabler
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/allstar/basic_energy_weapons/disabler_smg
	item_type = /obj/item/gun/energy/disabler/smg
	cost = PAYCHECK_CREW * 7 // slightly more expensive due to ease of use/full auto

/datum/armament_entry/company_import/allstar/basic_energy_weapons/mini_egun
	item_type = /obj/item/gun/energy/e_gun/mini
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/allstar/lethal_sidearm/energy_holster
	item_type = /obj/item/storage/belt/holster/energy/thermal
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/allstar/basic_energy_long_weapons
	subcategory = "Basic Energy Longarms"

/datum/armament_entry/company_import/allstar/basic_energy_long_weapons/laser
	item_type = /obj/item/gun/energy/laser
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/allstar/basic_energy_long_weapons/laser_carbine
	item_type = /obj/item/gun/energy/laser/carbine
	cost = PAYCHECK_CREW * 7 // slightly more expensive due to ease of use/full auto

/datum/armament_entry/company_import/allstar/basic_energy_long_weapons/egun
	item_type = /obj/item/gun/energy/e_gun
	cost = PAYCHECK_COMMAND * 4
/*
/datum/armament_entry/company_import/allstar/experimental_energy
	subcategory = "Experimental Energy Weapons"
	cost = PAYCHECK_COMMAND * 6
	restricted = TRUE

/datum/armament_entry/company_import/allstar/experimental_energy/hellfire
	item_type = /obj/item/gun/energy/laser/hellgun

/datum/armament_entry/company_import/allstar/experimental_energy/ion_carbine
	item_type = /obj/item/gun/energy/ionrifle/carbine

/datum/armament_entry/company_import/allstar/experimental_energy/xray_gun
	item_type = /obj/item/gun/energy/xray

/datum/armament_entry/company_import/allstar/experimental_energy/tesla_cannon
	item_type = /obj/item/gun/energy/tesla_cannon
*/
