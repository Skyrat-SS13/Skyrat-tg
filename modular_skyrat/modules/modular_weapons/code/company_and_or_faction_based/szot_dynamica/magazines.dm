// .310 magazine for the Lanca rifle

/obj/item/ammo_box/magazine/lanca
	name = "\improper Lanca rifle magazine"
	desc = "A standard size magazine for Lanca rifles, holds ten rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "lanca_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 10

/obj/item/ammo_box/magazine/lanca/spawns_empty
	start_empty = TRUE

// Magazine for the Miecz submachinegun

/obj/item/ammo_box/magazine/miecz
	name = "\improper Miecz submachinegun magazine"
	desc = "A standard size magazine for Miecz submachineguns, holds eighteen rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "miecz_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa
	caliber = CALIBER_CESARZOWA
	max_ammo = 18

/obj/item/ammo_box/magazine/miecz/spawns_empty
	start_empty = TRUE
