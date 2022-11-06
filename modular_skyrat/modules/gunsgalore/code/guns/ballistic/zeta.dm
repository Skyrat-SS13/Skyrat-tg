/obj/item/gun/ballistic/revolver/zeta
	name = "\improper Zeta-6 revolver"
	desc = "A fairly common double-action six-shooter chambered for 10mm Magnum, 'Spurchamber' is engraved on the cylinder."
	icon = 'modular_skyrat/master_files/icons/obj/guns/zeta.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand.dmi'
	icon_state = "zeta"
	inhand_icon_state = "zeta"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/zeta
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	fire_delay = 3
	company_flag = COMPANY_BOLT

/obj/item/ammo_box/magazine/internal/cylinder/zeta
	name = "\improper Zeta-6 cylinder"
	desc = "If you see this, you should call a Bluespace Technician. Unless you're that Bluespace Technician."
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 6

/obj/item/ammo_box/revolver/zeta
	name = "\improper Zeta-6 speedloader"
	desc = "A speedloader for the Spurchamber revolver, chambered for 10mm Magnum ammo."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	caliber = CALIBER_10MM
	start_empty = TRUE

/obj/item/ammo_box/revolver/zeta/full
	start_empty = FALSE
