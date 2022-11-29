#define ARMAMENT_CATEGORY_MODULES "MODsuit Modules"
#define ARMAMENT_CATEGORY_MODULES_LIMIT 2

/datum/armament_entry/assault_operatives/modules
	category = ARMAMENT_CATEGORY_MODULES
	category_item_limit = ARMAMENT_CATEGORY_MODULES_LIMIT

/datum/armament_entry/assault_operatives/modules/noslip
	item_type = /obj/item/mod/module/noslip
	cost = 3
	
/datum/armament_entry/assault_operatives/modules/night_vision
	item_type = /obj/item/mod/module/visor/night
	cost = 2
	
/datum/armament_entry/assault_operatives/modules/flamethrower
	item_type = /obj/item/mod/module/flamethrower
	cost = 3

/datum/armament_entry/assault_operatives/modules/chameleon
	item_type = /obj/item/mod/module/chameleon
	cost = 1

/datum/armament_entry/assault_operatives/modules/thermal
	item_type = /obj/item/mod/module/visor/thermal
	cost = 5

/datum/armament_entry/assault_operatives/modules/energy_shield
	description = "Projects three forcefields around the suit which protecting the user from incoming attacks. The forcefields will rapidly recharge while not under fire."
	item_type = /obj/item/mod/module/energy_shield
	cost = 8
	
/datum/armament_entry/assault_operatives/modules/cloak
	item_type = /obj/item/mod/module/stealth
	cost = 4
	
/datum/armament_entry/assault_operatives/modules/carry
	item_type = /obj/item/mod/module/quick_carry/advanced
	cost = 2

