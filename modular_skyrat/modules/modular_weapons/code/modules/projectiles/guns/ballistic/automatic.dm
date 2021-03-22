////////////////////////
//ID: MODULAR_WEAPONS //
////////////////////////

// Magazines

/obj/item/ammo_box/magazine/smg32
	name = "smg magazine (.32)"
	desc = "A .32 magazine with a 30-rnd capacity. An economically friendly but low damage calibre, even low-end autolathes can print .32 bullets."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "smg32"
	ammo_type = /obj/item/ammo_casing/c32
	caliber = "c32acp"
	max_ammo = 30
	multiple_sprites = 2

/obj/item/ammo_box/magazine/smg32/rubber
	name = "smg magazine (.32 rubber)"
	icon_state = "smg32"
	ammo_type = /obj/item/ammo_casing/c32_rubber

/obj/item/ammo_box/magazine/smg32/ap
	name = "smg magazine (.32 armor-piercing)"
	icon_state = "smg32"
	ammo_type = /obj/item/ammo_casing/c32_ap

/obj/item/ammo_box/magazine/smg32/incendiary
	name = "smg magazine (.32 incendiary)"
	icon_state = "smg32"
	ammo_type = /obj/item/ammo_casing/c32_incendiary

/obj/item/ammo_box/magazine/smg32/empty
	start_empty = 1

///////////
//  SMG  //
///////////

/obj/item/gun/ballistic/automatic/cfa_wildcat
	name = "\improper CFA Wildcat"
	desc = "An old SMG, this one is chambered in .32, a very common and dirt-cheap cartridge."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "mp5"
	inhand_icon_state = "arg"
	selector_switch_icon = TRUE
	mag_type = /obj/item/ammo_box/magazine/smg32
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 1.25
	spread = 5
	mag_display = TRUE
	empty_indicator = FALSE
	fire_sound = 'sound/weapons/gun/smg/shot_alt.ogg'
	weapon_weight = WEAPON_MEDIUM
	has_gun_safety = FALSE
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/cfa_wildcat/no_mag
	spawnwithmagazine = FALSE
