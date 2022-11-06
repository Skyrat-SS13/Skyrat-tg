/obj/item/gun/ballistic/automatic/pistol/makarov
	name = "\improper R-C 'Makarov'"
	desc = "A mediocre pocket-sized handgun of NRI origin, chambered in 10mm Auto."
	icon = 'modular_skyrat/master_files/icons/obj/guns/makarov.dmi'
	icon_state = "makarov"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/makarov
	can_suppress = TRUE
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	dirt_modifier = 0.3
	emp_damageable = TRUE
	company_flag = COMPANY_IZHEVSK

/obj/item/ammo_box/magazine/multi_sprite/makarov
	name = "\improper R-C Makarov magazine"
	desc = "A tiny magazine for the R-C Makarov pocket pistol, chambered in 10mm Auto."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = CALIBER_10MMAUTO
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/makarov/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/makarov/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/makarov/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER
