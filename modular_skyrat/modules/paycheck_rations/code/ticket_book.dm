/obj/item/storage/ration_ticket_book
	name = "ration ticket book"
	desc = "A small booklet able to hold all your ration tickets. More will be available here as your paychecks come in."
	icon = 'modular_skyrat/modules/paycheck_rations/code/ticket_book.dm'
	icon_state = "ticket_book"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID

/obj/item/storage/ration_ticket_book/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 4
	atom_storage.set_holdable(list(
		/obj/item/paper/paperslip/ration_ticket,
	))
