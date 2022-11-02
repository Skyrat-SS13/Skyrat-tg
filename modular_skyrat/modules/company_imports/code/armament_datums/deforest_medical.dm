/datum/armament_entry/cargo_gun/deforest
	category = "DeForest Medical Corporation"
	company_bitflag = CARGO_COMPANY_DEFOREST

// Basic first aid supplies like gauze, sutures, mesh, so on

/datum/armament_entry/cargo_gun/deforest/first_aid
	subcategory = "First-Aid Supplies"

/datum/armament_entry/cargo_gun/deforest/first_aid/gauze
	item_type = /obj/item/stack/medical/gauze/twelve
	lower_cost = CARGO_CRATE_VALUE * 0.1
	upper_cost = CARGO_CRATE_VALUE * 0.3
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/cargo_gun/deforest/first_aid/splint
	item_type = /obj/item/stack/medical/splint/twelve
	lower_cost = CARGO_CRATE_VALUE * 0.2
	upper_cost = CARGO_CRATE_VALUE * 0.5
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/cargo_gun/deforest/first_aid/bruise_pack
	item_type = /obj/item/stack/medical/bruise_pack
	lower_cost = CARGO_CRATE_VALUE * 0.2
	upper_cost = CARGO_CRATE_VALUE * 0.5
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/cargo_gun/deforest/first_aid/ointment
	item_type = /obj/item/stack/medical/ointment
	lower_cost = CARGO_CRATE_VALUE * 0.2
	upper_cost = CARGO_CRATE_VALUE * 0.5
	interest_addition = COMPANY_INTEREST_GAIN_PITIFUL

/datum/armament_entry/cargo_gun/deforest/first_aid/suture
	item_type = /obj/item/stack/medical/suture
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/first_aid/mesh
	item_type = /obj/item/stack/medical/mesh
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/first_aid/bone_gel
	item_type = /obj/item/stack/medical/bone_gel/four
	lower_cost = CARGO_CRATE_VALUE * 0.6
	upper_cost = CARGO_CRATE_VALUE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/first_aid/medicated_sutures
	item_type = /obj/item/stack/medical/suture/medicated
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.4
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/first_aid/advanced_mesh
	item_type = /obj/item/stack/medical/mesh/advanced
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 1.4
	interest_required = PASSED_INTEREST

// Various chemicals, with a box of syringes to come with

/datum/armament_entry/cargo_gun/deforest/medical_chems
	subcategory = "Chemical Supplies"

/datum/armament_entry/cargo_gun/deforest/medical_chems/syringes
	item_type = /obj/item/storage/box/syringes
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/cargo_gun/deforest/medical_chems/epinephrine
	item_type = /obj/item/reagent_containers/cup/bottle/epinephrine
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/medical_chems/mannitol
	item_type = /obj/item/reagent_containers/cup/bottle/mannitol
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/medical_chems/morphine
	item_type = /obj/item/reagent_containers/cup/bottle/morphine
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/medical_chems/multiver
	item_type = /obj/item/reagent_containers/cup/bottle/multiver
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/medical_chems/formadehyde
	item_type = /obj/item/reagent_containers/cup/bottle/formaldehyde
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/medical_chems/potassium_iodide
	item_type = /obj/item/reagent_containers/cup/bottle/potass_iodide
	lower_cost = CARGO_CRATE_VALUE * 0.4
	upper_cost = CARGO_CRATE_VALUE * 0.7

/datum/armament_entry/cargo_gun/deforest/medical_chems/atropine
	item_type = /obj/item/reagent_containers/cup/bottle/atropine
	lower_cost = CARGO_CRATE_VALUE * 0.7
	upper_cost = CARGO_CRATE_VALUE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/medical_chems/ephedrine
	item_type = /obj/item/reagent_containers/cup/bottle/ephedrine
	lower_cost = CARGO_CRATE_VALUE * 0.7
	upper_cost = CARGO_CRATE_VALUE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/medical_chems/syriniver
	item_type = /obj/item/reagent_containers/cup/bottle/syriniver
	lower_cost = CARGO_CRATE_VALUE * 0.7
	upper_cost = CARGO_CRATE_VALUE
	interest_required = PASSED_INTEREST

// Equipment, from defibs to scanners to surgical tools

/datum/armament_entry/cargo_gun/deforest/equipment
	subcategory = "Medical Equipment"

/datum/armament_entry/cargo_gun/deforest/equipment/health_analyzer
	item_type = /obj/item/healthanalyzer
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/cargo_gun/deforest/equipment/loaded_defib
	item_type = /obj/item/defibrillator/loaded
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 2.5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/cargo_gun/deforest/equipment/surgical_tools
	item_type = /obj/item/storage/backpack/duffelbag/med/surgery
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/cargo_gun/deforest/equipment/advanced_health_analyer
	item_type = /obj/item/healthanalyzer/advanced
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 4
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/equipment/penlite_defib_mount
	item_type = /obj/item/wallframe/defib_mount/charging
	lower_cost = CARGO_CRATE_VALUE * 4
	upper_cost = CARGO_CRATE_VALUE * 6
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/equipment/advanced_scalpel
	item_type = /obj/item/scalpel/advanced
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/deforest/equipment/advanced_retractor
	item_type = /obj/item/retractor/advanced
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/deforest/equipment/advanced_cautery
	item_type = /obj/item/cautery/advanced
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = HIGH_INTEREST

/datum/armament_entry/cargo_gun/deforest/equipment/afad
	item_type = /obj/item/gun/medbeam/afad
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 10
	interest_addition = COMPANY_INTEREST_GAIN_BIG
	interest_required = HIGH_INTEREST

// Various advanced cybernetic organs, organ replacements for the rich

/datum/armament_entry/cargo_gun/deforest/cyber_organs
	subcategory = "Premium Cybernetic Organs"

/datum/armament_entry/cargo_gun/deforest/cyber_organs/eyes
	name = "DeForest (tm) FullSense (tm) Cybernetic Eyes"
	item_type = /obj/item/storage/organbox/advanced_cyber_eyes
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/cyber_organs/ears
	name = "DeForest (tm) DualWave (tm) Cybernetic Ears"
	item_type = /obj/item/storage/organbox/advanced_cyber_ears
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/cyber_organs/heart
	name = "DeForest (tm) LifeBlood (tm) Cybernetic Heart"
	item_type = /obj/item/storage/organbox/advanced_cyber_heart
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/cyber_organs/liver
	name = "DeForest (tm) FilterPure (tm) Cybernetic Liver"
	item_type = /obj/item/storage/organbox/advanced_cyber_liver
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/cyber_organs/lungs
	name = "DeForest (tm) TrueBreath (tm) Cybernetic Lungs"
	item_type = /obj/item/storage/organbox/advanced_cyber_lungs
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/deforest/cyber_organs/stomach
	name = "DeForest (tm) CleanBurn (tm) Cybernetic Stomach"
	item_type = /obj/item/storage/organbox/advanced_cyber_stomach
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = PASSED_INTEREST
