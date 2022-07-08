/obj/item/clothing/suit/armor/vest/russian
	name = "\improper B23 combined armor vest"
	desc = "A B23 combined body armor designed to protect the torso from bullets, shrapnel and blunt force. This vest performed well in the Border War against SolFed, but NRI required significant design changes due to the enemy's new and improved weaponry. These models were recently phased out and then quickly found their way onto the black market, now commonly seen in the hands (or on the bodies) of insurgents."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_green_armor_old"
	armor = list(MELEE = 30, BULLET = 40, LASER = 20, ENERGY = 30, BOMB = 35, BIO = 0, FIRE = 50, ACID = 50, WOUND = 15)
	inhand_icon_state = "rus_armor"

/obj/item/clothing/suit/armor/vest/russian/nri
	name = "\improper B42M combined armor vest"
	desc = "NRI's mass-produced body armor designed for protection against bullets, shrapnel and blunt force. A thin layer of experimental alloy provides limited protection against laser and energy."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_green_armor"
	armor = list(MELEE = 50, BULLET = 50, LASER = 30, ENERGY = 25, BOMB = 50, BIO = 0, FIRE = 50, ACID = 50, WOUND = 20)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/heavy/nri
	name = "\improper Cordun-M armor system"
	desc = "A robust set of full-body armor designed for the harshest of environments. A modern set of heavy armor recently implemented by NRI Defense Colleague to accomodate with modern specifications. While a combination of lighter materials and a passive internal exoskeleton might assist the user's movement, you'll still be as slow as a snail."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_heavy_armor"
	armor = list(MELEE = 60, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 100, BIO = 100, FIRE = 70, ACID = 70, WOUND = 35)
	slowdown = 1.5
	equip_delay_self = 5 SECONDS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/heavy/nri/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	if(is_species(M, /datum/species/teshari)) //racist armor
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

/obj/item/clothing/suit/armor/heavy/nri/old
	name = "\improper REDUT armor system"
	desc = "A strong set of full-body armor designed for harsh environments. After the NRI withdrew them, these models found their way onto the black market and have been rarely used by freelance mercenaries and planetary militias ever since, because of their relatively low cost."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_heavy_armor_old"
	armor = list(MELEE = 50, BULLET = 50, LASER = 40, ENERGY = 40, BOMB = 75, BIO = 60, FIRE = 45, ACID = 45, WOUND = 20)
	slowdown = 2
