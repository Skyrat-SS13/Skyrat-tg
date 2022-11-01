#define MODULE_CHEAP_LOWER 1
#define MODULE_CHEAP_UPPER 1.5

#define MODULE_MID_LOWER 2
#define MODULE_MID_UPPER 3

#define MODULE_PRICEY_LOWER 4
#define MODULE_PRICEY_UPPER 6

#define MODULE_HELLA_LOWER 8
#define MODULE_HELLA_UPPER 12

#define MODULE_ANOMALY_LOWER 20
#define MODULE_ANOMALY_UPPER 40

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

/datum/armament_entry/cargo_gun/nakamura/protection_modules/accretion
	item_type = /obj/item/mod/module/ash_accretion
	lower_cost = CARGO_CRATE_VALUE * MODULE_HELLA_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_HELLA_UPPER
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
	subcategory = "MOD Utility Modules"

/datum/armament_entry/cargo_gun/nakamura/utility_modules/flashlight
	item_type = /obj/item/mod/module/flashlight
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER
	stock_mult = 2

/datum/armament_entry/cargo_gun/nakamura/utility_modules/regulator
	item_type = /obj/item/mod/module/thermal_regulator
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

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/atrocinator
	item_type = /obj/item/mod/module/atrocinator
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER

/datum/armament_entry/cargo_gun/nakamura/mobility_modules/super_jetpack
	item_type = /obj/item/mod/module/jetpack/advanced
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER
	interest_required = HIGH_INTEREST

// Novelty modules, goofy stuff that's rare/unprintable, but doesn't fit in any of the above categories

/datum/armament_entry/cargo_gun/nakamura/novelty_modules
	subcategory = "MOD Novelty Modules"

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/waddle
	item_type = /obj/item/mod/module/waddle
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/bike_horn
	item_type = /obj/item/mod/module/bikehorn
	lower_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_CHEAP_UPPER

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/microwave_beam
	item_type = /obj/item/mod/module/microwave_beam
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/tanner
	item_type = /obj/item/mod/module/tanner
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/hat_stabilizer
	item_type = /obj/item/mod/module/hat_stabilizer
	lower_cost = CARGO_CRATE_VALUE * MODULE_MID_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_MID_UPPER
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/chameleon
	item_type = /obj/item/mod/module/chameleon
	lower_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_PRICEY_UPPER
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/kinesis
	item_type = /obj/item/mod/module/anomaly_locked/kinesis/prebuilt
	lower_cost = CARGO_CRATE_VALUE * MODULE_ANOMALY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_ANOMALY_UPPER
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/antigrav
	item_type = /obj/item/mod/module/anomaly_locked/antigrav/prebuilt
	lower_cost = CARGO_CRATE_VALUE * MODULE_ANOMALY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_ANOMALY_UPPER
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/nakamura/novelty_modules/teleporter
	item_type = /obj/item/mod/module/anomaly_locked/teleporter/prebuilt
	lower_cost = CARGO_CRATE_VALUE * MODULE_ANOMALY_LOWER
	upper_cost = CARGO_CRATE_VALUE * MODULE_ANOMALY_UPPER
	interest_required = HIGH_INTEREST

#undef MODULE_CHEAP_LOWER
#undef MODULE_CHEAP_UPPER

#undef MODULE_MID_LOWER
#undef MODULE_MID_UPPER

#undef MODULE_PRICEY_LOWER
#undef MODULE_PRICEY_UPPER

#undef MODULE_HELLA_LOWER
#undef MODULE_HELLA_UPPER

#undef MODULE_ANOMALY_LOWER
#undef MODULE_ANOMALY_UPPER
