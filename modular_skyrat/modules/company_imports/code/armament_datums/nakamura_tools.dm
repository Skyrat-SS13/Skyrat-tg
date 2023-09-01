/datum/armament_entry/company_import/nakamura_tooling
	category = NAKAMURA_ENGINEERING_TOOLING_NAME
	company_bitflag = CARGO_COMPANY_NAKAMURA_TOOLING

// Basic, non-power tools, as well as other related equipment

/datum/armament_entry/company_import/nakamura_tooling/basic
	subcategory = "Standard Engineering Equipment"

/datum/armament_entry/company_import/nakamura_tooling/basic/mechanical_toolbox
	item_type = /obj/item/storage/toolbox/mechanical
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/nakamura_tooling/basic/electrical_toolbox
	item_type = /obj/item/storage/toolbox/electrical
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/nakamura_tooling/basic/multitool
	item_type = /obj/item/multitool
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/nakamura_tooling/basic/inducer
	item_type = /obj/item/inducer
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nakamura_tooling/basic/magboots
	item_type = /obj/item/clothing/shoes/magboots
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nakamura_tooling/basic/insuls
	item_type = /obj/item/clothing/gloves/color/yellow
	cost = PAYCHECK_COMMAND

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

/datum/armament_entry/company_import/nakamura_tooling/advanced/hugewelder
	item_type = /obj/item/weldingtool/hugetank

// Overpriced experimental or gimmick tools

/datum/armament_entry/company_import/nakamura_tooling/experimental
	subcategory = "Experimental Engineering Equipment"
	cost = PAYCHECK_COMMAND * 8
	restricted = TRUE

/datum/armament_entry/company_import/nakamura_tooling/experimental/sprayon_insuls
	item_type = /obj/item/toy/sprayoncan
	contraband = TRUE

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_screwdriver
	item_type = /obj/item/screwdriver/caravan

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_crowbar
	item_type = /obj/item/crowbar/red/caravan

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_wirecutters
	item_type = /obj/item/wirecutters/caravan

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_wrench
	item_type = /obj/item/wrench/caravan

/datum/armament_entry/company_import/nakamura_tooling/experimental/advanced_welder
	item_type = /obj/item/weldingtool/advanced
