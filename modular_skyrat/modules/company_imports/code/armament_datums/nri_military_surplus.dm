/datum/armament_entry/cargo_gun/nri_surplus
	category = "Nizhny Company Military Surplus"

// Various NRI clothing items

/datum/armament_entry/cargo_gun/nri_surplus/clothing
	subcategory = "Clothing Supplies"

/datum/armament_entry/cargo_gun/nri_surplus/clothing/uniform
	item_type = /obj/item/clothing/under/costume/nri
	lower_cost = CARGO_CRATE_VALUE * 1.3
	upper_cost = CARGO_CRATE_VALUE * 1.7
	stock_mult = 2

/datum/armament_entry/cargo_gun/nri_surplus/clothing/boots
	item_type = /obj/item/clothing/shoes/russian
	lower_cost = CARGO_CRATE_VALUE * 0.3
	upper_cost = CARGO_CRATE_VALUE * 1
	stock_mult = 2

/datum/armament_entry/cargo_gun/nri_surplus/clothing/boots
	item_type = /obj/item/clothing/shoes/russian
	lower_cost = CARGO_CRATE_VALUE * 0.3
	upper_cost = CARGO_CRATE_VALUE
	stock_mult = 2

/datum/armament_entry/cargo_gun/nri_surplus/clothing/cap
	item_type = /obj/item/clothing/head/soft/nri_larp
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE
	stock_mult = 2

/datum/armament_entry/cargo_gun/nri_surplus/clothing/ushanka
	item_type = /obj/item/clothing/head/costume/ushanka
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE
	stock_mult = 2

/datum/armament_entry/cargo_gun/nri_surplus/clothing/belt
	item_type = /obj/item/storage/belt/military/nri
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nri_surplus/clothing/backpack
	item_type = /obj/item/storage/backpack/nri
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nri_surplus/clothing/helmet
	item_type = /obj/item/clothing/head/helmet/rus_helmet
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/nri_surplus/clothing/vest
	item_type = /obj/item/clothing/suit/armor/vest/russian/nri
	lower_cost = CARGO_CRATE_VALUE * 2.5
	upper_cost = CARGO_CRATE_VALUE * 3.5
	interest_required = HIGH_INTEREST

// Random surplus store tier stuff, flags, old rations, multitools you'll never use, so on

/datum/armament_entry/cargo_gun/nri_surplus/misc
	subcategory = "Miscellaneous Supplies"

/datum/armament_entry/cargo_gun/nri_surplus/misc/flare
	item_type = /obj/item/flashlight/flare
	lower_cost = CARGO_CRATE_VALUE * 0.1
	upper_cost = CARGO_CRATE_VALUE * 0.4

/datum/armament_entry/cargo_gun/nri_surplus/misc/screwdriver_pen
	item_type = /obj/item/pen/screwdriver
	lower_cost = CARGO_CRATE_VALUE * 0.3
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/nri_surplus/misc/trench_tool
	item_type = /obj/item/trench_tool
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE

/datum/armament_entry/cargo_gun/nri_surplus/misc/rations
	item_type = /obj/item/storage/box/nri_rations
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nri_surplus/misc/nri_flag
	item_type = /obj/item/sign/flag/nri
	lower_cost = CARGO_CRATE_VALUE * 1.2
	upper_cost = CARGO_CRATE_VALUE * 2
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/nri_surplus/firearm
	subcategory = "Firearms"
