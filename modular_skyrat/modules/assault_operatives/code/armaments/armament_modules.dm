#define ARMAMENT_CATEGORY_MODULES "MODsuit Modules"
#define ARMAMENT_CATEGORY_MODULES_LIMIT 2

/datum/armament_entry/assault_operatives/modules
	category = ARMAMENT_CATEGORY_MODULES
	category_item_limit = ARMAMENT_CATEGORY_MODULES_LIMIT

/datum/armament_entry/assault_operatives/modules/noslip
	item_type = /obj/item/mod/module/noslip
	cost = 3
	
/datum/armament_entry/assault_operatives/modules/flamethrower
	item_type = /obj/item/mod/module/flamethrower
	cost = 3
	
/datum/armament_entry/assault_operatives/modules/energy_shield
	description = "Projects three self recharging forcefields around the suit, protecting the user from incoming attacks."
	item_type = /obj/item/mod/module/energy_shield
	cost = 5
