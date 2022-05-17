#define ARMAMENT_CATEGORY_JORNS "Jarnsmiour Blacksteel Foundation"

/datum/armament_entry/cargo_gun/jorns
	category = ARMAMENT_CATEGORY_JORNS
	company_bitflag = COMPANY_JORNS

/datum/armament_entry/cargo_gun/jorns/knife
	subcategory = ARMAMENT_SUBCATEGORY_KNIFE

/datum/armament_entry/cargo_gun/jorns/knife/bowie
	item_type = /obj/item/storage/belt/bowiesheath
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5
	

/datum/armament_entry/cargo_gun/jorns/knife/survival
	item_type = /obj/item/knife/combat/survival
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/cargo_gun/jorns/sword
	subcategory = ARMAMENT_SUBCATEGORY_SWORD
	
/datum/armament_entry/cargo_gun/jorns/sword/csabre
	item_type = /obj/item/storage/belt/sabre/cargo
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 6

