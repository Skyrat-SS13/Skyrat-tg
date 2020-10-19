/obj/item/gun/ballistic/automatic/assault_rifle/m16
	name = "\improper M16 Rifle"
	desc = "The M16 rifle, officially designated Rifle, Caliber 5.56 mm, M16, is a family of military rifles adapted from the ArmaLite AR-15 rifle for the United States military. The original M16 rifle was a 5.56mm automatic rifle with a 20-round magazine."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/m16/m16.dmi'
	icon_state = "m16"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/m16/m16_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/m16/m16_righthand.dmi'
	inhand_icon_state = "m16"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/m16
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 4
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/m16/m16_back.dmi'
	worn_icon_state = "m16"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/m16/m16.ogg'
	fire_sound_volume = 50
	alt_icons = TRUE
	realistic = TRUE

/obj/item/ammo_box/magazine/m16
	name = "m16 magazine (5.56×45mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/m16/m16.dmi'
	icon_state = "5.56mm"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY
