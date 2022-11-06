/obj/item/gun/ballistic/automatic/ostwind
	name = "\improper DTR-6 Rifle"
	desc = "A 6.3mm special-purpose rifle designed to deal with threats uniquely. You feel like this is a support type firearm."
	icon = 'modular_skyrat/master_files/icons/obj/guns/ostwind.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand.dmi'
	inhand_icon_state = "ostwind"
	icon_state = "ostwind"
	worn_icon = 'modular_skyrat/master_files/icons/obj/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	alt_icons = TRUE
	alt_icon_state = "ostwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ostwind
	spread = 10
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 2
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	dirt_modifier = 0.4
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	emp_damageable = TRUE
	can_bayonet = TRUE
	company_flag = COMPANY_ARMADYNE

/obj/item/ammo_box/magazine/multi_sprite/ostwind
	name = "\improper DTR-6 magazine"
	desc = "A thirty round double-stack magazine for the DTR-6 rifle, capable of loading flechettes, fragmentation ammo or dissuasive pellets. Chambered for 6.3mm."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = CALIBER_6MM
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/ostwind/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/ostwind/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF
