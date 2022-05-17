#define ARMAMENT_CATEGORY_JORNS "Jarnsmiour Blacksteel Foundation"

/datum/armament_entry/cargo_gun/jorns
	category = ARMAMENT_CATEGORY_JORNS
	company_bitflag = COMPANY_JORNS

/datum/armament_entry/cargo_gun/jorns/knife
	subcategory = ARMAMENT_SUBCATEGORY_KNIFE

/datum/armament_entry/cargo_gun/jorns/knife/bowie
	item_type = /obj/item/melee/knife/bowie
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5
	