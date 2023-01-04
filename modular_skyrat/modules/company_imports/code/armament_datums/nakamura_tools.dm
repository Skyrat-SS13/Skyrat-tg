/datum/armament_entry/company_import/nakamura_tooling
	category = NAKAMURA_ENGINEERING_TOOLING_NAME
	company_bitflag = CARGO_COMPANY_NAKAMURA_TOOLING

// Basic, non-power tools, as well as other related equipment

/datum/armament_entry/company_import/nakamura_tooling/basic
	subcategory = "Standard Engineering Equipment"

/datum/armament_entry/company_import/nakamura_tooling/basic/analyzer
	item_type = /obj/item/analyzer
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nakamura_tooling/basic/mechanical_toolbox
	item_type = /obj/item/storage/toolbox/mechanical
	lower_cost = PAYCHECK_CREW
	upper_cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/nakamura_tooling/basic/electrical_toolbox
	item_type = /obj/item/storage/toolbox/electrical
	lower_cost = PAYCHECK_CREW
	upper_cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/nakamura_tooling/basic/multitool
	item_type = /obj/item/multitool
	lower_cost = PAYCHECK_CREW
	upper_cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/nakamura_tooling/basic/inducer
	item_type = /obj/item/inducer
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/nakamura_tooling/basic/magboots
	item_type = /obj/item/clothing/shoes/magboots
	lower_cost = PAYCHECK_CREW * 3
	upper_cost = PAYCHECK_CREW * 5
/datum/armament_entry/company_import/nakamura_tooling/basic/insuls
	item_type = /obj/item/clothing/gloves/color/yellow
	lower_cost = PAYCHECK_CREW * 3
	upper_cost = PAYCHECK_CREW * 5

// Advanced stuff like power tools and holofans

/datum/armament_entry/company_import/nakamura_tooling/advanced
	subcategory = "Advanced Engineering Equipment"
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	restricted = TRUE

/datum/armament_entry/company_import/nakamura_tooling/advanced/ranged_analyzer
	item_type = /obj/item/analyzer/ranged
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.25

/datum/armament_entry/company_import/nakamura_tooling/advanced/forcefield
	item_type = /obj/item/forcefield_projector
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/nakamura_tooling/advanced/atmos_fan
	item_type = /obj/item/holosign_creator/atmos
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/nakamura_tooling/advanced/powerdrill
	item_type = /obj/item/screwdriver/power
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/nakamura_tooling/advanced/jaws
	item_type = /obj/item/crowbar/power
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/company_import/nakamura_tooling/advanced/hugewelder
	item_type = /obj/item/weldingtool/hugetank
	lower_cost = CARGO_CRATE_VALUE * 1.5
	upper_cost = CARGO_CRATE_VALUE * 3

// Overpriced experimental or gimmick tools

/datum/armament_entry/company_import/nakamura_tooling/experimental
	subcategory = "Experimental Engineering Equipment"
	interest_required = COMPANY_HIGH_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_BIG
	restricted = TRUE

/datum/armament_entry/company_import/nakamura_tooling/experimental/sprayon_insuls
	item_type = /obj/item/toy/sprayoncan
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4
	contraband = TRUE

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_screwdriver
	item_type = /obj/item/screwdriver/caravan
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_crowbar
	item_type = /obj/item/crowbar/red/caravan
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_wirecutters
	item_type = /obj/item/wirecutters/caravan
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/company_import/nakamura_tooling/experimental/red_wrench
	item_type = /obj/item/wrench/caravan
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/company_import/nakamura_tooling/experimental/advanced_welder
	item_type = /obj/item/weldingtool/advanced
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 7
