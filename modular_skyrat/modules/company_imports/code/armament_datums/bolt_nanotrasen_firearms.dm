/datum/armament_entry/company_import/nanotrasen_bolt_weapons
	category = BOLT_NANOTRASEN_DEFENSE_NAME
	company_bitflag = CARGO_COMPANY_BOLT_NANOTRASEN

// Basic armor vests

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/armor
	subcategory = "Light Body Armor"

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/armor/slim_vest
	name = "type I vest - slim"
	item_type = /obj/item/clothing/suit/armor/vest
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/armor/normal_vest
	name = "type I vest - normal"
	item_type = /obj/item/clothing/suit/armor/vest/alt
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm
	subcategory = "Sidearms"

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm/pepperball
	item_type = /obj/item/gun/ballistic/automatic/pistol/pepperball
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm/eland
	item_type = /obj/item/gun/ballistic/revolver/sol
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm/wespe
	item_type = /obj/item/gun/ballistic/automatic/pistol/sol
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm/skild
	item_type = /obj/item/gun/ballistic/automatic/pistol/trappiste
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm/takbok
	item_type = /obj/item/gun/ballistic/revolver/sol/heavy
	cost = PAYCHECK_COMMAND * 6

// Lethal anything that's not a pistol, requires high company interest

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm
	subcategory = "Longarms"
	restricted = TRUE

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/renoster
	item_type = /obj/item/gun/ballistic/shotgun/riot/sol
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/sindano
	item_type = /obj/item/gun/ballistic/automatic/sol_smg
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/infanterie
	item_type = /obj/item/gun/ballistic/automatic/sol_rifle
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines
	subcategory = "Magazines"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines/c35_mag
	item_type = /obj/item/ammo_box/magazine/c35sol_pistol

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines/c35_extended
	item_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines/c585_mag
	item_type = /obj/item/ammo_box/magazine/c585trappiste_pistol

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines/sol_rifle_short
	item_type = /obj/item/ammo_box/magazine/c40sol_rifle

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines/sol_rifle_standard
	item_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines/sol_rifle_extended
	item_type = /obj/item/ammo_box/magazine/c40sol_rifle/extended
	cost = PAYCHECK_CREW * 3
	contraband = TRUE

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/magazines/sol_rifle_drum
	item_type = /obj/item/ammo_box/magazine/c40sol_rifle/drum
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE
