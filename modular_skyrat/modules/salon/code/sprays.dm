/obj/item/reagent_containers/spray/quantum_hair_dye
	name = "quantum hair dye"
	desc = "Changes hair colour RANDOMLY! Don't forget to read the label!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairspraywhite"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/hair_dye = 30)
	volume = 50

/obj/item/reagent_containers/spray/baldium
	name = "baldium spray"
	desc = "Causes baldness, exessive use may cause customer disatisfaction."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairremoval"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/baldium = 30)
	volume = 50

/obj/item/reagent_containers/spray/barbers_aid
	name = "barber's aid"
	desc = "Causes rapid hair and facial hair growth!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairaccelerator"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/barbers_aid = 50)
	volume = 50

/obj/item/reagent_containers/spray/super_barbers_aid
	name = "super barber's aid"
	desc = "Causes SUPER rapid hair and facial hair growth!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairaccelerator"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 5)
	list_reagents = list(/datum/reagent/concentrated_barbers_aid = 30)
	volume = 50
