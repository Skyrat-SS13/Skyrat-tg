/obj/item/ammo_box/magazine/mmg_box
	name = "\improper .50 BMG ammo box"
	desc = "A big box full of beltfed ammo."
	icon = 'modular_skyrat/modules/mounted_machine_gun/icons/turret_objects.dmi'
	icon_state = "ammobox"
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	max_ammo = 150
	ammo_type = /obj/item/ammo_casing/b50cal
	caliber = CALIBER_50BMG

/obj/item/ammo_casing/b50cal
	name = ".50 BMG bullet casing"
	icon = 'modular_skyrat/modules/gunsgalore/icons/ammo/ammo.dmi'
	icon_state = "792x57-casing"
	caliber = CALIBER_50BMG
	projectile_type = /obj/projectile/bullet/c50cal

/obj/projectile/bullet/c50cal
	name = ".50 BMG bullet"
	damage = 40
	wound_bonus = 60
	armour_penetration = 20
	icon_state = "redtrac"
