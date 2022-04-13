/obj/item/clothing/suit/armor/vest/russian/nri
	name = "russian combined B23 vest"
	desc = "Modern body armor designed to protect the torso from bullets, shrapnel and blunt force. A lead-plated layer offers a very limited amount of radiation protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_green_armor"
	armor = list(MELEE = 45, BULLET = 40, LASER = 20, ENERGY = 30, BOMB = 35, BIO = 0, FIRE = 50, ACID = 50, WOUND = 20)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/heavy/nri
	name = "REDUT armor system"
	desc = "A strong set of full-body armor designed for harsh environments. It has nothing in it to aid the user's movement."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_heavy_armor"
	armor = list(MELEE = 70, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 100, BIO = 100, FIRE = 90, ACID = 90)
	slowdown = 2
	equip_delay_self = 5 SECONDS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/heavy/nri/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	if(is_species(M, /datum/species/teshari))
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

