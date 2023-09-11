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

// Fully non-lethal weapons

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/nonlethal
	subcategory = "Non-Lethal Weapons"

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/nonlethal/responder
	item_type = /obj/item/gun/energy/disabler/bolt_disabler
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/nonlethal/pepperball
	item_type = /obj/item/gun/ballistic/automatic/pistol/pepperball
	cost = PAYCHECK_CREW * 5

// Lethal pistols, requires some company interest first

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm
	subcategory = "Lethal Sidearms"

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm/detective_revolver
	item_type = /obj/item/gun/ballistic/revolver/c38/detective
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm/g17
	item_type = /obj/item/gun/ballistic/automatic/pistol/g17
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm/mk58
	item_type = /obj/item/gun/ballistic/automatic/pistol/mk58
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/lethal_sidearm/m1911
	item_type = /obj/item/gun/ballistic/automatic/pistol/m1911
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines
	subcategory = "Sidearm Magazines"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines/c38speedloader
	item_type = /obj/item/ammo_box/c38

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines/c38speedloader_rubber
	item_type = /obj/item/ammo_box/c38/match/bouncy

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines/g17
	item_type = /obj/item/ammo_box/magazine/multi_sprite/g17

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines/g17_rubber
	item_type = /obj/item/ammo_box/magazine/multi_sprite/g17/rubber

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines/mk58
	item_type = /obj/item/ammo_box/magazine/multi_sprite/mk58

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines/mk58_rubber
	item_type = /obj/item/ammo_box/magazine/multi_sprite/mk58/rubber

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/sidearm_magazines/m1911
	item_type = /obj/item/ammo_box/magazine/m45

// Lethal anything that's not a pistol, requires high company interest

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm
	subcategory = "Lethal Longarms"
	restricted = TRUE

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/riot_shotgun
	item_type = /obj/item/gun/ballistic/shotgun/riot
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/m23
	item_type = /obj/item/gun/ballistic/shotgun/m23
	cost = PAYCHECK_COMMAND * 8

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/wt550
	item_type = /obj/item/gun/ballistic/automatic/wt550
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm/cmg
	item_type = /obj/item/gun/ballistic/automatic/cmg
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm_magazines
	subcategory = "Longarm Magazines"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm_magazines/wt550
	item_type = /obj/item/ammo_box/magazine/wt550m9

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm_magazines/cmg
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cmg/lethal

/datum/armament_entry/company_import/nanotrasen_bolt_weapons/longarm_magazines/cmg_rubber
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cmg
