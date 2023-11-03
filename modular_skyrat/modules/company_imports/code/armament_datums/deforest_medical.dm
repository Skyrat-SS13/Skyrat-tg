/datum/armament_entry/company_import/deforest
	category = DEFOREST_MEDICAL_NAME
	company_bitflag = CARGO_COMPANY_DEFOREST

// Basic first aid supplies like gauze, sutures, mesh, so on

/datum/armament_entry/company_import/deforest/first_aid
	subcategory = "First-Aid Consumables"

/datum/armament_entry/company_import/deforest/first_aid/gauze
	item_type = /obj/item/stack/medical/gauze/twelve
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/deforest/first_aid/bruise_pack
	item_type = /obj/item/stack/medical/bruise_pack
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/deforest/first_aid/ointment
	item_type = /obj/item/stack/medical/ointment
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/deforest/first_aid/suture
	item_type = /obj/item/stack/medical/suture
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/deforest/first_aid/mesh
	item_type = /obj/item/stack/medical/mesh
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/deforest/first_aid/bone_gel
	item_type = /obj/item/stack/medical/bone_gel
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/deforest/first_aid/medicated_sutures
	item_type = /obj/item/stack/medical/suture/medicated
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/deforest/first_aid/advanced_mesh
	item_type = /obj/item/stack/medical/mesh/advanced
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/deforest/medpens
	subcategory = "Medical Autoinjectors"
	cost = PAYCHECK_COMMAND * 1.5

/datum/armament_entry/company_import/deforest/medpens/occuisate
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/occuisate

/datum/armament_entry/company_import/deforest/medpens/morpital
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/morpital

/datum/armament_entry/company_import/deforest/medpens/lipital
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/lipital

/datum/armament_entry/company_import/deforest/medpens/meridine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/meridine

/datum/armament_entry/company_import/deforest/medpens/calopine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/calopine

/datum/armament_entry/company_import/deforest/medpens/coagulants
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/coagulants

/datum/armament_entry/company_import/deforest/medpens/lepoturi
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi

/datum/armament_entry/company_import/deforest/medpens/psifinil
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/psifinil

/datum/armament_entry/company_import/deforest/medpens/halobinin
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/halobinin

/datum/armament_entry/company_import/deforest/medpens_stim/pentibinin
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin
	contraband = TRUE

/datum/armament_entry/company_import/deforest/medpens_stim
	subcategory = "Stimulant Autoinjectors"
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/medpens_stim/adrenaline
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline

/datum/armament_entry/company_import/deforest/medpens_stim/synephrine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/synephrine

/datum/armament_entry/company_import/deforest/medpens_stim/krotozine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/krotozine

/datum/armament_entry/company_import/deforest/medpens_stim/vitatate
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/vitatate

/datum/armament_entry/company_import/deforest/medpens_stim/aranepaine
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine
	contraband = TRUE

/datum/armament_entry/company_import/deforest/medpens_stim/synalvipitol
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol
	contraband = TRUE

/datum/armament_entry/company_import/deforest/medpens_stim/twitch
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/twitch
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE

/datum/armament_entry/company_import/deforest/medpens_stim/demoneye
	item_type = /obj/item/reagent_containers/hypospray/medipen/deforest/demoneye
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE


// Equipment, from defibs to scanners to surgical tools

/datum/armament_entry/company_import/deforest/equipment
	subcategory = "Medical Equipment"

/datum/armament_entry/company_import/deforest/equipment/health_analyzer
	item_type = /obj/item/healthanalyzer
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/deforest/equipment/loaded_defib
	item_type = /obj/item/defibrillator/loaded
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/deforest/equipment/surgical_tools
	item_type = /obj/item/surgery_tray/full
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/deforest/equipment/advanced_health_analyer
	item_type = /obj/item/healthanalyzer/advanced
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/deforest/equipment/penlite_defib_mount
	item_type = /obj/item/wallframe/defib_mount/charging
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/deforest/equipment/advanced_scalpel
	item_type = /obj/item/scalpel/advanced
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/deforest/equipment/advanced_retractor
	item_type = /obj/item/retractor/advanced
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/deforest/equipment/advanced_cautery
	item_type = /obj/item/cautery/advanced
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/deforest/equipment/medigun_upgrade
	item_type = /obj/item/device/custom_kit/medigun_fastcharge
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/equipment/afad
	item_type = /obj/item/gun/medbeam/afad
	cost = PAYCHECK_COMMAND * 5

// Modsuit Modules from the medical category, here instead of in Nakamura because nobody buys from this company

/datum/armament_entry/company_import/deforest/medical_modules
	subcategory = "MOD Medical Modules"
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/medical_modules/injector
	name = "MOD injector module"
	item_type = /obj/item/mod/module/injector

/datum/armament_entry/company_import/deforest/medical_modules/organ_thrower
	name = "MOD organ thrower module"
	item_type = /obj/item/mod/module/organ_thrower

/datum/armament_entry/company_import/deforest/medical_modules/patient_transport
	name = "MOD patient transport module"
	item_type = /obj/item/mod/module/criminalcapture/patienttransport

/datum/armament_entry/company_import/deforest/medical_modules/thread_ripper
	name = "MOD thread ripper module"
	item_type = /obj/item/mod/module/thread_ripper

/datum/armament_entry/company_import/deforest/medical_modules/surgical_processor
	name = "MOD surgical processor module"
	item_type = /obj/item/mod/module/surgical_processor

// Various advanced cybernetic organs, organ replacements for the rich

/datum/armament_entry/company_import/deforest/cyber_organs
	subcategory = "Premium Cybernetic Organs"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/deforest/cyber_organs/eyes
	name = "shielded cybernetic eyes"
	item_type = /obj/item/storage/organbox/advanced_cyber_eyes

/datum/armament_entry/company_import/deforest/cyber_organs/ears
	name = "upgraded cybernetic ears"
	item_type = /obj/item/storage/organbox/advanced_cyber_ears

/datum/armament_entry/company_import/deforest/cyber_organs/heart
	name = "upgraded cybernetic heart"
	item_type = /obj/item/storage/organbox/advanced_cyber_heart

/datum/armament_entry/company_import/deforest/cyber_organs/liver
	name = "upgraded cybernetic liver"
	item_type = /obj/item/storage/organbox/advanced_cyber_liver

/datum/armament_entry/company_import/deforest/cyber_organs/lungs
	name = "upgraded cybernetic lungs"
	item_type = /obj/item/storage/organbox/advanced_cyber_lungs

/datum/armament_entry/company_import/deforest/cyber_organs/stomach
	name = "upgraded cybernetic stomach"
	item_type = /obj/item/storage/organbox/advanced_cyber_stomach

/datum/armament_entry/company_import/deforest/cyber_organs/augments
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/deforest/cyber_organs/augments/nutriment
	name = "Nutriment pump implant"
	item_type = /obj/item/organ/internal/cyberimp/chest/nutriment

/datum/armament_entry/company_import/deforest/cyber_organs/augments/reviver
	name = "Reviver implant"
	item_type = /obj/item/organ/internal/cyberimp/chest/reviver

/datum/armament_entry/company_import/deforest/cyber_organs/augments/surgery_implant
	name = "surgical toolset implant"
	item_type = /obj/item/organ/internal/cyberimp/arm/surgery

/datum/armament_entry/company_import/deforest/cyber_organs/augments/breathing_tube
	name = "breathing tube implant"
	item_type = /obj/item/organ/internal/cyberimp/mouth/breathing_tube
