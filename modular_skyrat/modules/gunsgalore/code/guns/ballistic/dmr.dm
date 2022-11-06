/obj/item/gun/ballistic/automatic/dmr
	name = "\improper Gen-2 Ripper rifle"
	desc = "An incredibly powerful marksman rifle with an internal stabilization gymbal. It's chambered in .577 Snider."
	icon = 'modular_skyrat/master_files/icons/obj/guns/dmr.dmi'
	icon_state = "dmr"
	worn_icon = 'modular_skyrat/master_files/icons/obj/guns/dmr.dmi'
	worn_icon_state = "dmr_worn"
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand40x32.dmi'
	inhand_icon_state = "dmr"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	mag_type = /obj/item/ammo_box/magazine/dmr
	fire_delay = 1.7
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = FALSE
	mag_display = TRUE
	realistic = TRUE
	fire_sound_volume = 60
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sniper_fire.ogg'
	company_flag = COMPANY_ARMADYNE

/obj/item/ammo_box/magazine/dmr
	name = "\improper Gen-2 Ripper magazine"
	desc = "A magazine for the Ripper DMR, chambered for .577 Snider."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "dmr"
	ammo_type = /obj/item/ammo_casing/b577
	caliber = CALIBER_B577
	max_ammo = 25
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
