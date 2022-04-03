/obj/item/ammo_box/magazine/hmg_box
	name = "HMG Ammo Box"
	desc = "A big box full of beltfed ammo."
	icon = 'modular_skyrat/modules/advanced_deployable_turret/icons/turret_objects.dmi'
	icon_state = "ammobox"
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	max_ammo = 100
	ammo_type = /obj/item/ammo_casing/hmg/mesa

/obj/item/ammo_casing/hmg/mesa
	name = "high powered round"
	projectile_type = /obj/projectile/bullet/manned_turret/hmg/mesa
