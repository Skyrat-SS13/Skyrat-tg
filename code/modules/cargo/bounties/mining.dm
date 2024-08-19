/datum/bounty/item/mining/goliath_steaks
	name = "Lava-Cooked Goliath Steaks"
	description = "Admiral Pavlov has gone on hunger strike ever since the canteen started serving only monkey and monkey byproducts. She is demanding lava-cooked goliath steaks."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/food/meat/steak/goliath = TRUE)

/datum/bounty/item/mining/goliath_boat
	name = "Goliath Hide Boat"
	description = "Commander Menkov wants to participate in the annual Lavaland Regatta. He is asking your shipwrights to build the swiftest boat known to man."
	reward = CARGO_CRATE_VALUE * 20
	wanted_types = list(/obj/vehicle/ridden/lavaboat = TRUE)

/datum/bounty/item/mining/bone_oar
	name = "Bone Oars"
	description = "Commander Menkov requires oars to participate in the annual Lavaland Regatta. Ship a pair over."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 2
	wanted_types = list(/obj/item/oar = TRUE)

//SKYRAT EDIT REMOVAL
/*
/datum/bounty/item/mining/bone_axe
	name = "Bone Axe"
	description = "Station 12 has had their fire axes stolen by marauding clowns. Ship them a bone axe as a replacement."
	reward = CARGO_CRATE_VALUE * 15
	wanted_types = list(/obj/item/fireaxe/boneaxe = TRUE)
*/
//END SKYRAT EDIT REMOVAL

/datum/bounty/item/mining/bone_armor
	name = "Bone Armor"
	description = "Station 14 has volunteered their lizard crew for ballistic armor testing. Ship over some bone armor."
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(/obj/item/clothing/suit/armor/bone = TRUE)

/datum/bounty/item/mining/skull_helmet
	name = "Skull Helmet"
	description = "Station 42's Head of Security has her birthday tomorrow! We want to suprise her with a fashionable skull helmet."
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/clothing/head/helmet/skull = TRUE)

/datum/bounty/item/mining/bone_talisman
	name = "Bone Talismans"
	description = "Station 14's Research Director claims that pagan bone talismans protect their wearer. Ship them a few so they can start testing."
	reward = CARGO_CRATE_VALUE * 15
	required_count = 3
	wanted_types = list(/obj/item/clothing/accessory/talisman = TRUE)
	
/datum/bounty/item/mining/watcher_wreath
	name = "Watcher Wreaths"
	description = "Station 14's Research Director thinks they're onto a break-through on the cultural icons of some pagan beliefs. Ship them a few watcher wreaths for analysis."
	include_subtypes = FALSE
	reward = CARGO_CRATE_VALUE * 15
	required_count = 3
	wanted_types = list(/obj/item/clothing/neck/wreath = TRUE)

/datum/bounty/item/mining/icewing_wreath
	name = "Icewing Wreath"
	description = "We're getting some....weird messages from Station 14's Research Director. And most of what they said was incoherent. But they apparently want an icewing wreath. Could you send them one?"
	reward = CARGO_CRATE_VALUE * 30
	required_count = 1
	wanted_types = list(/obj/item/clothing/neck/wreath/icewing = TRUE)
	
//SKYRAT EDIT REMOVAL
/*
/datum/bounty/item/mining/bone_dagger
	name = "Bone Daggers"
	description = "Central Command's canteen is undergoing budget cuts. Ship over some bone daggers so our chef can keep working."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/knife/combat/bone = TRUE)
*/
//END SKYRAT EDIT REMOVAL

/datum/bounty/item/mining/polypore_mushroom
	name = "Mushroom Bowl"
	description = "Lieutenant Jeb dropped his favorite mushroom bowl. Cheer him up by shipping a new one, will you?"
	reward = CARGO_CRATE_VALUE * 15 //5x mushroom shavings
	wanted_types = list(/obj/item/reagent_containers/cup/bowl/mushroom_bowl = TRUE)

/datum/bounty/item/mining/inocybe_mushroom
	name = "Mushroom Caps"
	description = "Our botanist claims that he can distill tasty liquor from absolutely any plant. Let's see what he'll do with Inocybe mushroom caps."
	reward = CARGO_CRATE_VALUE * 9
	required_count = 3
	wanted_types = list(/obj/item/food/grown/ash_flora/mushroom_cap = TRUE)

/datum/bounty/item/mining/porcini_mushroom
	name = "Mushroom Leaves"
	description = "Porcini mushroom leaves are rumored to have healing properties. Our researchers want to put that claim to the test."
	reward = CARGO_CRATE_VALUE * 9
	required_count = 3
	wanted_types = list(/obj/item/food/grown/ash_flora/mushroom_leaf = TRUE)
