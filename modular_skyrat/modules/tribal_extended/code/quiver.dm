/obj/item/storage/belt/quiver
	name = "leather quiver"
	desc = "A quiver made from the hide of some animal. Used to hold arrows."
	icon = 'modular_skyrat/modules/tribal_extended/icons/belt.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/belt.dmi'
	icon_state = "quiverlazy" //codersprite
	worn_icon_state = "quiver"

/obj/item/storage/belt/quiver/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 15
	atom_storage.numerical_stacking = TRUE
	atom_storage.can_hold = typecacheof(list(
		/obj/item/ammo_casing/caseless/arrow/wood,
		/obj/item/ammo_casing/caseless/arrow/ash,
		/obj/item/ammo_casing/caseless/arrow/bone,
		/obj/item/ammo_casing/caseless/arrow/bronze
		))
