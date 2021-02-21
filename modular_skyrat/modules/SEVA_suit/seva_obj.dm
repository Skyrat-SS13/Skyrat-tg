/obj/item/clothing/suit/hooded/explorer/seva
	name = "SEVA Suit"
	desc = "A fire-proof suit for exploring hot environments. Its design doesn't allow for upgrading with goliath plates."
	icon = 'modular_skyrat/modules/SEVA_suit/icons/seva_suit.dmi'
	worn_icon = 'modular_skyrat/modules/SEVA_suit/icons/equipped/seva_suit.dmi'
	worn_icon_digi = 'modular_skyrat/modules/SEVA_suit/icons/equipped/seva_suit_digi.dmi'
	icon_state = "seva"
	w_class = WEIGHT_CLASS_BULKY
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/explorer/seva
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 35, "bio" = 50, "rad" = 25, "fire" = 100, "acid" = 25, "wound" = 5)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/hooded/explorer/seva
	name = "SEVA Hood"
	desc = "A fire-proof hood for exploring hot environments. Its design doesn't allow for upgrading with goliath plates."
	icon = 'modular_skyrat/modules/SEVA_suit/icons/seva_hat.dmi'
	worn_icon = 'modular_skyrat/modules/SEVA_suit/icons/equipped/seva_head.dmi'
	icon_state = "seva"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 35, "bio" = 50, "rad" = 25, "fire" = 100, "acid" = 25, "wound" = 5)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/gas/seva
	name = "SEVA Mask"
	desc = "A face-covering plate that can be connected to an air supply. Intended for use with the SEVA Suit."
	icon = 'modular_skyrat/modules/SEVA_suit/icons/seva_mask.dmi'
	worn_icon = 'modular_skyrat/modules/SEVA_suit/icons/equipped/seva_mask.dmi'
	worn_icon_muzzled = 'modular_skyrat/modules/SEVA_suit/icons/equipped/seva_mask_muzzled.dmi'
	icon_state = "seva"
	resistance_flags = FIRE_PROOF
