/datum/armament_entry/company_import/kahraman
	category = COMPANY_NAME_KAHRAMAN_INDUSTRIES
	company_bitflag = CARGO_COMPANY_KAHRAMAN

/// Kahraman-made machines
/datum/armament_entry/company_import/kahraman/machinery
	subcategory = "Machinery"

/datum/armament_entry/company_import/kahraman/machinery/biogenerator
	item_type = /obj/item/flatpacked_machine/organics_printer
	description = "An advanced machine seen in frontier outposts and colonies capable of turning organic plant matter into \
		reagents and items of use that a fabricator can't typically make."
	cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/kahraman/machinery/ore_thumper
	item_type = /obj/item/flatpacked_machine/ore_thumper
	description = "A frame with a heavy block of metal suspended atop a pipe. \
		Must be deployed outdoors and given a wired power connection. \
		Forces pressurized gas into the ground which brings up buried resources."
	cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/company_import/kahraman/machinery/gps_beacon
	item_type = /obj/item/flatpacked_machine/gps_beacon
	description = "A packed GPS beacon, can be deployed and anchored into the ground to \
		provide and unobstructed homing beacon for wayward travelers across the galaxy."
	cost = PAYCHECK_LOWER

// Mining PPE, SEVAs and hardhats, have you passed your OSHA inspection today?

/datum/armament_entry/company_import/kahraman/ppe
	subcategory = "FOHSA Certified Protective Equipment"

/datum/armament_entry/company_import/kahraman/ppe/weldhat
	item_type = /obj/item/clothing/head/utility/hardhat/welding/orange
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/kahraman/ppe/gasmask
	item_type = /obj/item/clothing/mask/gas/alt
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/kahraman/ppe/hazard_vest
	item_type = /obj/item/clothing/suit/hazardvest
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kahraman/ppe/seva_mask
	item_type = /obj/item/clothing/mask/gas/seva
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/kahraman/ppe/seva_suit
	item_type = /obj/item/clothing/suit/hooded/seva
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/kahraman/ppe/sensors_cuffs
	item_type = /obj/item/kheiral_cuffs
	cost = PAYCHECK_COMMAND * 5

// Hand held mining equipment

/datum/armament_entry/company_import/kahraman/mining_tool
	subcategory = "Powered Mining Equipment"

/datum/armament_entry/company_import/kahraman/mining_tool/drill
	item_type = /obj/item/pickaxe/drill
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kahraman/mining_tool/resonator
	item_type = /obj/item/resonator
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kahraman/mining_tool/pka
	item_type = /obj/item/gun/energy/recharge/kinetic_accelerator
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kahraman/mining_tool/cutter
	item_type = /obj/item/gun/energy/plasmacutter
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kahraman/mining_tool/diamond_drill
	item_type = /obj/item/pickaxe/drill/diamonddrill
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/kahraman/mining_tool/advanced_cutter
	item_type = /obj/item/gun/energy/plasmacutter/adv
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/kahraman/mining_tool/super_resonator
	item_type = /obj/item/resonator/upgraded
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/kahraman/mining_tool/jackhammer
	item_type = /obj/item/pickaxe/drill/jackhammer
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/kahraman/sensing
	subcategory = "Sensing Equipment"

/datum/armament_entry/company_import/kahraman/sensing/mesons
	item_type = /obj/item/clothing/glasses/meson
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kahraman/sensing/autoscanner
	item_type = /obj/item/t_scanner/adv_mining_scanner/lesser
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/kahraman/sensing/super_autoscanner
	item_type = /obj/item/t_scanner/adv_mining_scanner
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/kahraman/sensing/nvg_mesons
	item_type = /obj/item/clothing/glasses/meson/night
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/kahraman/mecha_tools
	subcategory = "Heavy Powered Mining Equipment"

/datum/armament_entry/company_import/kahraman/mecha_tools/scanner
	item_type = /obj/item/mecha_parts/mecha_equipment/mining_scanner
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kahraman/mecha_tools/drill
	item_type = /obj/item/mecha_parts/mecha_equipment/drill
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kahraman/mecha_tools/pka
	item_type = /obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/kahraman/mecha_tools/diamond_drill
	item_type = /obj/item/mecha_parts/mecha_equipment/drill/diamonddrill
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/kahraman/mecha_tools/cutter
	item_type = /obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma
	cost = PAYCHECK_CREW * 3
