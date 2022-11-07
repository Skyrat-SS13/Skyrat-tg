/obj/item/gun/ballistic/automatic/pistol/ladon
	name = "\improper Ladon pistol"
	desc = "Modern handgun based off the PDH series, chambered in 10mm Auto."
	icon = 'modular_skyrat/master_files/icons/obj/guns/ladon.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand40x32.dmi'
	icon_state = "ladon"
	inhand_icon_state = "ladon"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ladon
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	dirt_modifier = 0.6
	emp_damageable = TRUE
	fire_delay = 4.20
	company_flag = COMPANY_ARMADYNE

/obj/item/gun/ballistic/automatic/pistol/ladon/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/gun/ballistic/automatic/pistol/ladon/nri
	name = "\improper Szabo-Ivanek service pistol"
	desc = "A mass produced NRI-made modified reproduction of the PDH-6 line of handguns rechambered in 9×25mm.\
	 'PATRIOT DEFENSE SYSTEMS' is inscribed on the receiver, indicating it's been made with a plasteel printer."
	icon = 'modular_skyrat/modules/novaya_ert/icons/pistol.dmi'
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m9mm_aps
	burst_size = 3
	dirt_modifier = 0.5
	emp_damageable = FALSE
	fire_delay = 3
	company_flag = COMPANY_IZHEVSK

/obj/item/ammo_box/magazine/multi_sprite/ladon
	name = "\improper Ladon magazine"
	desc = "A magazine for the Ladon pistol, chambered for 10mm Auto."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = CALIBER_10MMAUTO
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/ladon/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/ladon/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/ladon/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER
