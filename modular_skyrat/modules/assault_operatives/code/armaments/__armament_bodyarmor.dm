// BODYARMOR
#define ARMAMENT_CATEGORY_ARMOR_BODY "Body Armor"
#define ARMAMENT_CATEGORY_ARMOR_BODY_LIMIT 1

/datum/armament_entry/assault_operatives/bodyarmor
	category = ARMAMENT_CATEGORY_ARMOR_BODY
	category_item_limit = ARMAMENT_CATEGORY_ARMOR_BODY_LIMIT
	slot_to_equip = ITEM_SLOT_OCLOTHING

/datum/armament_entry/assault_operatives/bodyarmor/normal
	item_type = /obj/item/clothing/suit/armor/vest
	cost = 3

/datum/armament_entry/assault_operatives/bodyarmor/bulletproof
	item_type = /obj/item/clothing/suit/armor/bulletproof
	cost = 5

/datum/armament_entry/assault_operatives/bodyarmor/laserproof
	item_type = /obj/item/clothing/suit/armor/laserproof
	cost = 5

/datum/armament_entry/assault_operatives/bodyarmor/swat
	item_type = /obj/item/clothing/suit/armor/swat
	cost = 5

/datum/armament_entry/assault_operatives/bodyarmor/marine
	item_type = /obj/item/clothing/suit/armor/vest/marine
	cost = 6

/datum/armament_entry/assault_operatives/bodyarmor/elite_modsuit
	name = "Elite Syndicate MODsuit"
	item_type = /obj/item/mod/control/pre_equipped/elite
	cost = 8
