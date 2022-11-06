// No, I'm not making a file for every tiny gun variation.

/obj/item/gun/ballistic/automatic/pistol/g17
	name = "\improper GK-17"
	desc = "A weapon from bygone times, this has been made to look like an old, blocky firearm from the 21st century. Let's hope it's more reliable. Chambered in 9x19mm Peacekeeper."
	icon = 'modular_skyrat/master_files/icons/obj/guns/glock.dmi'
	icon_state = "glock"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g17
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	dirt_modifier = 0.5
	emp_damageable = TRUE
	fire_delay = 1.90
	company_flag = COMPANY_CANTALAN

/obj/item/gun/ballistic/automatic/pistol/g17/add_seclight_point()
	return

/obj/item/ammo_box/magazine/multi_sprite/g17
	name = "\improper GK-17 magazine"
	desc = "A magazine for the GK-17 handgun, chambered for 9mm Peacekeeper ammo."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MMPEACE
	max_ammo = 17
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/g17/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g17/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/g17/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/gun/ballistic/automatic/pistol/g18
	name = "\improper GK-18"
	desc = "A CFA-made burst firing cheap polymer pistol chambered in 9mm Peacekeeper. Its heavy duty barrel affects firerate."
	icon = 'modular_skyrat/master_files/icons/obj/guns/glock.dmi'
	icon_state = "glock_spec"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g18
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	burst_size = 3
	fire_delay = 2.10
	spread = 8
	mag_display = FALSE
	mag_display_ammo = FALSE
	company_flag = COMPANY_CANTALAN
	dirt_modifier = 0.7

/obj/item/gun/ballistic/automatic/pistol/g18/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/multi_sprite/g18
	name = "\improper GK-18 magazine"
	desc = "A magazine for the GK-18 machine pistol, chambered for 9mm Peacekeeper."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "g18"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MMPEACE
	max_ammo = 33
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/g18/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g18/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/g18/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/gun/ballistic/automatic/pistol/g17/mesa
	name = "\improper Glock 20"
	desc = "A weapon from bygone times, and this is the exact 21st century version. In fact, even more reliable. Chambered in 10mm Auto."
	icon = 'modular_skyrat/master_files/icons/obj/guns/glock.dmi'
	icon_state = "glock_mesa"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ladon // C o m p a t i b i l i t y .
	fire_sound = 'modular_skyrat/master_files/sound/weapons/glock17_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	dirt_modifier = 0.2
	emp_damageable = FALSE
	fire_delay = 0.9
	company_flag = null

/obj/item/gun/ballistic/automatic/pistol/g17/mesa/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")
