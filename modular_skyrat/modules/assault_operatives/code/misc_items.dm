/obj/item/storage/bag/medpens
	name = "medpen pouch"
	desc = "A pouch containing several different types of lifesaving medipens."
	icon = 'modular_skyrat/modules/modular_items/icons/storage.dmi'
	icon_state = "medpen_pouch"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS

/obj/item/storage/bag/medpens/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 30
	atom_storage.max_slots = 4
	atom_storage.numerical_stacking = FALSE
	atom_storage.can_hold = typecacheof(list(/obj/item/reagent_containers/hypospray))


/obj/item/storage/bag/medpens/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/oxandrolone(src)
	new /obj/item/reagent_containers/hypospray/medipen/salacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/salbutamol(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)

/obj/item/storage/backpack/duffelbag/syndie/smoke/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/grenade/smokebomb(src)
