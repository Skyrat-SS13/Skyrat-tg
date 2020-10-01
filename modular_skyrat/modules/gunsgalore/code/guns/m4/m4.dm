/obj/item/gun/ballistic/automatic/m4
	name = "\improper M4 Carbine"
	desc = "The M4 Carbine is a 5.56×45mm NATO, air-cooled, gas-operated, direct impingement, magazine-fed carbine."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/m4/m4.dmi'
	icon_state = "m4"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/m4/m4_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/m4/m4_righthand.dmi'
	inhand_icon_state = "m4"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/m4
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 1
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/m4/m4_back.dmi'
	worn_icon_state = "m4"
	alt_icons = TRUE
	realistic = TRUE
	reliability = 0.7

/obj/item/ammo_box/magazine/m4
	name = "m4 magazine (5.56×45mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/m4/m4.dmi'
	icon_state = "5.56mm"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a792"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY
