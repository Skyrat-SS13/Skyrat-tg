/obj/item/gun/ballistic/automatic/pistol/automag
	name = "\improper Automag"
	desc = "A .44 AMP handgun with a sleek metallic finish."
	icon_state = "automag"
	icon = 'modular_skyrat/master_files/icons/obj/guns/automag.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/automag
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/automag.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

/obj/item/ammo_box/magazine/automag
	name = "handgun magazine (.44 AMP)"
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "automag"
	base_icon_state = "automag"
	ammo_type = /obj/item/ammo_casing/c44
	caliber = CALIBER_44
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_casing/c44
	name = ".44 AMP bullet casing"
	desc = "A .44 AMP bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/projectile/bullet/c44

/obj/projectile/bullet/c44
	name = ".44 AMP bullet"
	damage = 40
	wound_bonus = 30
