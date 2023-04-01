#define PRICE_FIRST_AID_BASIC_LOWER 0.1
#define PRICE_FIRST_AID_BASIC_HIGHER 0.2
#define PRICE_FIRST_AID_MEDIUM_LOWER 0.3
#define PRICE_FIRST_AID_MEDIUM_HIGHER 0.4
#define PRICE_FIRST_AID_PREMIUM_LOWER 0.6
#define PRICE_FIRST_AID_PREMIUM_HIGHER 0.7

#define PRICE_CHEM_CHEAP_LOWER 5.7
#define PRICE_CHEM_CHEAP_HIGHER 4.8
#define PRICE_CHEM_MEDIUM_LOWER 4.4
#define PRICE_CHEM_MEDIUM_HIGHER 4 
#define PRICE_CHEM_PREMIUM_LOWER 3.5
#define PRICE_CHEM_PREMIUM_HIGHER 3

/datum/armament_entry/company_import/deforest
	category = DEFOREST_MEDICAL_NAME
	company_bitflag = CARGO_COMPANY_DEFOREST

// Basic first aid supplies like gauze, sutures, mesh, so on

/datum/armament_entry/company_import/deforest/first_aid
	subcategory = "First-Aid Supplies"

/datum/armament_entry/company_import/deforest/first_aid/gauze
	item_type = /obj/item/stack/medical/gauze/twelve
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_HIGHER
	stock_mult = 3
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/deforest/first_aid/splint
	item_type = /obj/item/stack/medical/splint/twelve
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_HIGHER
	stock_mult = 3
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/deforest/first_aid/bruise_pack
	item_type = /obj/item/stack/medical/bruise_pack
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_MEDIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_MEDIUM_HIGHER
	stock_mult = 3
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/deforest/first_aid/ointment
	item_type = /obj/item/stack/medical/ointment
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_MEDIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_MEDIUM_HIGHER
	stock_mult = 3
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/company_import/deforest/first_aid/suture
	item_type = /obj/item/stack/medical/suture
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_HIGHER
	stock_mult = 3

/datum/armament_entry/company_import/deforest/first_aid/mesh
	item_type = /obj/item/stack/medical/mesh
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_BASIC_HIGHER
	stock_mult = 3

/datum/armament_entry/company_import/deforest/first_aid/bone_gel
	item_type = /obj/item/stack/medical/bone_gel/four
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_MEDIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_MEDIUM_HIGHER
	stock_mult = 2
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/first_aid/medicated_sutures
	item_type = /obj/item/stack/medical/suture/medicated
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_PREMIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_PREMIUM_HIGHER
	stock_mult = 2
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/first_aid/advanced_mesh
	item_type = /obj/item/stack/medical/mesh/advanced
	lower_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_PREMIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_FIRST_AID_PREMIUM_HIGHER
	stock_mult = 2
	interest_required = COMPANY_SOME_INTEREST

// Various chemicals, with a box of syringes to come with

/datum/armament_entry/company_import/deforest/medical_chems
	subcategory = "Chemical Supplies"

/datum/armament_entry/company_import/deforest/medical_chems/syringes
	item_type = /obj/item/storage/box/syringes
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/epinephrine
	item_type = /obj/item/reagent_containers/cup/bottle/epinephrine
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_MEDIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_MEDIUM_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/mannitol
	item_type = /obj/item/reagent_containers/cup/bottle/mannitol
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/morphine
	item_type = /obj/item/reagent_containers/cup/bottle/morphine
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_MEDIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_MEDIUM_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/multiver
	item_type = /obj/item/reagent_containers/cup/bottle/multiver
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/formadehyde
	item_type = /obj/item/reagent_containers/cup/bottle/formaldehyde
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/potassium_iodide
	item_type = /obj/item/reagent_containers/cup/bottle/potass_iodide
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_CHEAP_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/atropine
	item_type = /obj/item/reagent_containers/cup/bottle/atropine
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_PREMIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_PREMIUM_HIGHER

