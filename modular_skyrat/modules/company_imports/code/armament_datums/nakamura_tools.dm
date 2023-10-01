/datum/armament_entry/company_import/kz_frontier
	category = KZ_EQUIPMENT_NAME
	company_bitflag = CARGO_COMPANY_KZ_EQUIPMENT

/datum/armament_entry/company_import/kz_frontier/manufacturing
	subcategory = "Manufacturing Equipment"

/datum/armament_entry/company_import/kz_frontier/rapid_construction_fabricator
	item_type = /obj/item/flatpacked_machine
	cost = CARGO_CRATE_VALUE * 8

// Tools that you could use the rapid fabricator for, but you're too lazy to actually do that

/datum/armament_entry/company_import/kz_frontier/basic
	subcategory = "Non-Standard Engineering Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kz_frontier/basic/omni_drill
	item_type = /obj/item/screwdriver/omni_drill

/datum/armament_entry/company_import/kz_frontier/basic/prybar
	item_type = /obj/item/crowbar/large/doorforcer

/datum/armament_entry/company_import/kz_frontier/basic/arc_welder
	item_type = /obj/item/weldingtool/electric/arc_welder

/datum/armament_entry/company_import/kz_frontier/basic/compact_drill
	item_type = /obj/item/pickaxe/drill/compact

// Flatpacked, ready to deploy machines

/datum/armament_entry/company_import/kz_frontier/deployables
	subcategory = "Deployable Equipment"

/datum/armament_entry/company_import/kz_frontier/deployables/solar
	item_type = /obj/item/flatpacked_machine/solar
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kz_frontier/deployables/solar_tracker
	item_type = /obj/item/flatpacked_machine/solar_tracker
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kz_frontier/deployables/station_battery
	item_type = /obj/item/flatpacked_machine/station_battery
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kz_frontier/deployables/big_station_battery
	item_type = /obj/item/flatpacked_machine/large_station_battery
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kz_frontier/deployables/arc_furnace
	item_type = /obj/item/flatpacked_machine/arc_furnace
	cost = PAYCHECK_COMMAND
