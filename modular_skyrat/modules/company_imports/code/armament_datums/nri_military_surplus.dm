/datum/armament_entry/company_import/nri_surplus
	category = NRI_SURPLUS_COMPANY_NAME
	company_bitflag = CARGO_COMPANY_NRI_SURPLUS

// Various NRI clothing items

/datum/armament_entry/company_import/nri_surplus/clothing
	subcategory = "Clothing Supplies"

/datum/armament_entry/company_import/nri_surplus/clothing/uniform
	description = "A CIN designed combat uniform that can come in any number of camouflauge variations. These will ship in a station environment suitable camouflauge scheme."
	item_type = /obj/item/clothing/under/syndicate/rus_army/cin_surplus
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/cap
	item_type = /obj/item/clothing/head/soft/nri_larp
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/nri_surplus/clothing/belt
	item_type = /obj/item/storage/belt/military/cin_surplus
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/backpack
	item_type = /obj/item/storage/backpack/industrial/cin_surplus
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/gas_mask
	item_type = /obj/item/clothing/mask/gas/hecu2
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/helmet
	description = "A service helmet primarily used by CIN military forces. These will ship in a station environment suitable camouflauge scheme."
	item_type = /obj/item/clothing/head/helmet/cin_surplus_helmet
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nri_surplus/clothing/vest
	description = "An armor vest primarily used by CIN military forces. These will ship in a station environment suitable camouflauge scheme."
	item_type = /obj/item/clothing/suit/armor/vest/cin_surplus_vest
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nri_surplus/clothing/police_uniform
	item_type = /obj/item/clothing/under/colonial/nri_police
	cost = PAYCHECK_CREW
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/clothing/police_cloak
	item_type = /obj/item/clothing/neck/cloak/colonial/nri_police
	cost = PAYCHECK_CREW
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/clothing/police_cap
	item_type = /obj/item/clothing/head/hats/colonial/nri_police
	cost = PAYCHECK_CREW
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/clothing/police_mask
	item_type = /obj/item/clothing/mask/gas/nri_police
	cost = PAYCHECK_CREW*2
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/clothing/police_vest
	item_type = /obj/item/clothing/head/helmet/nri_police
	cost = PAYCHECK_COMMAND
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/clothing/police_helmet
	item_type = /obj/item/clothing/suit/armor/vest/nri_police
	cost = PAYCHECK_COMMAND
	restricted = TRUE

// Random surplus store tier stuff, flags, old rations, multitools you'll never use, so on

/datum/armament_entry/company_import/nri_surplus/misc
	subcategory = "Miscellaneous Supplies"

/datum/armament_entry/company_import/nri_surplus/misc/flares
	item_type = /obj/item/storage/box/nri_flares
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/nri_surplus/misc/binoculars
	item_type = /obj/item/binoculars
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/misc/screwdriver_pen
	item_type = /obj/item/pen/screwdriver
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/misc/trench_tool
	item_type = /obj/item/trench_tool
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/misc/food_replicator
	description = "Once widespread technology used by numerous fringe colonies of NRI origin and even in some SolFed territories, that ultimately went out of fashion due to \
	SolFed propaganda deeming it unprofitable and imposing severe trading fees on anyone trying to sell them. A small portion of government-backed manufacturers still produce \
	'food replicators' for private and government use; a few of them is selling this via us."
	item_type = /obj/item/circuitboard/machine/biogenerator/food_replicator
	cost = CARGO_CRATE_VALUE * 9

/datum/armament_entry/company_import/nri_surplus/misc/nri_flag
	item_type = /obj/item/sign/flag/nri
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/nri_surplus/firearm
	subcategory = "Firearms"

/datum/armament_entry/company_import/nri_surplus/firearm/shotgun_revolver
	item_type = /obj/item/gun/ballistic/revolver/cin_shotgun_revolver
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nri_surplus/firearm/plasma_thrower
	item_type = /obj/item/gun/energy/laser/plasma_thrower
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nri_surplus/firearm/anti_materiel_rifle
	item_type = /obj/item/gun/ballistic/automatic/cin_amr
	cost = PAYCHECK_COMMAND * 12
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/firearm/sakhno_rifle
	item_type = /obj/item/gun/ballistic/rifle/boltaction
	cost = PAYCHECK_COMMAND * 12
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/firearm_ammo
	subcategory = "Firearm Magazines"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/amr_magazine
	item_type = /obj/item/ammo_box/magazine/cin_amr

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/sakhno_stripper
	item_type = /obj/item/ammo_box/strilka310

