// Various ammo boxes for .310

/obj/item/ammo_box/c310_cargo_box
	name = "ammo box (.310 Strilka lethal)"
	desc = "A box of .310 Strilka lethal rifle rounds, holds five cartridges."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "310_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_SMALL

	caliber = CALIBER_STRILKA310
	ammo_type = /obj/item/ammo_casing/strilka310
	max_ammo = 5

// Rubber

/obj/item/ammo_box/c310_cargo_box/rubber
	name = "ammo box (.310 Strilka rubber)"
	desc = "A box of .310 Strilka rubber rifle rounds, holds five cartridges."

	icon_state = "310_box_rubber"

	ammo_type = /obj/item/ammo_casing/strilka310/rubber

// AP

/obj/item/ammo_box/c310_cargo_box/piercing
	name = "ammo box (.310 Strilka piercing)"
	desc = "A box of .310 Strilka piercing rifle rounds, holds five cartridges."

	icon_state = "310_box_ap"

	ammo_type = /obj/item/ammo_casing/strilka310/ap
