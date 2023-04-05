/*
*	CFA RIFLE
*/

/obj/item/gun/ballistic/automatic/cfa_rifle
	name = "Cantanheim 6.8mm rifle"
	desc = "A simple semi-automatic rifle chambered in 6.8mm. The letters 'XJP' are crossed out in the receiver." //Different 6.8mm than the FTU's propietary pulse ballistics
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "cfa_rifle"
	inhand_icon_state = "irifle"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'
	worn_icon_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/cm68
	fire_delay = 5
	can_suppress = FALSE
	burst_size = 1
	actions_types = list()
	mag_display = FALSE
	mag_display_ammo = FALSE
	empty_indicator = FALSE
	recoil = 1
	weapon_weight = WEAPON_HEAVY
	pixel_x = -8
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/ballistic/automatic/cfa_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/automatic/cfa_rifle/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_CANTALAN)

/obj/item/gun/ballistic/automatic/cfa_rifle/give_gun_safeties()
	return

/obj/item/gun/ballistic/automatic/cfa_rifle/empty
	spawnwithmagazine = FALSE

/obj/item/ammo_box/magazine/cm68
	name = "rifle magazine (6.8mm)"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "6.8"
	ammo_type = /obj/item/ammo_casing/a68
	caliber = CALIBER_A68
	max_ammo = 10
	multiple_sprites = 2

/obj/item/ammo_box/magazine/cm68/empty
	start_empty = 1
