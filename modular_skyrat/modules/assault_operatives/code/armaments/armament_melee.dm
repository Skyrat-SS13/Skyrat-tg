
// MELEE WEAPONS
#define ARMAMENT_CATEGORY_MELEE "Melee Weapons"
#define ARMAMENT_CATEGORY_MELEE_LIMIT 1

/datum/armament_entry/assault_operatives/melee
	category = ARMAMENT_CATEGORY_MELEE
	category_item_limit = ARMAMENT_CATEGORY_MELEE_LIMIT

/datum/armament_entry/assault_operatives/melee/combat_knife
	item_type = /obj/item/knife/combat
	cost = 7

/datum/armament_entry/assault_operatives/melee/survival_knife
	item_type = /obj/item/knife/combat/survival
	cost = 5

/datum/armament_entry/assault_operatives/melee/energy
	item_type = /obj/item/melee/energy/sword
	cost = 10

/datum/armament_entry/assault_operatives/melee/baton
	item_type = /obj/item/melee/baton/security/loaded
	cost = 3

/datum/armament_entry/assault_operatives/melee/baton_telescopic
	item_type = /obj/item/melee/baton/telescopic
	cost = 5

