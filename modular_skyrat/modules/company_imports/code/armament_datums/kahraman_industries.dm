/datum/armament_entry/company_import/kahraman
	category = KAHRAMAN_INDUSTRIES_NAME
	company_bitflag = CARGO_COMPANY_KAHRAMAN

// Mining PPE, SEVAs and hardhats, have you passed your OSHA inspection today?

/datum/armament_entry/company_import/kahraman/ppe
	subcategory = "OSHA Certified Protective Equipment"

/datum/armament_entry/company_import/kahraman/ppe/hardhat
	item_type = /obj/item/clothing/head/utility/hardhat/orange
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE

/datum/armament_entry/company_import/kahraman/ppe/weldhat
	item_type = /obj/item/clothing/head/utility/hardhat/welding/orange
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.25

/datum/armament_entry/company_import/kahraman/ppe/gasmask
	item_type = /obj/item/clothing/mask/gas/alt
	lower_cost = CARGO_CRATE_VALUE * 0.1
	upper_cost = CARGO_CRATE_VALUE * 0.3

/datum/armament_entry/company_import/kahraman/ppe/hazard_vest
	item_type = /obj/item/clothing/suit/hazardvest
	lower_cost = CARGO_CRATE_VALUE * 0.3
	upper_cost = CARGO_CRATE_VALUE * 0.6

/datum/armament_entry/company_import/kahraman/ppe/seva_mask
	item_type = /obj/item/clothing/mask/gas/seva
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/ppe/seva_suit
	item_type = /obj/item/clothing/suit/hooded/seva
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 2
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/kahraman/ppe/sensors_cuffs
	item_type = /obj/item/kheiral_cuffs
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_BIG

// Hand held mining equipment

/datum/armament_entry/company_import/kahraman/mining_tool
	subcategory = "Powered Mining Equipment"

/datum/armament_entry/company_import/kahraman/mining_tool/drill
	item_type = /obj/item/pickaxe/drill
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/kahraman/mining_tool/resonator
	item_type = /obj/item/resonator
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/company_import/kahraman/mining_tool/pka
	item_type = /obj/item/gun/energy/recharge/kinetic_accelerator
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/company_import/kahraman/mining_tool/cutter
	item_type = /obj/item/gun/energy/plasmacutter
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/company_import/kahraman/mining_tool/diamond_drill
	item_type = /obj/item/pickaxe/drill/diamonddrill
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 2
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/mining_tool/advanced_cutter
	item_type = /obj/item/gun/energy/plasmacutter/adv
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/mining_tool/super_resonator
	item_type = /obj/item/resonator/upgraded
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/mining_tool/jackhammer
	item_type = /obj/item/pickaxe/drill/jackhammer
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/sensing
	subcategory = "Sensing Equipment"

/datum/armament_entry/company_import/kahraman/sensing/mesons
	item_type = /obj/item/clothing/glasses/meson
	lower_cost = CARGO_CRATE_VALUE * 0.2
	upper_cost = CARGO_CRATE_VALUE * 0.5

/datum/armament_entry/company_import/kahraman/sensing/autoscanner
	item_type = /obj/item/t_scanner/adv_mining_scanner/lesser
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE

/datum/armament_entry/company_import/kahraman/sensing/super_autoscanner
	item_type = /obj/item/t_scanner/adv_mining_scanner
	lower_cost = CARGO_CRATE_VALUE * 0.7
	upper_cost = CARGO_CRATE_VALUE * 1.3
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/sensing/nvg_mesons
	item_type = /obj/item/clothing/glasses/meson/night
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/mecha_tools
	subcategory = "Heavy Powered Mining Equipment"

/datum/armament_entry/company_import/kahraman/mecha_tools/scanner
	item_type = /obj/item/mecha_parts/mecha_equipment/mining_scanner
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE

/datum/armament_entry/company_import/kahraman/mecha_tools/drill
	item_type = /obj/item/mecha_parts/mecha_equipment/drill
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/kahraman/mecha_tools/pka
	item_type = /obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 2.5

/datum/armament_entry/company_import/kahraman/mecha_tools/diamond_drill
	item_type = /obj/item/mecha_parts/mecha_equipment/drill/diamonddrill
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/kahraman/mecha_tools/cutter
	item_type = /obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_required = COMPANY_SOME_INTEREST
