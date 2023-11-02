/// Base pouch type. Fits in pockets, as its main gimmick.
/obj/item/storage/pouch
	name = "storage pouch"
	desc = "It's a nondescript pouch made with dark fabric. It has a clip, for fitting in pockets."
	icon = 'modular_skyrat/modules/modular_items/icons/storage.dmi'
	icon_state = "survival"
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_POCKETS

/obj/item/storage/pouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 5

/obj/item/storage/pouch/ammo
	name = "ammo pouch"
	desc = "A pouch for your ammo that goes in your pocket."
	icon = 'modular_skyrat/modules/modular_items/icons/storage.dmi'
	icon_state = "ammopouch"
	w_class = WEIGHT_CLASS_BULKY
	custom_price = PAYCHECK_CREW * 4

/obj/item/storage/pouch/ammo/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 30
	atom_storage.max_slots = 3
	atom_storage.numerical_stacking = FALSE
	atom_storage.can_hold = typecacheof(list(/obj/item/ammo_box/magazine, /obj/item/ammo_casing, /obj/item/stock_parts/cell/microfusion))

/obj/item/storage/pouch/material
	name = "material pouch"
	desc = "A pouch for sheets and RCD ammunition that manages to hang where you would normally put things in your pocket."
	icon = 'modular_skyrat/modules/modular_items/icons/storage.dmi'
	icon_state = "materialpouch"
	w_class = WEIGHT_CLASS_BULKY
	custom_price = PAYCHECK_CREW * 4

/obj/item/storage/pouch/material/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = INFINITY
	atom_storage.max_slots = 2
	atom_storage.numerical_stacking = TRUE
	atom_storage.can_hold = typecacheof(list(/obj/item/rcd_ammo, /obj/item/stack/sheet))

/// It's a pocket medkit. Use sparingly?
/obj/item/storage/pouch/medical
	name = "medkit pouch"
	desc = "A standard medkit pouch compartmentalized for the bare essentials of field medical care, made with fireproof kevlar \
	(but hopefully you never have to test that). Cannot, itself, contain a medkit. Comes with a pocket clip."
	resistance_flags = FIRE_PROOF
	icon_state = "medkit"
	/// The list of things that medical pouches can hold. Stolen from what medkits can hold, but modified for things you would probably want at pocket-access.
	var/static/list/med_pouch_holdables = list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/reagent_containers/blood,
		/obj/item/stack/sticky_tape,
	)

/obj/item/storage/pouch/medical/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = 7
	atom_storage.max_total_storage = 14
	atom_storage.set_holdable(med_pouch_holdables)

/obj/item/storage/pouch/medical/loaded/Initialize(mapload)
	. = ..()
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside, src)
	desc += " Repackaged with station-standard medical supplies."

/// It's... not as egregious as a full pocket medkit.
/obj/item/storage/pouch/medical/firstaid
	name = "first aid pouch"
	desc = "A standard nondescript first-aid pouch, compartmentalized for the bare essentials of field medical care. Made with fireproof kevlar \
	(but hopefully you never have to test that). Slightly smaller than a full-on medkit, \
	but has better weight distribution, making it more comfortable to wear. Comes with a pocket-clip."
	icon_state = "firstaid"

/obj/item/storage/pouch/medical/firstaid/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 4
	atom_storage.max_total_storage = 8

/obj/item/storage/pouch/medical/firstaid/loaded/Initialize(mapload)
	. = ..()
	desc += " Repackaged with station-standard medical supplies."
	var/static/items_inside = list(
		/obj/item/stack/medical/suture = 1,
		/obj/item/stack/medical/mesh = 1,
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 1,
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/pouch/medical/firstaid/stabilizer/Initialize(mapload)
	. = ..()
	desc += " Repackaged with a wound stabilization-focused loadout."
	var/static/items_inside = list(
		/obj/item/cautery = 1,
		/obj/item/bonesetter = 1,
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 1,
	)
	generate_items_inside(items_inside, src)
