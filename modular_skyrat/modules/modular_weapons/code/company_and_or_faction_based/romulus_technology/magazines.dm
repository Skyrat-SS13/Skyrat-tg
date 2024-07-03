/obj/item/ammo_box/magazine/m45a5
	name = "\improper m45a5 magazine (Rose)"
	desc = "A magazine for the m45a5 chambered in .460 Rowland, holds ten rounds. Warning, contains expanding head that deform on contact, may cause excessive bleeding."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "rowlandmodular"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	ammo_type = /obj/item/ammo_casing/c460rowland
	caliber = CALIBER_460ROWLAND
	max_ammo = 10

/obj/item/ammo_box/magazine/m45a5/ap
	name = "\improper m45a5 magazine (Armour Piercing)"
	desc = "A magazine for the m45a5 chambered in .460 Rowland, holds ten rounds. Warning, contains lead core intended to defeat body armour."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "rowlandmodulargreen"

/obj/item/ammo_box/magazine/m45a5/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/internal/cylinder/c457
	caliber = CALIBER_457
	ammo_type = /obj/item/ammo_casing/c457govt
