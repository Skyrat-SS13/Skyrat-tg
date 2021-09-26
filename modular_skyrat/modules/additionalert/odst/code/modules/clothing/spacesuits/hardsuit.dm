/obj/item/clothing/head/helmet/space/hardsuit/odst
	name = "orbital drop shock trooper helmet"
	desc = "The helmet of a shocktrooper's hardsuit. It's sturdy and reinforced."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit0-odst"
	hardsuit_type = "odst"

/obj/item/clothing/suit/space/hardsuit/odst
	name = "orbital drop shock trooper hardsuit"
	desc = "The hardsuit of a shocktrooper. It's lightweight, yet sturdy and reinforced. "
	alt_desc = "The hardsuit of a shocktrooper. It's lightweight, yet sturdy and reinforced. "
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	icon_state = "ert_odst"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_state = "ert_odst"
	inhand_icon_state = "ert_security"
	hardsuit_type = "odst"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/odst
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword, /obj/item/tank/internals)
	armor = list(MELEE = 65, BULLET = 50, LASER = 50, ENERGY = 60, BOMB = 55, BIO = 100, RAD = 70, FIRE = 100, ACID = 100, WOUND = 65)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = 0
	cell = /obj/item/stock_parts/cell/bluespace
