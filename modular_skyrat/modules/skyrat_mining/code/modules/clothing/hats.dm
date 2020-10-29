/obj/item/clothing/head/hooded/explorer/seva
	name = "SEVA Hood"
	desc = "A fire-proof hood for exploring hot environments. Its design and material make it easier for a Goliath to keep their grip on the wearer."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/head.dmi'
	icon_state = "seva"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 35, "bio" = 50, "rad" = 25, "fire" = 100, "acid" = 25, "wound" = 5) //skyrat edit
	resistance_flags = FIRE_PROOF | GOLIATH_WEAKNESS

/obj/item/clothing/head/hooded/explorer/exo
	name = "Exo-hood"
	desc = "A robust helmet for fighting dangerous animals. Its design and material make it harder for a Goliath to keep their grip on the wearer."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/head.dmi'
	icon_state = "exo"
	armor = list("melee" = 55, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 40, "bio" = 25, "rad" = 10, "fire" = 0, "acid" = 0, "wound" = 13) //skyrat edit
	resistance_flags = FIRE_PROOF | GOLIATH_RESISTANCE
