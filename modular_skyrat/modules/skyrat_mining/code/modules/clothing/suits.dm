/obj/item/clothing/suit/hooded/explorer/seva
	name = "SEVA Suit"
	desc = "A fire-proof suit for exploring hot environments. Its design and material make it easier for a Goliath to keep their grip on the wearer."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/suit.dmi'
	icon_state = "seva"
	w_class = WEIGHT_CLASS_BULKY
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/explorer/seva
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 35, "bio" = 50, "rad" = 25, "fire" = 100, "acid" = 25, "wound" = 5) //skyrat edit
	resistance_flags = FIRE_PROOF | GOLIATH_WEAKNESS

/obj/item/clothing/suit/hooded/explorer/exo
	name = "Exo-suit"
	desc = "A robust suit for fighting dangerous animals. Its design and material make it harder for a Goliath to keep their grip on the wearer."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/suit.dmi'
	icon_state = "exo"
	w_class = WEIGHT_CLASS_BULKY
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/explorer/exo
	armor = list("melee" = 55, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 40, "bio" = 25, "rad" = 10, "fire" = 0, "acid" = 0, "wound" = 13) //skyrat edit
	resistance_flags = FIRE_PROOF | GOLIATH_RESISTANCE

/obj/item/clothing/suit/hooded/cloak/drake
	resistance_flags = FIRE_PROOF | ACID_PROOF | GOLIATH_RESISTANCE
