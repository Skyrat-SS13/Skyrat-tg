/datum/supply_pack/vending/sectech
	name = "Peacekeeper Equipment Supply Crate"
	desc = "Armadyne branded Peacekeeper supply crate, filled with things you need to restock the equipment vendor."
	cost = CARGO_CRATE_VALUE * 3
	access = ACCESS_SECURITY
	contains = list(/obj/item/vending_refill/security_peacekeeper)
	crate_name = "Peacekeeper equipment supply crate"
	crate_type = /obj/structure/closet/crate/secure/gear

/datum/supply_pack/vending/wardrobes/security
	name = "Peacekeeper Wardrobe Supply Crate"
	desc = "This crate contains refills for the Peacekeeper Outfitting Station and LawDrobe."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/wardrobe/peacekeeper_wardrobe,
					/obj/item/vending_refill/wardrobe/law_wardrobe)
	crate_name = "security department supply crate"

/datum/supply_pack/security/primary_case
	name = "Primary Armory Token Crate"
	desc = "Contains a box of primary armory tokens for the Armadyne weapons vendor."
	cost = CARGO_CRATE_VALUE * 15
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/armament_tokens_primary)
	crate_name = "primary armory token crate"

/datum/supply_pack/security/energy_case
	name = "Energy Armory Token Crate"
	desc = "Contains a box of energy armory tokens for the Armadyne weapons vendor."
	cost = CARGO_CRATE_VALUE * 15
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/armament_tokens_energy)
	crate_name = "energy armory token crate"


/datum/supply_pack/security/red_uniforms
	name = "CorpSec Red Uniform Crate"
	desc = "A crate of red uniforms we had stored before outsourcing our security equipment. A darker color than we remem- oh wait that's just blood."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/under/rank/security/officer/red,
					/obj/item/clothing/under/rank/security/officer/red,
					/obj/item/clothing/under/rank/security/officer/red,
					/obj/item/clothing/under/rank/security/officer/skirt/red,
					/obj/item/clothing/under/rank/security/officer/skirt/red,
					/obj/item/clothing/under/rank/security/officer/skirt/red,
					/obj/item/clothing/under/rank/security/warden/red,
					/obj/item/clothing/under/rank/security/warden/skirt/red,
					/obj/item/clothing/under/rank/security/head_of_security/red,
					/obj/item/clothing/under/rank/security/head_of_security/skirt/red,
					/obj/item/clothing/suit/hooded/wintercoat/security/red,
					/obj/item/clothing/suit/hooded/wintercoat/security/red)
	crate_name = "red security uniform crate"
