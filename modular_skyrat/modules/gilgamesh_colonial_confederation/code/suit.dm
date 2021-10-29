/obj/item/clothing/suit/armor/vest/russian/gcc
	name = "russian combined B23 vest"
	desc = "This body armor is designed to protect vital organs from being hit by small arms bullets, shell fragments, mines, grenades and melee weapons. It has a layer of lead plating to offer a very limited amount of radiation protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_green_armor"
	armor = list(MELEE = 50, BULLET = 40, LASER = 20, ENERGY = 30, BOMB = 35, BIO = 0, RAD = 20, FIRE = 50, ACID = 50, WOUND = 20)
	mutant_variants = NONE

/obj/item/clothing/suit/armor/heavy/gcc
	name = "russian Redut heavy armor"
	desc = "vodka"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_heavy_armor"
	armor = list(MELEE = 70, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 100, BIO = 100, RAD = 100, FIRE = 90, ACID = 90)
	slowdown = 2
	equip_delay_self = 5 SECONDS
	mutant_variants = STYLE_DIGITIGRADE
