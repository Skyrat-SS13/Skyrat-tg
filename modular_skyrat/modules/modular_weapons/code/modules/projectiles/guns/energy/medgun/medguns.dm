//BASE MEDIGUN//
/obj/item/gun/energy/medigun/standard
	name = "MediGun"
	desc = "This is my smart gun, it won't hurt anyone friendly, infact it will make them heal!"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa-disabler"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/medical/brute1)
	ammo_x_offset = 2
	w_class = WEIGHT_CLASS_NORMAL
	cell_type = /obj/item/stock_parts/cell/medigun/basic
	ammo_x_offset = 2
	charge_sections = 3
	has_gun_safety = TRUE
