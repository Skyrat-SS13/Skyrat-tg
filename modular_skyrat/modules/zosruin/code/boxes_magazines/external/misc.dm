/obj/item/ammo_box/magazine/hybrid
	name = "V-X Magazine (Ballistic)"
	desc = "An experimental ballistic magazine for the V-X PDW"
	icon = 'modular_skyrat/modules/zosruin/icons/ammo.dmi'
	icon_state = "hybridballistic"
	custom_materials = list(/datum/material/iron = 6000)
	ammo_type = /obj/item/ammo_casing/caseless/mass
	caliber = "hybrid"
	max_ammo = 12

/obj/item/ammo_box/magazine/hybrid/update_icon()
	desc = "[initial(desc)] It has [stored_ammo.len] shot\s left."
	icon_state = "[initial(icon_state)]-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/hybrid/attack_self() //No popping out the "bullets"
	return

/obj/item/ammo_box/magazine/hybrid/laser
	name = "V-X Magazine (Laser)"
	desc = "An experimental laser-based magazine for the V-X PDW"
	icon_state = "hybridlaser"
	custom_materials = list()
	ammo_type = /obj/item/ammo_casing/caseless/laser
