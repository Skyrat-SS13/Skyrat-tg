/obj/item/weaponcell
	name = "default weaponcell"
	desc = "used to add ammo types to guns"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/upgrades.dmi'
	icon_state = "Oxy1"
	w_class = WEIGHT_CLASS_SMALL
	var/ammo_type = /obj/item/ammo_casing/energy/medical

/obj/item/weaponcell/debug
	name = "debug medicell"
	ammo_type = /obj/item/ammo_casing/energy/ion

/obj/item/weaponcell/debug/child
	name = "debug medicell child"

/obj/item/weaponcell/medical
	name = "medical cell"
