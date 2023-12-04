/datum/supply_pack/medical/civil_defense
	name = "Civil Defense Medical Kit Crate"
	crate_name = "civil defense medical kit crate"
	desc = "Contains five civil defense medical kits, small packs of injectors meant to be passed out to the public in case of emergency."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10 // 2000
	contains = list(
		/obj/item/storage/medkit/civil_defense/stocked = 5,
	)

/datum/supply_pack/medical/frontier_first_aid
	name = "Frontier First Aid Crate"
	crate_name = "frontier first aid crate"
	desc = "Contains two of each of frontier medical kits, and combat surgeon medical kits."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/medkit/frontier/stocked = 2,
		/obj/item/storage/medkit/combat_surgeon/stocked = 2,
	)

/datum/supply_pack/medical/heavy_duty_medical
	name = "Heavy Duty Medical Kit Crate"
	crate_name = "heavy duty medical kit crate"
	desc = "Contains a large satchel medical kit, and a first responder surgical kit."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked,
		/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked,
	)
