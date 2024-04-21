/obj/item/ammo_box/magazine/m45a5
	name = "\improper Sol extended pistol magazine"
	desc = "An extended magazine for SolFed pistols, holds twenty-four rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "pistol_35_standard"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_TINY

	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 10

/obj/item/ammo_box/magazine/m45a5/starts_empty
	start_empty = TRUE

