/obj/item/gun/ballistic/automatic/submachine_gun/mp40
	name = "\improper Maschinenpistole 40"
	desc = "The MP 40 (Maschinenpistole 40) is a submachine gun chambered for the 9×19mm Parabellum cartridge. It was developed in Nazi Germany and used extensively by the Axis powers during World War II."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mp40/mp40.dmi'
	icon_state = "mp40"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/mp40/mp40_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/mp40/mp40_righthand.dmi'
	inhand_icon_state = "mp40"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/mp40
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 1.7
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mp40/mp40_back.dmi'
	worn_icon_state = "mp40"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/mp40/mp40.ogg'
	fire_sound_volume = 100
	alt_icons = TRUE
	realistic = TRUE

/obj/item/ammo_box/magazine/mp40
	name = "mp40 magazine (9mmx19)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mp40/mp40.dmi'
	icon_state = "9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "c9mm"
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY
