/obj/item/gun/ballistic/automatic/submachine_gun/pps
	name = "\improper Pistolet-pulemyot Sudayeva"
	desc = "The PPS (Pistolet-pulemyot Sudayeva) is a family of Soviet submachine guns chambered in 7.62×25mm Tokarev, developed by Alexei Sudayev as a low-cost personal defense weapon for reconnaissance units, vehicle crews and support service personnel."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/pps/pps.dmi'
	icon_state = "pps"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/pps/pps_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/pps/pps_righthand.dmi'
	inhand_icon_state = "pps"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/pps
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 3
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/pps/pps_back.dmi'
	worn_icon_state = "pps"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/pps/pps.ogg'
	fire_sound_volume = 100
	alt_icons = TRUE
	realistic = TRUE
	durability_factor = 0.5

/obj/item/ammo_box/magazine/pps
	name = "pps magazine (7.62×25mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/pps/pps.dmi'
	icon_state = "7.62mm"
	ammo_type = /obj/item/ammo_casing/realistic/a762x25
	caliber = "a762x25"
	max_ammo = 35
	multiple_sprites = AMMO_BOX_FULL_EMPTY
