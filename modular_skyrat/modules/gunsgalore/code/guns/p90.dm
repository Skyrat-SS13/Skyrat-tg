/obj/item/gun/ballistic/automatic/p90
	name = "\improper P90-02"
	desc = "A compact, top-loaded bullpup PDW chambered in .32 ammo."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "p90"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "p90"
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "p90"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/p90
	can_suppress = FALSE
	burst_size = 5
	fire_delay = 1
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/p90_fire.ogg'
	fire_sound_volume = 100
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/p90_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/p90_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/p90_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/p90_magout.ogg'
	alt_icons = TRUE
	realistic = TRUE

/obj/item/ammo_box/magazine/p90
	name = "\improper P90-02 magazine"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "p90"
	ammo_type = /obj/item/ammo_casing/c32
	caliber = "c32acp"
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	
