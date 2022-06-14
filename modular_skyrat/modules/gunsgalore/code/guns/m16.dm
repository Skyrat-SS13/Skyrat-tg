/obj/item/gun/ballistic/automatic/m16
	name = "\improper XM-2537 rifle"
	desc = "A relatively new infantry rifle chambered for the .277 Aestus round, designed for use by private security and freight crews. \"Armentarium Centrale\" is printed on the side of the receiver, right next to a yellow sun."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "m16"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "m16"
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "m16"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/m16
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 2
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/m16_fire.ogg'
	fire_sound_volume = 50
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magout.ogg'
	alt_icons = TRUE
	realistic = TRUE

/obj/item/ammo_box/magazine/m16
	name = "\improper XM-2537 magazine"
	desc = "A double-stack translucent polymer magazine for use with the XM-2537 rifles. Holds 30 rounds of .277 Aestus."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16e"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m16/vintage
	name = "outdated .277 magazine"
	desc = "A double-stack solid magazine that looks rather dated. Holds 20 rounds of .277 Aestus."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/m16/modern
	name = "\improper XM-2537 SOPMOD rifle"
	desc = "A heavily tweaked carbine version of the XM-2537 rifle made for tactically operating in tactical environments. This doesn't smell \"authentic military hardware\" to you."
	icon_state = "m16_modern"
	inhand_icon_state = "m16"
	worn_icon_state = "m16"
	spread = 0.5
	burst_size = 3
	fire_delay = 1.90

/obj/item/gun/ballistic/automatic/m16/modern/v2
	name = "\improper XM-2537 'Amans Patriae' rifle"
	desc = "An expertly modified, super-compact XM-2537 rifle designed for operating in tight corridors and fields full of Bethlehem flowers. You're a soldier, finish your mission!"
	icon_state = "m16_modern2"
	inhand_icon_state = "m16"
	worn_icon_state = "m16"
	mag_type = /obj/item/ammo_box/magazine/m16/patriot
	burst_size = 4
	fire_delay = 0.5

/obj/item/ammo_box/magazine/m16/patriot
	name = "\improper XM-2537 drum magazine"
	desc = "A double-stack solid polymer drum made for use with the Amans Patriae rifle. Holds 50 rounds of .277 ammo."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY
