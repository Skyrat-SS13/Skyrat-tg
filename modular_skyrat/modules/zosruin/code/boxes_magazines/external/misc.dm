/obj/item/ammo_box/magazine/hybrid
	name = "ZenPlaceholder Magazine (Laser)"
	desc = "An experimental magazine for the ZenPlaceholder"
	icon_state = "hybridlaser"
	ammo_type = /obj/item/ammo_casing/caseless/laser
	caliber = "hybrid"
	max_ammo = 12

/obj/item/ammo_box/magazine/hybrid/update_icon()
	desc = "[initial(desc)] It has [stored_ammo.len] shot\s left."
	icon_state = "[initial(icon_state)]-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/hybrid/attack_self() //No popping out the "bullets"
	return

/obj/item/ammo_box/magazine/hybrid/ballistic
	name = "ZenPlaceholder Magazine (Ballistic)"
	desc = "An experimental magazine for the ZenPlaceholder"
	icon_state = "hybridballistic"
	ammo_type = /obj/item/ammo_casing/caseless/mass
