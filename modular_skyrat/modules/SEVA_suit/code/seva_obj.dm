/obj/item/clothing/suit/hooded/seva
	name = "SEVA suit"
	desc = "A fire-proof suit for exploring hot environments. Its design doesn't allow for upgrading with goliath plates."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/suit_digi.dmi'
	icon_state = "seva"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	w_class = WEIGHT_CLASS_BULKY
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/seva
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 50, FIRE = 100, ACID = 25, WOUND = 2)
	resistance_flags = FIRE_PROOF
	transparent_protection = HIDEJUMPSUIT
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)
	clothing_traits = TRAIT_GOLIATH_STUN

/obj/item/clothing/head/hooded/seva
	name = "SEVA hood"
	desc = "A fire-proof hood for exploring hot environments. Its design doesn't allow for upgrading with goliath plates."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "seva"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS
	cold_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 50, FIRE= 100, ACID = 25, WOUND = 1)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/gas/seva
	name = "SEVA mask"
	desc = "A face-covering plate that can be connected to an air supply. Intended for use with the SEVA Suit."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "seva"
	resistance_flags = FIRE_PROOF
