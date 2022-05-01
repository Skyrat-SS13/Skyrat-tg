#define ARMAMENT_CATEGORY_UTILITY "Utility Supplies"
#define ARMAMENT_CATEGORY_UTILITY_LIMIT 8
#define ARMAMENT_SUBCATEGORY_UTILITY_ARMOR "Armor"

/datum/armament_entry/assault_operatives/utility
	category = ARMAMENT_CATEGORY_UTILITY
	category_item_limit = ARMAMENT_CATEGORY_UTILITY_LIMIT

/datum/armament_entry/assault_operatives/utility/armor
	subcategory = ARMAMENT_SUBCATEGORY_UTILITY_ARMOR

/datum/armament_entry/assault_operatives/utility/armor/elite_modsuit
	name = "Elite Syndicate MODsuit"
	item_type = /obj/item/mod/control/pre_equipped/elite
	cost = 8

/datum/armament_entry/assault_operatives/utility/armor/infiltrator
	name = "Infiltrator Bundle"
	item_type = /obj/item/storage/toolbox/infiltrator
	cost = 4

/datum/armament_entry/assault_operatives/utility/gun_maint
	item_type = /obj/item/gun_maintenance_supplies
	cost = 1
	max_purchase = 5

/datum/armament_entry/assault_operatives/utility/survival_pack
	item_type = /obj/item/storage/box/nri_survival_pack
	cost = 1

/datum/armament_entry/assault_operatives/utility/thermals
	item_type = /obj/item/clothing/glasses/thermal
	cost = 4

/datum/armament_entry/assault_operatives/utility/sunglasses
	item_type = /obj/item/clothing/glasses/sunglasses
	cost = 1

/datum/armament_entry/assault_operatives/utility/doorjack
	item_type = /obj/item/card/emag/doorjack
	name = "Doorjack"
	description = "Hacks open doors permanently."
	cost = 3

/datum/armament_entry/assault_operatives/utility/emag
	item_type = /obj/item/card/emag
	name = "Cryptographic Sequencer"
	description = "Subverts electronics."
	cost = 3

/datum/armament_entry/assault_operatives/utility/pouch
	item_type = /obj/item/storage/bag/ammo
	cost = 1

/datum/armament_entry/assault_operatives/utility/pouch_knives
	item_type = /obj/item/storage/bag/ammo/marksman
	description = "A pouch that contains five throwing knives. They are capable of embedding into targets and penetrating protective armor."
	cost = 3
	max_purchase = 3

/datum/armament_entry/assault_operatives/utility/toolbox
	item_type = /obj/item/storage/toolbox/syndicate
	cost = 1

/datum/armament_entry/assault_operatives/utility/dehy_carp
	item_type = /obj/item/toy/plush/carpplushie/dehy_carp
	cost = 1

/datum/armament_entry/assault_operatives/utility/tactical_shield
	item_type = /obj/item/shield/riot/pointman
	cost = 2

/datum/armament_entry/assault_operatives/utility/extending_shield
	item_type = /obj/item/shield/riot/tele
	cost = 5

/datum/armament_entry/assault_operatives/utility/noslip
	name = "Chameleon No-Slips"
	item_type = /obj/item/clothing/shoes/chameleon/noslip
	description = "No-slip chameleon shoes, for when you plan on running through hell and back."
	cost = 2

/datum/armament_entry/assault_operatives/utility/holoparasite
	item_type = /obj/item/guardiancreator/tech/choose/traitor
	cost = 9

/datum/armament_entry/assault_operatives/utility/launchpad
	name = "Briefcase Launchpad"
	item_type = /obj/item/storage/briefcase/launchpad
	description = "A briefcase containing a launchpad, a device able to teleport items and people to and from targets up to eight tiles away from the briefcase. \
			Also includes a remote control, disguised as an ordinary folder. Touch the briefcase with the remote to link it."
	cost = 3

/datum/armament_entry/assault_operatives/utility/syndiejaws
	name = "Syndicate Jaws of Life"
	item_type = /obj/item/crowbar/power/syndicate
	description = "Based on a Nanotrasen model, this powerful tool can be used as both a crowbar and a pair of wirecutters. \
	In its crowbar configuration, it can be used to force open airlocks. Very useful for entering the station or its departments."
	cost = 3

/datum/armament_entry/assault_operatives/utility/jammer
	name = "Radio Jammer"
	description = "When activated, this cell powered device will block all outgoing radio communication."
	item_type = /obj/item/jammer
	cost = 4
	
/datum/armament_entry/assault_operatives/utility/deluxe_id
	name = "Deluxe Agent ID Card"
	item_type = /obj/item/card/id/advanced/chameleon/black
	cost = 5

/datum/armament_entry/assault_operatives/utility/codespeak
	item_type = /obj/item/language_manual/codespeak_manual/unlimited
	cost = 1

/datum/armament_entry/assault_operatives/utility/throwing_weapons
	name = "Throwing Weapons Kit"
	description = "A box of shurikens and reinforced bolas from ancient Earth martial arts. They are highly effective throwing weapons. The bolas can knock a target down and the shurikens will embed into limbs."
	item_type = /obj/item/storage/box/syndie_kit/throwing_weapons
	cost = 3
	max_purchase = 3
	
/datum/armament_entry/assault_operatives/utility/binoculars
	item_type = /obj/item/binoculars
	cost = 1
	
/datum/armament_entry/assault_operatives/utility/emp_flashlight
	name = "EMP Flashlight"
	description = "Flash this at someone to hit them with an electromagnetic pulse."
	item_type = /obj/item/flashlight/emp
	cost = 2
