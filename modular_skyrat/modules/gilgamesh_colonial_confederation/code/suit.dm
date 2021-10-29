/obj/item/clothing/suit/armor/vest/russian/gcc
	name = "russian combined B23 vest"
	desc = "Modern body armor designed to protect the torso from bullets, shrapnel and blunt force. A lead-plated layer offers a very limited amount of radiation protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_green_armor"
	armor = list(MELEE = 50, BULLET = 40, LASER = 20, ENERGY = 30, BOMB = 35, BIO = 0, RAD = 20, FIRE = 50, ACID = 50, WOUND = 20)
	mutant_variants = NONE

/obj/item/clothing/suit/armor/heavy/gcc
	name = "REDUT armor system"
	desc = "vodka"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_heavy_armor"
	armor = list(MELEE = 70, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 100, BIO = 100, RAD = 100, FIRE = 90, ACID = 90)
	slowdown = 2
	equip_delay_self = 5 SECONDS
	mutant_variants = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/heavy/gcc/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	if(is_species(M, /datum/species/teshari))
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

