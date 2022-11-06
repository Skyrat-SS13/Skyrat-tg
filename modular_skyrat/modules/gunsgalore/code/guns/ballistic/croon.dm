/obj/item/gun/ballistic/automatic/croon
	name = "\improper Croon submachine gun"
	desc = "A low-quality 6.3mm reproduction of a popular SMG model, jams like a bitch. Although crude and unofficial, it gets the job done."
	icon = 'modular_skyrat/master_files/icons/obj/guns/croon.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand40x32.dmi'
	icon_state = "croon"
	inhand_icon_state = "croon"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/croon
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	burst_size = 3
	fire_delay = 2.10
	spread = 25
	mag_display = FALSE
	mag_display_ammo = FALSE
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC, SELECT_BURST_SHOT)
	realistic = TRUE
	dirt_modifier = 1.7 //the croon is an EXTRA piece of shit
	emp_damageable = TRUE
	company_flag = COMPANY_IZHEVSK

/obj/item/ammo_box/magazine/multi_sprite/croon
	name = "\improper Croon magazine"
	desc = "A straight 6.3mm magazine for the Croon SMG."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = CALIBER_6MM
	max_ammo = 15
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/croon/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/croon/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF
