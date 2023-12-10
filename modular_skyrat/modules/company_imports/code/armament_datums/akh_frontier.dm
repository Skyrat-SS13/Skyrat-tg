/datum/armament_entry/company_import/akh_frontier
	category = FRONTIER_EQUIPMENT_NAME
	company_bitflag = CARGO_COMPANY_FRONTIER_EQUIPMENT

// Tools that you could use the rapid fabricator for, but you're too lazy to actually do that

/datum/armament_entry/company_import/akh_frontier/basic
	subcategory = "Hand-Held Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/akh_frontier/basic/omni_drill
	item_type = /obj/item/screwdriver/omni_drill

/datum/armament_entry/company_import/akh_frontier/basic/prybar
	item_type = /obj/item/crowbar/large/doorforcer
	restricted = TRUE

/datum/armament_entry/company_import/akh_frontier/basic/arc_welder
	item_type = /obj/item/weldingtool/electric/arc_welder

/datum/armament_entry/company_import/akh_frontier/basic/compact_drill
	item_type = /obj/item/pickaxe/drill/compact

// Wearable stuff, not inclusive of all clothing because you're supposed to print those

/datum/armament_entry/company_import/akh_frontier/wearables
	subcategory = "Wearable Equipment"

/datum/armament_entry/company_import/akh_frontier/wearables/hazard_mod
	name = "Frontier Hazard Protective MOD Control Unit"
	description = "The pinnacle of frontier cheap technology. Suits such as these are made specifically for the rare emergency that creates a hazard \
		environment that other equipment just can't quite handle. Often, these suits are able to protect their users \
		from not only electricity, but also radiation, biological hazards, other people, so on. This suit will not, \
		however, protect you from yourself."
	item_type = /obj/item/mod/control/pre_equipped/frontier_colonist
	cost = PAYCHECK_COMMAND * 6.5

/datum/armament_entry/company_import/akh_frontier/wearables/headset
	item_type = /obj/item/radio/headset/headset_frontier_colonist
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/akh_frontier/wearables/maska
	item_type = /obj/item/clothing/mask/gas/atmos/frontier_colonist
	cost = PAYCHECK_COMMAND

// Flatpacked fabricator and related upgrades

/datum/armament_entry/company_import/akh_frontier/deployables_fab
	subcategory = "Deployable Fabrication Equipment"

/datum/armament_entry/company_import/akh_frontier/deployables_fab/rapid_construction_fabricator
	item_type = /obj/item/flatpacked_machine
	cost = CARGO_CRATE_VALUE * 6
	restricted = TRUE

/datum/armament_entry/company_import/akh_frontier/deployables_fab/organics_printer
	item_type = /obj/item/flatpacked_machine/organics_printer
	cost = CARGO_CRATE_VALUE * 3

// Various smaller appliances than the deployable machines below

/datum/armament_entry/company_import/akh_frontier/appliances
	subcategory = "Appliances"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/akh_frontier/appliances/charger
	item_type = /obj/item/wallframe/cell_charger_multi
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/akh_frontier/appliances/gps_beacon
	item_type = /obj/item/flatpacked_machine/gps_beacon
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/akh_frontier/appliances/water_synth
	item_type = /obj/item/flatpacked_machine/water_synth

/datum/armament_entry/company_import/akh_frontier/appliances/hydro_synth
	item_type = /obj/item/flatpacked_machine/hydro_synth

/datum/armament_entry/company_import/akh_frontier/appliances/sustenance_dispenser
	item_type = /obj/item/flatpacked_machine/sustenance_machine

// Flatpacked, ready to deploy machines

/datum/armament_entry/company_import/akh_frontier/deployables_misc
	subcategory = "Deployable General Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/akh_frontier/deployables_misc/arc_furnace
	item_type = /obj/item/flatpacked_machine/arc_furnace

/datum/armament_entry/company_import/akh_frontier/deployables_misc/thermomachine
	item_type = /obj/item/flatpacked_machine/thermomachine

// Flatpacked, ready to deploy machines for power related activities

/datum/armament_entry/company_import/akh_frontier/deployables
	subcategory = "Deployable Power Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/akh_frontier/deployables/solar
	item_type = /obj/item/flatpacked_machine/solar
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/akh_frontier/deployables/solar_tracker
	item_type = /obj/item/flatpacked_machine/solar_tracker
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/akh_frontier/deployables/station_battery
	item_type = /obj/item/flatpacked_machine/station_battery

/datum/armament_entry/company_import/akh_frontier/deployables/big_station_battery
	item_type = /obj/item/flatpacked_machine/large_station_battery

/datum/armament_entry/company_import/akh_frontier/deployables/solids_generator
	item_type = /obj/item/flatpacked_machine/fuel_generator

/datum/armament_entry/company_import/akh_frontier/deployables/rtg
	item_type = /obj/item/flatpacked_machine/rtg
	restricted = TRUE
