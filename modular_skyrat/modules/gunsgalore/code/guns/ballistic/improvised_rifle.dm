/*
*	IMPROVISED RIFLE
*	There was an improvised rifle on Cit/Skyrat, it's pretty cool so here it is too.
*	We're using a slightly modified sprite designed around a Short Magazine Lee Enfield (SMLE) Mk.III
*/

/obj/item/ammo_box/magazine/internal/boltaction/improvised
	max_ammo = 1
	multiload = 0

/obj/item/gun/ballistic/rifle/irifle
	name = "improvised 7.62 rifle"
	desc = "An improvised rifle that fires hard-hitting 7.62 bullets."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "irifle"
	inhand_icon_state = "irifle"
	worn_icon_state = null
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/improvised
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'
	pixel_x = -8
	weapon_weight = WEAPON_HEAVY	// It's big.