/datum/armament_entry/company_import/deforest/medical_chems/syriniver
	item_type = /obj/item/reagent_containers/cup/bottle/syriniver
	lower_cost = CARGO_CRATE_VALUE * PRICE_CHEM_MEDIUM_LOWER
	upper_cost = CARGO_CRATE_VALUE * PRICE_CHEM_MEDIUM_HIGHER

// Equipment, from defibs to scanners to surgical tools

/datum/armament_entry/company_import/deforest/equipment
	subcategory = "Medical Equipment"

/datum/armament_entry/company_import/deforest/equipment/health_analyzer
	item_type = /obj/item/healthanalyzer
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 1.4
	stock_mult = 2

/datum/armament_entry/company_import/deforest/equipment/loaded_defib
	item_type = /obj/item/defibrillator/loaded
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/deforest/equipment/surgical_tools
	item_type = /obj/item/storage/backpack/duffelbag/med/surgery
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 2.5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/deforest/equipment/advanced_health_analyer
	item_type = /obj/item/healthanalyzer/advanced
	lower_cost = CARGO_CRATE_VALUE * 2.5
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/equipment/penlite_defib_mount
	item_type = /obj/item/wallframe/defib_mount/charging
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 6
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/equipment/advanced_scalpel
	item_type = /obj/item/scalpel/advanced
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_HIGH_INTEREST

/datum/armament_entry/company_import/deforest/equipment/advanced_retractor
	item_type = /obj/item/retractor/advanced
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_HIGH_INTEREST

/datum/armament_entry/company_import/deforest/equipment/advanced_cautery
	item_type = /obj/item/cautery/advanced
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_HIGH_INTEREST

/datum/armament_entry/company_import/deforest/equipment/medigun_upgrade
	item_type = /obj/item/device/custom_kit/medigun_fastcharge
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/equipment/afad
	item_type = /obj/item/gun/medbeam/afad
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 7
	interest_addition = COMPANY_INTEREST_GAIN_BIG
	interest_required = COMPANY_HIGH_INTEREST

// Various advanced cybernetic organs, organ replacements for the rich

/datum/armament_entry/company_import/deforest/cyber_organs
	subcategory = "Premium Cybernetic Organs"

/datum/armament_entry/company_import/deforest/cyber_organs/eyes
	name = "shielded cybernetic eyes"
	item_type = /obj/item/storage/organbox/advanced_cyber_eyes
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/cyber_organs/ears
	name = "upgraded cybernetic ears"
	item_type = /obj/item/storage/organbox/advanced_cyber_ears
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/cyber_organs/heart
	name = "upgraded cybernetic heart"
	item_type = /obj/item/storage/organbox/advanced_cyber_heart
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/cyber_organs/liver
	name = "upgraded cybernetic liver"
	item_type = /obj/item/storage/organbox/advanced_cyber_liver
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/cyber_organs/lungs
	name = "upgraded cybernetic lungs"
	item_type = /obj/item/storage/organbox/advanced_cyber_lungs
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/deforest/cyber_organs/stomach
	name = "upgraded cybernetic stomach"
	item_type = /obj/item/storage/organbox/advanced_cyber_stomach
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST


#undef PRICE_FIRST_AID_BASIC_LOWER
#undef PRICE_FIRST_AID_BASIC_HIGHER
#undef PRICE_FIRST_AID_MEDIUM_LOWER
#undef PRICE_FIRST_AID_MEDIUM_HIGHER
#undef PRICE_FIRST_AID_PREMIUM_LOWER
#undef PRICE_FIRST_AID_PREMIUM_HIGHER

#undef PRICE_CHEM_CHEAP_LOWER
#undef PRICE_CHEM_CHEAP_HIGHER
#undef PRICE_CHEM_MEDIUM_LOWER
#undef PRICE_CHEM_MEDIUM_HIGHER
#undef PRICE_CHEM_PREMIUM_LOWER
#undef PRICE_CHEM_PREMIUM_HIGHER
