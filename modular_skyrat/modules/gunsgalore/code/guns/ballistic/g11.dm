/obj/item/gun/ballistic/automatic/g11
	name = "\improper G11 K-490"
	desc = "An outdated german caseless battle rifle that has been revised countless times during the late 2400s. Takes 4.73x33mm toploaded magazines."
	icon = 'modular_skyrat/master_files/icons/obj/guns/g11.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand.dmi'
	icon_state = "g11"
	inhand_icon_state = "g11"
	worn_icon = 'modular_skyrat/master_files/icons/obj/guns/g11.dmi'
	worn_icon_state = "g11_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g11
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 0.5
	spread = 10
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'
	emp_damageable = FALSE
	can_bayonet = TRUE
	dirt_modifier = 0.1
	company_flag = COMPANY_OLDARMS

/obj/item/ammo_box/magazine/multi_sprite/g11
	name = "\improper G-11 magazine"
	desc = "A magazine for the G-11 rifle, meant to be filled with angry propellant cubes. Chambered for 4.73mm."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "g11"
	ammo_type = /obj/item/ammo_casing/caseless/b473
	caliber = CALIBER_473MM
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/g11/hp
	ammo_type = /obj/item/ammo_casing/caseless/b473/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g11/ihdf
	ammo_type = /obj/item/ammo_casing/caseless/b473/ihdf
	round_type = AMMO_TYPE_IHDF
