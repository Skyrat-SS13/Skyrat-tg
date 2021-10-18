/****************Explorer's Suit and Mask****************/
/obj/item/clothing/suit/hooded/explorer
  name = "explorer suit"
	desc = "An armoured suit for exploring harsh environments."
  	icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'  //To keep the old version.
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi' //To keep the old version.
	icon_state = "explorer"
	inhand_icon_state = "explorer"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|ARMS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	hoodtype = /obj/item/clothing/head/hooded/explorer
	armor = list(MELEE = 30, BULLET = 10, LASER = 10, ENERGY = 20, BOMB = 50, BIO = 100, RAD = 50, FIRE = 50, ACID = 50)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/hooded/explorer
	name = "explorer hood"
	desc = "An armoured hood for exploring harsh environments."
  	icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi' //To keep the old version.
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi //To keep the old version.
	icon_state = "explorer"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor = list(MELEE = 30, BULLET = 10, LASER = 10, ENERGY = 20, BOMB = 50, BIO = 100, RAD = 50, FIRE = 50, ACID = 50, WOUND = 10)
	resistance_flags = FIRE_PROOF
