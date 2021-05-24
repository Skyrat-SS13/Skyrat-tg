/obj/item/storage/belt/quiver
	name = "leather quiver"
	desc = "A quiver made from the hide of some animal. Used to hold arrows."
	icon = 'modular_skyrat/modules/tribal_extended/icons/belt.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/belt.dmi'
	icon_state = "quiverlazy" //codersprite
	worn_icon_state = "quiver"

/obj/item/storage/belt/quiver/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 15
	STR.display_numerical_stacking = TRUE
	STR.can_hold = typecacheof(list(
		/obj/item/ammo_casing/caseless/arrow/wood,
		/obj/item/ammo_casing/caseless/arrow/ash,
		/obj/item/ammo_casing/caseless/arrow/bone,
		/obj/item/ammo_casing/caseless/arrow/bronze
		))
