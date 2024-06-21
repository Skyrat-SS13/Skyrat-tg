#define OPS_SUBCATEGORY_LETHAL_SIDE "Lethal"
#define OPS_SUBCATEGORY_NONLETHAL_SIDE "Non-Lethal"
#define OPS_SUBCATEGORY_MARTIAL_SIDE "Martial Arts"

/datum/armament_entry/assault_operatives/secondary
	category = "Side Arms"
	category_item_limit = 3
	mags_to_spawn = 3
	cost = 3

/datum/armament_entry/assault_operatives/secondary/lethal
	subcategory = OPS_SUBCATEGORY_LETHAL_SIDE

/datum/armament_entry/assault_operatives/secondary/lethal/pistol
	item_type = /obj/item/gun/ballistic/automatic/pistol/sol/evil

/datum/armament_entry/assault_operatives/secondary/lethal/energy_sword
	item_type = /obj/item/melee/energy/sword/saber

/datum/armament_entry/assault_operatives/secondary/nonlethal
	subcategory = OPS_SUBCATEGORY_NONLETHAL_SIDE

/datum/armament_entry/assault_operatives/secondary/nonlethal/taze_me_bro
	item_type = /obj/item/gun/energy/e_gun/advtaser

/datum/armament_entry/assault_operatives/secondary/nonlethal/baton
	item_type = /obj/item/melee/baton/telescopic

/datum/armament_entry/assault_operatives/secondary/martial
	subcategory = OPS_SUBCATEGORY_MARTIAL_SIDE

/datum/armament_entry/assault_operatives/secondary/martial/krav_gloves
	item_type = /obj/item/clothing/gloves/krav_maga/combatglovesplus

/datum/armament_entry/assault_operatives/secondary/martial/cqc
	item_type = /obj/item/book/granter/martial/cqc

#undef OPS_SUBCATEGORY_LETHAL_SIDE
#undef OPS_SUBCATEGORY_NONLETHAL_SIDE
#undef OPS_SUBCATEGORY_MARTIAL_SIDE
