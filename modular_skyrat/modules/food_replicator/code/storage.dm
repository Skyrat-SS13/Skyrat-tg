/obj/item/storage/bag/medipen
	name = "colonial medipen pouch"
	desc = "A pouch for your (medi-)pens that goes in your pocket."
	icon = 'modular_skyrat/modules/food_replicator/icons/pouch.dmi'
	icon_state = "medipen_pouch"
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/medipen/update_icon_state()
	icon_state = "[initial(icon_state)]_[contents.len]"
	return ..()

/obj/item/storage/bag/medipen/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/storage/bag/medipen/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_TINY
	atom_storage.max_total_storage = 4
	atom_storage.max_slots = 4
	atom_storage.numerical_stacking = FALSE
	atom_storage.can_hold = typecacheof(list(/obj/item/reagent_containers/hypospray/medipen, /obj/item/pen, /obj/item/flashlight/pen))

/obj/item/storage/bag/pocket_medkit
	name = "colonial first aid kit"
	desc = "A medical pouch that goes in your pocket. Can be used to store things unrelated to medicine, except for guns, ammo and raw materials."
	icon = 'modular_skyrat/modules/food_replicator/icons/pouch.dmi'
	icon_state = "cfak"
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/pocket_medkit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 4
	atom_storage.max_slots = 4
	atom_storage.cant_hold = typecacheof(list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/stack/sheet))
