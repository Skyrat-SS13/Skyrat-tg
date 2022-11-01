#define ARMAMENT_CATEGORY_JARNSMIOUR

/datum/armament_entry/cargo_gun/blacksteel
	category = "Jarnsmiour Blacksteel Foundation"

/datum/armament_entry/cargo_gun/blacksteel/blade
	subcategory = "Bladed Weapons"

/datum/armament_entry/cargo_gun/blacksteel/blade/hunting_knife
	item_type = /obj/item/knife/hunting
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1

/datum/armament_entry/cargo_gun/blacksteel/blade/hatchet
	item_type = /obj/item/hatchet/wooden
	lower_cost = CARGO_CRATE_VALUE * 0.7
	upper_cost = CARGO_CRATE_VALUE * 1.2

/datum/armament_entry/cargo_gun/blacksteel/blade/survival_knife
	item_type = /obj/item/knife/combat/survival
	lower_cost = CARGO_CRATE_VALUE * 1.2
	upper_cost = CARGO_CRATE_VALUE * 1.7

/datum/armament_entry/cargo_gun/blacksteel/blade/bowie_knife
	item_type = /obj/item/storage/belt/bowie_sheath
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/cargo_gun/blacksteel/blade/shamshir_sabre
	item_type = /obj/item/storage/belt/sabre/cargo
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 7

/datum/armament_entry/cargo_gun/blacksteel/forging_tools
	subcategory = "Premium Forging Equipment"

/datum/armament_entry/cargo_gun/blacksteel/forging_tools/billows
	item_type = /obj/item/forging/billow
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE * 0.4

/datum/armament_entry/cargo_gun/blacksteel/forging_tools/hammer
	item_type = /obj/item/forging/hammer
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE * 0.4

/datum/armament_entry/cargo_gun/blacksteel/forging_tools/tongs
	item_type = /obj/item/forging/tongs
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE * 0.4
