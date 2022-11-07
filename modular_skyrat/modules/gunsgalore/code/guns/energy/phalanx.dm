/*
*	CFA PHALANX
*	Similar to the HoS's laser
*	Fires a bouncing non-lethal, lethal and knockdown projectile.
*/

/obj/item/gun/energy/e_gun/cfa_phalanx
	name = "\improper Mk.II Phalanx plasma blaster"
	desc = "Fires a disabling and lethal bouncing projectile, as well as a special muscle-seizing projectile that knocks targets down."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "phalanx1"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/bounce, /obj/item/ammo_casing/energy/laser/bounce, /obj/item/ammo_casing/energy/electrode/knockdown)
	ammo_x_offset = 1
	charge_sections = 5
	has_gun_safety = FALSE
	cell_type = /obj/item/stock_parts/cell/hos_gun
	company_flag = COMPANY_CANTALAN
