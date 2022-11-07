/*
*	BOLT RESPONDER
*	A mini disabler
*	12 shot capacity VS normal disabler's 20.
*/


/obj/item/gun/energy/disabler/bolt_disabler
	name = "Bolt Responder"
	desc = "A pocket-sized non-lethal energy gun with low ammo capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa-disabler"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell/mini_egun
	ammo_x_offset = 2
	charge_sections = 3
	has_gun_safety = FALSE
	company_flag = COMPANY_BOLT

/obj/item/gun/energy/disabler/bolt_disabler/add_seclight_point()
	return
