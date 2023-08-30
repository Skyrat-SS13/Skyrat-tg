//
// .980 grenades
// Grenades that can be given a range to detonate at by their firing gun
//

/obj/item/ammo_casing/c980grenade
	name = ".980 Tydhouer practice grenade"
	desc = "A SolFed standard caseless lethal rifle round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "40sol"

	caliber = CALIBER_SOL40LONG
	projectile_type = /obj/projectile/bullet/c980grenade

/obj/projectile/bullet/c980grenade
	name = ".40 Sol Long bullet"
	damage = 35



/obj/item/ammo_box/c980grenade
	name = "ammo box (.40 Sol Long lethal)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "40box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c980grenade
	max_ammo = 30
