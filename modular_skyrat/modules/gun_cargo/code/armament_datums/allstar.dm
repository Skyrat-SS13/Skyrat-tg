#define ARMAMENT_CATEGORY_ALLSTAR "Allstar Lasers"

/datum/armament_entry/cargo_gun/allstar
	category = ARMAMENT_CATEGORY_ALLSTAR
	company_bitflag = COMPANY_ALLSTAR

/datum/armament_entry/cargo_gun/allstar/laser
	subcategory = ARMAMENT_SUBCATEGORY_LASER

/datum/armament_entry/cargo_gun/allstar/laser/sc1
	item_type = /obj/item/gun/energy/laser

/datum/armament_entry/cargo_gun/allstar/laser/sc2
	item_type = /obj/item/gun/energy/e_gun
	cost = 1

/datum/armament_entry/cargo_gun/allstar/laser/sc3
	item_type = /obj/item/gun/energy/laser/hellgun/blueshield
	cost = 1

/datum/armament_entry/cargo_gun/allstar/laser/disabler
	item_type = /obj/item/gun/energy/disabler
	cost = 1

/datum/armament_entry/cargo_gun/allstar/laser/dragnet
	item_type = /obj/item/gun/energy/e_gun/dragnet
	cost = 1

/datum/armament_entry/cargo_gun/allstar/gunkit
	subcategory = ARMAMENT_SUBCATEGORY_GUNPART
	is_gun = FALSE

/datum/armament_entry/cargo_gun/allstar/gunkit/tempgun
	item_type = /obj/item/weaponcrafting/gunkit/temperature
	cost = 1

/datum/armament_entry/cargo_gun/allstar/gunkit/adv_egun
	item_type = /obj/item/weaponcrafting/gunkit/nuclear
	cost = 1

/datum/armament_entry/cargo_gun/allstar/gunkit/ion
	item_type = /obj/item/weaponcrafting/gunkit/ion
	cost = 1

/datum/armament_entry/cargo_gun/allstar/gunkit/hellfire
	item_type = /obj/item/weaponcrafting/gunkit/hellgun
	cost = 1
