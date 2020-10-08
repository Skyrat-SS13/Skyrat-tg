/obj/item/gun/ballistic/automatic/assault_rifle/stg
	name = "\improper Sturmgewehr 44"
	desc = "The StG 44 (abbreviation of Sturmgewehr 44) is a German selective-fire assault rifle developed during World War II by Hugo Schmeisser."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/stg/stg.dmi'
	icon_state = "stg"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/stg/stg_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/stg/stg_righthand.dmi'
	inhand_icon_state = "stg"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/stg
	can_suppress = FALSE
	burst_size = 4
	fire_delay = 1.5
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/stg/stg_back.dmi'
	worn_icon_state = "stg"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/stg/stg.ogg'
	fire_sound_volume = 70
	alt_icons = TRUE
	realistic = TRUE

/obj/item/ammo_box/magazine/stg
	name = "stg magazine (7.92×33mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/stg/stg.dmi'
	icon_state = "7.92mm"
	ammo_type = /obj/item/ammo_casing/realistic/a792x33
	caliber = "a792x33"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY


