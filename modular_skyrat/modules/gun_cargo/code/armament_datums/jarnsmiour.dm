#define ARMAMENT_CATEGORY_JARNSMIOUR "Jarnsmiour Blacksteel Foundation"

/datum/armament_entry/cargo_gun/jarns
	category = ARMAMENT_CATEGORY_JARNSMIOUR
	company_bitflag = COMPANY_JARNSMIOUR

/datum/armament_entry/cargo_gun/jarns/knife
	subcategory = ARMAMENT_SUBCATEGORY_CQC

/datum/armament_entry/cargo_gun/jarns/knife/survival
	item_type = /obj/item/knife/combat/survival
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1
	stock_mult = 2

/datum/armament_entry/cargo_gun/jarns/knife/bowie
	item_type = /obj/item/storage/belt/bowie_sheath
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/cargo_gun/jarns/knife/cargo_sabre
	item_type = /obj/item/storage/belt/sabre/cargo
	lower_cost = CARGO_CRATE_VALUE * 7
	upper_cost = CARGO_CRATE_VALUE * 8
