#define MODULE_CHEAP_LOWER 1
#define MODULE_CHEAP_UPPER 1.5

#define MODULE_MID_LOWER 2
#define MODULE_MID_UPPER 3

#define MODULE_PRICEY_LOWER 4
#define MODULE_PRICEY_UPPER 6

#define MODULE_HELLA_LOWER 8
#define MODULE_HELLA_UPPER 12

/datum/armament_entry/cargo_gun/nakamura
	category = "Nakamura Engineering"

// MOD cores

/datum/armament_entry/cargo_gun/nakamura/core
	subcategory = "MOD Core Modules"

/datum/armament_entry/cargo_gun/nakamura/core/standard
	item_type = /obj/item/mod/core/standard
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 2
	stock_mult = 2

/datum/armament_entry/cargo_gun/nakamura/core/plasma
	item_type = /obj/item/mod/core/plasma
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2.5

/datum/armament_entry/cargo_gun/nakamura/core/ethereal
	item_type = /obj/item/mod/core/ethereal
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2.5

// MOD plating

/datum/armament_entry/cargo_gun/nakamura/plating
	subcategory = "MOD External Plating"

/datum/armament_entry/cargo_gun/nakamura/plating/standard
	item_type = /obj/item/mod/construction/plating
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	stock_mult = 2

/datum/armament_entry/cargo_gun/nakamura/plating/medical
	item_type = /obj/item/mod/construction/plating/medical
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/cargo_gun/nakamura/plating/engineering
	item_type = /obj/item/mod/construction/plating/engineering
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/cargo_gun/nakamura/plating/atmospherics
	item_type = /obj/item/mod/construction/plating/atmospheric
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/plating/security
	item_type = /obj/item/mod/construction/plating/security
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_required = PASSED_INTEREST
	restricted = TRUE

/datum/armament_entry/cargo_gun/nakamura/plating/clown
	item_type = /obj/item/mod/construction/plating/cosmohonk
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 6
	interest_required = HIGH_INTEREST

// MOD modules

// Protection, so shielding and whatnot

/datum/armament_entry/cargo_gun/nakamura/protection_modules
	subcategory = "MOD Protection Modules"

/datum/armament_entry/cargo_gun/nakamura/protection_modules/welding
	item_type = /obj/item/mod/module/welding
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER
	stock_mult = 2

/datum/armament_entry/cargo_gun/nakamura/protection_modules/longfall
	item_type = /obj/item/mod/module/longfall
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/protection_modules/rad_protection
	item_type = /obj/item/mod/module/rad_protection
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/protection_modules/emp_shield
	item_type = /obj/item/mod/module/emp_shield
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/protection_modules/advanced_emp_shield
	item_type = /obj/item/mod/module/emp_shield/advanced
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/nakamura/protection_modules/armor_plates
	item_type = /obj/item/mod/module/armor_booster/retractplates
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER
	interest_required = HIGH_INTEREST
	restricted = TRUE

/datum/armament_entry/cargo_gun/nakamura/protection_modules/energy_shield
	item_type = /obj/item/mod/module/energy_shield
	lower_cost = CARGO_CRATE_VALUE * MODULE_HELLA_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_HELLA_UPPER
	interest_required = HIGH_INTEREST
	restricted = TRUE

// Utility modules, general purpose stuff that really anyone might want

/datum/armament_entry/cargo_gun/nakamura/utility_modules
	subcategory = "MOD Protection Modules"

/datum/armament_entry/cargo_gun/nakamura/utility_modules/flashlight
	item_type = /obj/item/mod/module/flashlight
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER
	stock_mult = 2

/datum/armament_entry/cargo_gun/nakamura/utility_modules/mouthhole
	item_type = /obj/item/mod/module/mouthhole
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/utility_modules/signlang
	item_type = /obj/item/mod/module/signlang_radio
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/utility_modules/plasma_stabilizer
	item_type = /obj/item/mod/module/plasma_stabilizer
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/utility_modules/basic_storage
	item_type = /obj/item/mod/module/storage
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER
	stock_mult = 2

/datum/armament_entry/cargo_gun/nakamura/utility_modules/expanded_storage
	item_type = /obj/item/mod/module/storage/large_capacity
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/utility_modules/retract_plates
	item_type = /obj/item/mod/module/plate_compression
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/utility_modules/magnetic_deploy
	item_type = /obj/item/mod/module/springlock/contractor
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER
	interest_required = HIGH_INTEREST

// Mobility modules, jetpacks and stuff

/datum/armament_entry/cargo_gun/nakamura/mobility_modules
	subcategory = "MOD Mobility Modules"

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/tether
	item_type = /obj/item/mod/module/tether
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/magboot
	item_type = /obj/item/mod/module/magboot
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/jetpack
	item_type = /obj/item/mod/module/jetpack
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/pathfinder
	item_type = /obj/item/mod/module/pathfinder
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/disposals
	item_type = /obj/item/mod/module/disposal_connector
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/sphere
	item_type = /obj/item/mod/module/sphere_transform
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/super_jetpack
	item_type = /obj/item/mod/module/jetpack/advanced
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER
	interest_required = HIGH_INTEREST
