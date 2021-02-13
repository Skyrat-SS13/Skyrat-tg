//the actual revolver
/obj/item/gun/ballistic/revolver/cosmonaut
	name = "Cosmonaut's Revolver"
	desc = "You know what? Fuck you. *bullpups your revolver*"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cosmonaut"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/cosmonaut

//and it's internal magazine
obj/item/ammo_box/magazine/internal/cylinder/cosmonaut
	name = "cosmonaut revolver cylinder"
	ammo_type = /obj/item/ammo_casing/cosmonaut
	caliber = CALIBER_357x29
	max_ammo = 5

// .357x29 (Cosmonaut Revolver)
/obj/item/ammo_casing/cosmonaut
	name = ".357x29 bullet casing"
	desc = "A .357x29 bullet casing."
	caliber = CALIBER_357x29
	projectile_type = /obj/projectile/bullet/cosmonaut

//speedloader for the revolver
/obj/item/ammo_box/cosmonaut
	name = "speed loader (.357x29)"
	desc = "Designed to quickly reload revolvers."
	icon = 'modular_skyrat/modules/modular_weapons/code/modules/projectiles/guns/ballistic/cosmonaut_revolver/cosmonaut_revolver_sprites.dmi'
	icon_state = "357x29"
	ammo_type = /obj/item/ammo_casing/cosmonaut
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION

