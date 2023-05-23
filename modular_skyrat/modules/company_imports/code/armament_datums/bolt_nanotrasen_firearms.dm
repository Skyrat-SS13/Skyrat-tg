/datum/armament_entry/company_import/nanotrasen_bolt_weapons
	category = BOLT_NANOTRASEN_DEFENSE_NAME
	company_bitflag = CARGO_COMPANY_BOLT_NANOTRASEN

// Basic armor vests

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/armor
	subcategory = "Light Body Armor"

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/armor/slim_vest
	name = "type I vest - slim"
	item_type = /obj/item/clothing/suit/armor/vest
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	stock_mult = 2

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/armor/normal_vest
	name = "type I vest - normal"
	item_type = /obj/item/clothing/suit/armor/vest/alt
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	stock_mult = 2

// Fully non-lethal weapons

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/nonlethal
	subcategory = "Non-Lethal Weapons"
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/nonlethal/responder
	item_type = /obj/item/gun/energy/disabler/bolt_disabler
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4
	stock_mult = 2

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/nonlethal/pepperball
	item_type = /obj/item/gun/ballistic/automatic/pistol/pepperball
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4
	stock_mult = 2

// Lethal pistols, requires some company interest first

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm
	subcategory = "Lethal Sidearms"
	interest_addition = COMPANY_INTEREST_GAIN_BIG
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm/detective_revolver
	item_type = /obj/item/gun/ballistic/revolver/c38/detective
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 6

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm/m1911
	item_type = /obj/item/gun/ballistic/automatic/pistol/m1911
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm/energy_holster
	item_type = /obj/item/storage/belt/holster/energy/thermal
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 9

// Lethal anything that's not a pistol, requires high company interest

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm
	subcategory = "Lethal Longarms"
	interest_addition = COMPANY_INTEREST_GAIN_BIG
	interest_required = COMPANY_HIGH_INTEREST
	restricted = TRUE

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/riot_shotgun
	item_type = /obj/item/gun/ballistic/shotgun/riot
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 15

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/wt550
	item_type = /obj/item/gun/ballistic/automatic/wt550
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 15

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/cmg
	item_type = /obj/item/gun/ballistic/automatic/cmg
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 15
