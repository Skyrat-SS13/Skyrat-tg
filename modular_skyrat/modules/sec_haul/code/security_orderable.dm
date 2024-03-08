/datum/supply_pack/security/armory/wespe
	name = "Wespe Crate"
	desc = "Contains three case of the .35 sol handgun, magazines included."
	cost = CARGO_CRATE_VALUE * 8
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe = 3,
					/obj/item/storage/box/rubbershot = 3,
				)
	crate_name = "wespe pistols crate"

/datum/supply_pack/security/armory/eland
	name = "Eland Crate"
	desc = "Contains three case of the .35 sol revolver, munition boxes included."
	cost = CARGO_CRATE_VALUE * 8
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/beanbag = 3,
					/obj/item/storage/box/rubbershot = 3,
				)
	crate_name = "eland pistols crate"

