/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34
	name = "\improper Maschinengewehr 34"
	desc = "The Maschinengewehr 34, or MG 34, is a German recoil-operated air-cooled machine gun, first tested in 1929, introduced in 1934, and issued to units in 1936. It introduced an entirely new concept in automatic firepower – the Einheitsmaschinengewehr (Universal machine gun) – and is generally considered the world's first general-purpose machine gun (GPMG)."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34.dmi'
	icon_state = "mg34"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34_righthand.dmi'
	inhand_icon_state = "mg34"
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_HUGE
	spread = 15
	mag_type = /obj/item/ammo_box/magazine/mg34
	can_suppress = FALSE
	burst_size = 5
	fire_delay = 1
	realistic = TRUE
	reliability = 5

/obj/item/ammo_box/magazine/mg34
	name = "mg34 drum mag (7.92×57mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34.dmi'
	icon_state = "mg34_drum"
	ammo_type = /obj/item/ammo_casing/a792
	caliber = "a792"
	max_ammo = 75
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34/update_overlays()
	. = ..()
	. += "mg34_door_[cover_open ? "open" : "closed"]"
