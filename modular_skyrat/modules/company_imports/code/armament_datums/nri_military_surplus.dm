/datum/armament_entry/company_import/nri_surplus
	category = NRI_SURPLUS_COMPANY_NAME
	company_bitflag = CARGO_COMPANY_NRI_SURPLUS

// Various NRI clothing items

/datum/armament_entry/company_import/nri_surplus/clothing
	subcategory = "Clothing Supplies"

/datum/armament_entry/company_import/nri_surplus/clothing/uniform
	item_type = /obj/item/clothing/under/costume/nri
	lower_cost = CARGO_CRATE_VALUE * 1.3
	upper_cost = CARGO_CRATE_VALUE * 1.7
	stock_mult = 2
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/nri_surplus/clothing/boots
	item_type = /obj/item/clothing/shoes/russian
	lower_cost = CARGO_CRATE_VALUE * 0.3
	upper_cost = CARGO_CRATE_VALUE * 1
	stock_mult = 2
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/nri_surplus/clothing/cap
	item_type = /obj/item/clothing/head/soft/nri_larp
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE
	stock_mult = 2
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/nri_surplus/clothing/ushanka
	item_type = /obj/item/clothing/head/costume/ushanka
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE
	stock_mult = 2
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/nri_surplus/clothing/belt
	item_type = /obj/item/storage/belt/military/nri
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/nri_surplus/clothing/backpack
	item_type = /obj/item/storage/backpack/nri
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/nri_surplus/clothing/gas_mask
	item_type = /obj/item/clothing/mask/gas/hecu2
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/nri_surplus/clothing/helmet
	item_type = /obj/item/clothing/head/helmet/rus_helmet/nri
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = COMPANY_HIGH_INTEREST

/datum/armament_entry/company_import/nri_surplus/clothing/vest
	item_type = /obj/item/clothing/suit/armor/vest/russian/nri
	lower_cost = CARGO_CRATE_VALUE * 2.5
	upper_cost = CARGO_CRATE_VALUE * 3.5
	interest_required = COMPANY_HIGH_INTEREST

// Random surplus store tier stuff, flags, old rations, multitools you'll never use, so on

/datum/armament_entry/company_import/nri_surplus/misc
	subcategory = "Miscellaneous Supplies"

/datum/armament_entry/company_import/nri_surplus/misc/flares
	item_type = /obj/item/storage/box/nri_flares
	lower_cost = CARGO_CRATE_VALUE * 0.1
	upper_cost = CARGO_CRATE_VALUE * 0.4
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/nri_surplus/misc/binoculars
	item_type = /obj/item/binoculars
	lower_cost = CARGO_CRATE_VALUE * 0.3
	upper_cost = CARGO_CRATE_VALUE * 0.7
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/nri_surplus/misc/screwdriver_pen
	item_type = /obj/item/pen/screwdriver
	lower_cost = CARGO_CRATE_VALUE * 0.3
	upper_cost = CARGO_CRATE_VALUE * 0.7
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/nri_surplus/misc/trench_tool
	item_type = /obj/item/trench_tool
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE

/datum/armament_entry/company_import/nri_surplus/misc/rations
	item_type = /obj/item/storage/box/nri_rations
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/nri_surplus/misc/nri_flag
	item_type = /obj/item/sign/flag/nri
	lower_cost = CARGO_CRATE_VALUE * 1.2
	upper_cost = CARGO_CRATE_VALUE * 2
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/nri_surplus/firearm
	subcategory = "Firearms"

/datum/armament_entry/company_import/nri_surplus/firearm/makarov
	item_type = /obj/item/gun/ballistic/automatic/pistol/makarov
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 6
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_BIG

/datum/armament_entry/company_import/nri_surplus/firearm/sportiv
	item_type = /obj/item/gun/ballistic/rifle/boltaction
	lower_cost = CARGO_CRATE_VALUE * 8
	upper_cost = CARGO_CRATE_VALUE * 15
	interest_required = COMPANY_HIGH_INTEREST
	restricted = TRUE
	interest_addition = COMPANY_INTEREST_GAIN_BIG

/datum/armament_entry/company_import/nri_surplus/firearm/civilian_akm
	item_type = /obj/item/gun/ballistic/automatic/akm/civvie
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 17
	interest_required = COMPANY_HIGH_INTEREST
	restricted = TRUE
	interest_addition = COMPANY_INTEREST_GAIN_BIG
