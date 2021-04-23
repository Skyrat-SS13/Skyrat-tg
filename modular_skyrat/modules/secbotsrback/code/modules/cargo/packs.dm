/datum/supply_pack/science/secbotpack
	name = "Securitron Parts Crate"
	desc = "The parts you need to replace those unrobust security officers with a robust robot army! Contains parts for one Securitron brand security robot. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_SECURITY
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/botpack/secbot)
	crate_name = "securitron part crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/ed209pack
	name = "ED-209 Parts Crate"
	desc = "The parts you need to ahnillate and destroy crime, permanently! Contains parts for one ED-209 brand security robot. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_SECURITY
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/botpack/ed209)
	crate_name = "ED-209 part crate"
	crate_type = /obj/structure/closet/crate/secure/science
