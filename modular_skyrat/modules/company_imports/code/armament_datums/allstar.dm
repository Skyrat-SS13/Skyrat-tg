/datum/armament_entry/company_import/allstar
	category = COMPANY_NAME_ALLSTAR_ENERGY
	company_bitflag = CARGO_COMPANY_ALLSTAR_ENERGY

/datum/armament_entry/company_import/allstar/basic_energy_weapons
	subcategory = "Basic Energy Weapons"


/datum/armament_entry/company_import/allstar/basic_energy_weapons/mini_egun
	item_type = /obj/item/gun/energy/e_gun/mini
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/allstar/basic_energy_weapons/sc1
	item_type = /obj/item/gun/energy/laser
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 2.5
	stock_mult = 2

/datum/armament_entry/company_import/allstar/basic_energy_weapons/sc2
	item_type = /obj/item/gun/energy/e_gun
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/company_import/allstar/experimental_energy
	subcategory = "Experimental Energy Weapons"
	interest_required = COMPANY_SOME_INTEREST
	restricted = TRUE

/datum/armament_entry/company_import/allstar/experimental_energy/hellfire
	item_type = /obj/item/gun/energy/laser/hellgun
	lower_cost = CARGO_CRATE_VALUE * 4.5
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/company_import/allstar/experimental_energy/ion_carbine
	item_type = /obj/item/gun/energy/ionrifle/carbine
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/company_import/allstar/experimental_energy/xray_gun
	item_type = /obj/item/gun/energy/xray
	lower_cost = CARGO_CRATE_VALUE * 4.5
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/company_import/allstar/experimental_energy/tesla_cannon
	item_type = /obj/item/gun/energy/tesla_cannon
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4

