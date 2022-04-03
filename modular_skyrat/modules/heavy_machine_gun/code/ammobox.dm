/obj/item/ammo_box/magazine/hmg_box
	name = "\improper .50 BMG ammo box"
	desc = "A big box full of beltfed ammo."
	icon = 'modular_skyrat/modules/heavy_machine_gun/icons/turret_objects.dmi'
	icon_state = "ammobox"
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	max_ammo = 100
	ammo_type = /obj/item/ammo_casing/b50cal
	caliber = CALIBER_50BMG

/obj/item/ammo_casing/b50cal
	name = ".50 BMG bullet casing"
	icon = 'modular_skyrat/modules/gunsgalore/icons/ammo/ammo.dmi'
	icon_state = ".50"
	caliber = CALIBER_50BMG
	projectile_type = /obj/projectile/bullet/c50cal

/obj/projectile/bullet/c50cal
	name = ".50 BMG bullet"
	damage = 35
	icon_state = "redtrac"
