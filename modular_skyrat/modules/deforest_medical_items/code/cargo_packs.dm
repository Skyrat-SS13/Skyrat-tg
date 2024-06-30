/datum/supply_pack/medical/civil_defense
	name = "Civil Defense Medical Kit Crate"
	crate_name = "civil defense medical kit crate"
	desc = "Contains ten civil defense medical kits, small packs of injectors meant to be passed out to the public in case of emergency."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10 // 2000
	contains = list(
		/obj/item/storage/medkit/civil_defense/stocked = 10,
	)

/datum/supply_pack/medical/frontier_first_aid
	name = "Frontier First Aid Crate"
	crate_name = "frontier first aid crate"
	desc = "Contains three of each of frontier medical kits, and combat surgeon medical kits."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/medkit/frontier/stocked = 3,
		/obj/item/storage/medkit/combat_surgeon/stocked = 3,
	)

/datum/supply_pack/medical/kit_medical_surgical
	name = "Heavy Duty Medical Kit Crate - Medical/Surgical"
	crate_name = "heavy duty medical kit crate"
	desc = "Contains a large satchel medical kit, and a first responder surgical kit."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked,
		/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked,
	)

/datum/supply_pack/medical/kit_surgical_technician
	name = "Heavy Duty Medical Kit Crate - Surgical/Technician"
	crate_name = "heavy duty medical kit crate"
	desc = "Contains a first responder surgical kit, and a medical technician kit."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked,
		/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked,
	)

/datum/supply_pack/medical/kit_medical_technician
	name = "Heavy Duty Medical Kit Crate - Medical/Technician"
	crate_name = "heavy duty medical kit crate"
	desc = "Contains a large satchel medical kit, and a medical technician kit."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked,
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked,
	)

/datum/supply_pack/medical/deforest_vendor_refill
	name = "DeForest Med-Vend Resupply Crate"
	crate_name = "\improper DeForest Med-Vend resupply crate"
	desc = "Contains a restocking canister for DeForest Med-Vendors."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/vending_refill/medical_deforest,
	)
