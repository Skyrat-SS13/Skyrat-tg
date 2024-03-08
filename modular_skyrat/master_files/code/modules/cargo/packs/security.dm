/datum/supply_pack/security/ammo
	special = TRUE

/datum/supply_pack/security/armor
	special = TRUE

/datum/supply_pack/security/disabler
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/security/helmets
	special = TRUE

/datum/supply_pack/security/securityclothes
	special = TRUE

/datum/supply_pack/security/armory/thermal
	access = ACCESS_SECURITY
	access_view = ACCESS_SECURITY

/datum/supply_pack/security/armory/ballistic
	name = "Peacekeeper Combat Shotguns Crates"
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat = 3,
					/obj/item/storage/belt/bandolier = 3)
