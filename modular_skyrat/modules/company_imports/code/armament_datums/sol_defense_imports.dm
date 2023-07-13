/datum/armament_entry/company_import/sol_defense_imports
	category = SOL_DEFENSE_NAME
	company_bitflag = CARGO_COMPANY_SOL_DEFENSE

// Basic armor vests

/datum/armament_entry/company_import/sol_defense_imports/armor
	subcategory = "Body Armor"

/datum/armament_entry/company_import/sol_defense_imports/armor/slim_vest
	name = "type I vest - slim"
	item_type = /obj/item/clothing/suit/armor/vest
	lower_cost = PAYCHECK_CREW * 1.75
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

/datum/armament_entry/company_import/sol_defense_imports/armor/normal_vest
	name = "type I vest - normal"
	item_type = /obj/item/clothing/suit/armor/vest/alt
	lower_cost = PAYCHECK_CREW * 1.75
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

// Sidearms

/datum/armament_entry/company_import/sol_defense_imports/sidearms
	subcategory = "Small Arms"
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/sol_defense_imports/sidearms/pepperball
	item_type = /obj/item/gun/ballistic/automatic/pistol/pepperball
	lower_cost = PAYCHECK_CREW * 3
	upper_cost = PAYCHECK_CREW * 4
	stock_mult = 3

/datum/armament_entry/company_import/sol_defense_imports/sidearms/detective_revolver
	item_type = /obj/item/gun/ballistic/revolver/c38/detective
	lower_cost = PAYCHECK_CREW * 8
	upper_cost = PAYCHECK_CREW * 10

/datum/armament_entry/company_import/sol_defense_imports/sidearms/sol_pocket_pistol
	item_type = /obj/item/gun/ballistic/automatic/pistol/luna/pocket
	lower_cost = PAYCHECK_CREW * 10
	upper_cost = PAYCHECK_CREW * 14

/datum/armament_entry/company_import/sol_defense_imports/sidearms/energy_holster
	item_type = /obj/item/storage/belt/holster/energy/thermal
	lower_cost = PAYCHECK_CREW * 16
	upper_cost = PAYCHECK_CREW * 20

// Anything that's not a pistol, requires some company interest

/datum/armament_entry/company_import/sol_defense_imports/longarm
	subcategory = "Long Arms"
	interest_addition = COMPANY_INTEREST_GAIN_BIG
	interest_required = COMPANY_SOME_INTEREST
	restricted = TRUE

/datum/armament_entry/company_import/sol_defense_imports/longarm/sol_pdw
	item_type = /obj/item/gun/ballistic/automatic/luna_pdw
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 6

/datum/armament_entry/company_import/sol_defense_imports/longarm/cmg
	item_type = /obj/item/gun/ballistic/automatic/cmg
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 6

/datum/armament_entry/company_import/sol_defense_imports/longarm/riot_shotgun
	item_type = /obj/item/gun/ballistic/shotgun/riot
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/company_import/sol_defense_imports/longarm/sol_sport_shooter
	item_type = /obj/item/gun/ballistic/automatic/luna_sport_shooter
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 7
