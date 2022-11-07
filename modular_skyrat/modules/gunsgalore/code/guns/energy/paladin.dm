/*
*	CFA PALADIN
*	Identical to a heavy laser.
*/


/obj/item/gun/energy/laser/cfa_paladin
	name = "\improper Mk.IV Paladin plasma carbine"
	desc = "Essentially a handheld laser cannon. This is solely for killing, and it's dual-laser system reflects that."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "paladin"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/laser/double)
	charge_sections = 5
	has_gun_safety = FALSE
	company_flag = COMPANY_CANTALAN
