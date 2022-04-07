// SECONDARY WEAPONS
/datum/armament_entry/hecu/secondary
	category = ARMAMENT_CATEGORY_SECONDARY
	category_item_limit = 4
	cost = 5
	mags_to_spawn = 2

/datum/armament_entry/hecu/secondary/pistol
	subcategory = ARMAMENT_SUBCATEGORY_PISTOL

/datum/armament_entry/hecu/secondary/pistol/m1911
	item_type = /obj/item/gun/ballistic/automatic/pistol/m1911
	max_purchase = 4

/datum/armament_entry/hecu/secondary/pistol/glock
	item_type = /obj/item/gun/ballistic/automatic/pistol/g17/mesa
	max_purchase = 4
	mags_to_spawn = 3

/datum/armament_entry/hecu/secondary/pistol/deagle
	item_type = /obj/item/gun/ballistic/automatic/pistol/deagle
	max_purchase = 1
	cost = 9
