/obj/item/gun/ballistic/automatic/pistol/pdh/striker
	name = "\improper PDH-6 'Striker'"
	desc = "A sidearm used by Armadyne corporate agents who didn't make the cut for the Corpo model. Chambered in .38 special."
	icon_state = "pdh_striker"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_striker
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/corporate_diplomat/sound/pistol_shot.ogg'
	burst_size = 2
	fire_delay = 3
	spread = 9
	company_flag = COMPANY_ARMADYNE

/obj/item/ammo_box/magazine/multi_sprite/pdh_striker
	name = "\improper PDH-6M magazine"
	desc = "A magazine for the PDH-6 'Striker'. Chambered in the strange choice of .38 special."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(
		AMMO_TYPE_LETHAL,
	)
