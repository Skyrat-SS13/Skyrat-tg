/obj/item/gun/ballistic/automatic/stg
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
	fire_delay = 1
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/stg/stg_back.dmi'
	worn_icon_state = "stg"
	alt_icons = TRUE
	realistic = TRUE
	reliability = 0.3

/obj/item/ammo_box/magazine/stg
	name = "stg magazine (7.92×33mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/stg/stg.dmi'
	icon_state = "7.92mm"
	ammo_type = /obj/item/ammo_casing/a792
	caliber = "a792"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY


