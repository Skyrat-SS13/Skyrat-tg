/datum/armament_entry/company_import/nakamura_tooling
	category = NAKAMURA_ENGINEERING_TOOLING_NAME
	company_bitflag = CARGO_COMPANY_NAKAMURA_TOOLING

/datum/armament_entry/company_import/nakamura_tooling/manufacturing
	subcategory = "Manufacturing Equipment"

/datum/armament_entry/company_import/nakamura_tooling/rapid_construction_fabricator
	item_type = /obj/item/flatpacked_machine
	cost = CARGO_CRATE_VALUE * 8

// Tools that you could use the rapid fabricator for, but you're too lazy to actually do that

/datum/armament_entry/company_import/nakamura_tooling/basic
	subcategory = "Non-Standard Engineering Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nakamura_tooling/basic/omni_drill
	item_type = /obj/item/screwdriver/omni_drill

/datum/armament_entry/company_import/nakamura_tooling/basic/prybar
	item_type = /obj/item/crowbar/large/doorforcer

/datum/armament_entry/company_import/nakamura_tooling/basic/arc_welder
	item_type = /obj/item/weldingtool/electric/arc_welder

/datum/armament_entry/company_import/nakamura_tooling/basic/compact_drill
	item_type = /obj/item/pickaxe/drill/compact

/datum/armament_entry/company_import/nakamura_tooling/basic/insuls
	item_type = /obj/item/clothing/gloves/color/yellow

// Advanced stuff like power tools and holofans

/datum/armament_entry/company_import/nakamura_tooling/advanced
	subcategory = "Advanced Engineering Equipment"
	restricted = TRUE
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/nakamura_tooling/advanced/ranged_analyzer
	item_type = /obj/item/analyzer/ranged
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nakamura_tooling/advanced/forcefield
	item_type = /obj/item/forcefield_projector
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nakamura_tooling/advanced/atmos_fan
	item_type = /obj/item/holosign_creator/atmos
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nakamura_tooling/advanced/powerdrill
	item_type = /obj/item/screwdriver/power

/datum/armament_entry/company_import/nakamura_tooling/advanced/jaws
	item_type = /obj/item/crowbar/power

/datum/armament_entry/company_import/nakamura_tooling/advanced/expwelder
	item_type = /obj/item/weldingtool/experimental

// Flatpacked, ready to deploy machines

/datum/armament_entry/company_import/nakamura_tooling/deployables
	subcategory = "Deployable Equipment"

/datum/armament_entry/company_import/nakamura_tooling/deployables/solar
	item_type = /obj/item/flatpacked_machine/solar
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nakamura_tooling/deployables/solar_tracker
	item_type = /obj/item/flatpacked_machine/solar_tracker
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nakamura_tooling/deployables/station_battery
	item_type = /obj/item/flatpacked_machine/station_battery
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nakamura_tooling/deployables/big_station_battery
	item_type = /obj/item/flatpacked_machine/large_station_battery
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nakamura_tooling/deployables/arc_furnace
	item_type = /obj/item/flatpacked_machine/arc_furnace
	cost = PAYCHECK_COMMAND
