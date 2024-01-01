#define ARMAMENT_CATEGORY_UTILITY "Utility"

/datum/armament_entry/hecu/utility
	category = ARMAMENT_CATEGORY_UTILITY
	category_item_limit = 20

/datum/armament_entry/hecu/utility/survival_pack
	item_type = /obj/item/storage/box/nri_survival_pack
	max_purchase = 4
	cost = 3

/datum/armament_entry/hecu/utility/pouch
	item_type = /obj/item/storage/pouch/ammo
	max_purchase = 8
	cost = 1

/datum/armament_entry/hecu/utility/pouch_knives
	item_type = /obj/item/storage/pouch/ammo/marksman
	max_purchase = 4
	cost = 3

/datum/armament_entry/hecu/utility/basic_tools
	item_type = /obj/item/storage/toolbox/mechanical
	max_purchase = 2
	cost = 1

/datum/armament_entry/hecu/utility/advanced_tools
	name = "Powertoolbelt"
	description = "Tool belt full of power-ful tools."
	item_type = /obj/item/storage/belt/utility/full/powertools
	max_purchase = 1
	cost = 4

/datum/armament_entry/hecu/utility/light_device
	item_type = /obj/item/construction/rld/mini
	max_purchase = 2
	cost = 3

/datum/armament_entry/hecu/utility/compact_shield
	item_type = /obj/item/shield/riot/tele
	max_purchase = 1
	cost = 5

/datum/armament_entry/hecu/utility/flash_shield
	item_type = /obj/item/shield/riot/flash
	max_purchase = 1
	cost = 10

/datum/armament_entry/hecu/utility/combat_shield
	item_type = /obj/item/shield/riot/pointman/hecu
	max_purchase = 1
	cost = 20

/datum/armament_entry/hecu/utility/zipties
	item_type = /obj/item/storage/box/zipties
	max_purchase = 2
	cost = 1

/datum/armament_entry/hecu/utility/suppressor
	item_type = /obj/item/suppressor/standard
	max_purchase = 4
	cost = 2

/datum/armament_entry/hecu/utility/bowman
	item_type = /obj/item/radio/headset/headset_faction/bowman
	max_purchase = 3
	cost = 4

/datum/armament_entry/hecu/utility/breaching_hammer //Mesa more like R6S amirite
	item_type = /obj/item/melee/breaching_hammer
	max_purchase = 1
	cost = 4

#undef ARMAMENT_CATEGORY_UTILITY
