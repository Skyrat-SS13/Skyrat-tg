/obj/item/clothing/suit/armor/vest/russian
	name = "russian combined B23 vest"
	desc = "A bulletproof vest with forest camo. Good thing there's plenty of forests to hide in around here, right?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_green_armor"
	inhand_icon_state = "rus_armor"
	armor = list(MELEE = 25, BULLET = 30, LASER = 0, ENERGY = 10, BOMB = 10, BIO = 0, FIRE = 20, ACID = 50, WOUND = 10)

/obj/item/clothing/suit/armor/vest/russian/nri
	name = "russian combined B23 vest"
	desc = "NRI mass-produced body armor designed for protection against bullets, shrapnel and blunt force. A thin layer of experimental alloy provides limited protection against laser and energy and... polar bears?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_green_armor"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 25, "bomb" = 50, "bio" = 0, "fire" = 50, "acid" = 50, "wound" = 20)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/heavy/nri
	name = "REDUT armor system"
	desc = "A strong set of full-body armor designed for harsh environments. It has nothing in it to aid the user's movement."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "russian_heavy_armor"
	armor = list("melee" = 60, "bullet" = 60, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "fire" = 70, "acid" = 70, "wound" = 35)
	slowdown = 1.5
	equip_delay_self = 5 SECONDS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/heavy/nri/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	if(is_species(M, /datum/species/teshari)) //racist armor
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

