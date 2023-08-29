//
// .35 Sol pistol magazines
//

/obj/item/ammo_box/magazine/c35sol_pistol
	name = "\improper Sol pistol magazine"
	desc = "A standard size magazine for SolFed pistols, holds twelve rounds."

	icon = 'modular_skyrat/modules/modular_weapons/code/company_and_or_faction_based/carwo_defense_systems/ammo.dm'
	icon_state = "pistol_35_standard"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 12

/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/stendo
	name = "\improper Sol extended pistol magazine"
	desc = "An extended magazine for SolFed pistols, holds twenty-four rounds."

	icon_state = "pistol_35_stended"

	max_ammo = 24

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty
	start_empty = TRUE

//
// .40 Sol rifle magazines
//

/obj/item/ammo_box/magazine/c40sol_rifle
	name = "\improper Sol rifle short magazine"
	desc = "A shortened magazine for SolFed rifles, holds fifteen rounds."

	icon = 'modular_skyrat/modules/modular_weapons/code/company_and_or_faction_based/carwo_defense_systems/ammo.dm'
	icon_state = "rifle_short"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c40sol
	caliber = CALIBER_SOL40LONG
	max_ammo = 15

/obj/item/ammo_box/magazine/c40sol_rifle/starts_empty

	start_empty = TRUE

/obj/item/ammo_box/magazine/c40sol_rifle/standard
	name = "\improper Sol rifle magazine"
	desc = "A standard size magazine for SolFed rifles, holds thirty rounds."

	icon_state = "rifle_standard"

	max_ammo = 30

/obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty

	start_empty = TRUE

/obj/item/ammo_box/magazine/c40sol_rifle/extended
	name = "\improper Sol rifle extended magazine"
	desc = "A massive drum magazine for SolFed rifles, holds fourty-five rounds."

	icon_state = "rifle_long"

	w_class = WEIGHT_CLASS_NORMAL

	max_ammo = 45

/obj/item/ammo_box/magazine/c40sol_rifle/extended/starts_empty

	start_empty = TRUE

//
// .40 Sol machinegun boxes
//

/obj/item/ammo_box/magazine/c40sol_machinegun
	name = "\improper Sol light machinegun ammo box"
	desc = "A large box for holding a chain of .40 Sol rifle rounds inside of. Can hold sixty rounds."

	icon = 'modular_skyrat/modules/modular_weapons/code/company_and_or_faction_based/carwo_defense_systems/ammo.dm'
	icon_state = "lmg_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c40sol
	caliber = CALIBER_SOL40LONG
	max_ammo = 60

/obj/item/ammo_box/magazine/c40sol_machinegun/starts_empty

	start_empty = TRUE
