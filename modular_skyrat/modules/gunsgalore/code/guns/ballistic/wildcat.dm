/*
*	WILDCAT
*	3rnd burst .32 calibre, 15 damage.
*	Fills the role of a low damage, high magazine capacity magdump gun.
*/

/obj/item/gun/ballistic/automatic/cfa_wildcat
	name = "\improper CFA Wildcat"
	desc = "A robust roller-delayed SMG chambered for .34 ammunition."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "mp5"
	inhand_icon_state = "arg"
	selector_switch_icon = TRUE
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 1.25
	spread = 5
	mag_display = TRUE
	empty_indicator = FALSE
	fire_sound = 'sound/weapons/gun/smg/shot_alt.ogg'
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	company_flag = COMPANY_CANTALAN
	dirt_modifier = 0.2

/obj/item/gun/ballistic/automatic/cfa_wildcat/no_mag
	spawnwithmagazine = FALSE

/obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat
	name = "CFA Wildcat magazine (.34)"
	desc = "Magazines taking .34 ammunition; it fits in the CFA Wildcat. Alt+click to reskin it."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "smg34"
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_AP, AMMO_TYPE_RUBBER, AMMO_TYPE_INCENDIARY)
	ammo_type = /obj/item/ammo_casing/c34
	caliber = "c34acp"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat/ap
	ammo_type = /obj/item/ammo_casing/c34/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat/rubber
	ammo_type = /obj/item/ammo_casing/c34/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat/incendiary
	ammo_type = /obj/item/ammo_casing/c34_incendiary
	round_type = AMMO_TYPE_INCENDIARY

/obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat/empty
	start_empty = 1
