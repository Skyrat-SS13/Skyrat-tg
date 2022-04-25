// EXPLOSIVES
#define ARMAMENT_CATEGORY_EXPLOSIVES "Explosives"
#define ARMAMENT_CATEGORY_EXPLOSIVESLIMIT 4

/datum/armament_entry/assault_operatives/explosives
	category = ARMAMENT_CATEGORY_EXPLOSIVES
	category_item_limit = ARMAMENT_CATEGORY_EXPLOSIVESLIMIT
	max_purchase = 8

/datum/armament_entry/assault_operatives/explosives/minibomb
	item_type = /obj/item/grenade/syndieminibomb
	cost = 3

/datum/armament_entry/assault_operatives/explosives/frag
	item_type = /obj/item/grenade/frag
	cost = 2

/datum/armament_entry/assault_operatives/explosives/emp_grenade
	item_type = /obj/item/grenade/empgrenade
	cost = 1

/datum/armament_entry/assault_operatives/explosives/flashbang
	item_type = /obj/item/grenade/flashbang
	cost = 1

/datum/armament_entry/assault_operatives/explosives/c4
	item_type = /obj/item/grenade/c4
	cost = 1

/datum/armament_entry/assault_operatives/explosives/x4
	item_type = /obj/item/grenade/c4/x4
	cost = 2

/datum/armament_entry/assault_operatives/explosives/bag_of_smokes
	name = "bag of eight smoke grenades"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/smoke
	cost = 3

/datum/armament_entry/assault_operatives/explosives/bag_of_c4
	name = "bag of ten c4"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/c4
	cost = 6

/datum/armament_entry/assault_operatives/explosives/bag_of_x4
	name = "bag of three x4"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/x4
	cost = 4

/datum/armament_entry/assault_operatives/explosives/bomb
	name = "Syndicate Bomb"
	item_type = /obj/item/sbeacondrop/bomb
	cost = 7
	max_purchase = 1
