#define ARMAMENT_CATEGORY_JARNS "Jarnsmiour Blacksteel Foundation"

/datum/armament_entry/cargo_gun/jarns
	category = ARMAMENT_CATEGORY_JARNS

/datum/armament_entry/cargo_gun/jarns/knife
	subcategory = ARMAMENT_SUBCATEGORY_KNIFE

/datum/armament_entry/cargo_gun/jarns/knife/bowie
	item_type = /obj/item/storage/belt/bowie_sheath
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5
	

/datum/armament_entry/cargo_gun/jarns/knife/survival
	item_type = /obj/item/knife/combat/survival
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/cargo_gun/jarns/sword
	subcategory = ARMAMENT_SUBCATEGORY_SWORD
	
/datum/armament_entry/cargo_gun/jarns/sword/csabre
	item_type = /obj/item/storage/belt/sabre/cargo
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 6

