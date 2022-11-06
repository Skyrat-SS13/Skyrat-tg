/obj/item/gun/ballistic/automatic/dozer
	name = "\improper Dozer PDW"
	desc = "The DZR-9, a notorious 9x25mm PDW that lives up to its nickname."
	icon = 'modular_skyrat/master_files/icons/obj/guns/dozer.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand.dmi'
	icon_state = "dozer"
	inhand_icon_state = "dozer"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/dozer
	can_suppress = TRUE
	mag_display = FALSE
	mag_display_ammo = FALSE
	burst_size = 2
	fire_delay = 1.90
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC, SELECT_BURST_SHOT)
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	emp_damageable = TRUE
	company_flag = COMPANY_ARMADYNE

/obj/item/ammo_box/magazine/multi_sprite/dozer
	name = "\improper Dozer magazine"
	desc = "A magazine for the Dozer PDW, chambered for 9x25mm Mark 12."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_INCENDIARY, AMMO_TYPE_AP)

/obj/item/ammo_box/magazine/multi_sprite/dozer/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/dozer/ap
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/dozer/inc
	ammo_type = /obj/item/ammo_casing/c9mm/fire
	round_type = AMMO_TYPE_INCENDIARY
