/obj/item/smokable/crack
	name = "crack"
	desc = "A rock of freebase cocaine, otherwise known as crack."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "crack"

	smokable_reagent = /datum/reagent/drug/cocaine/freebase_cocaine
	reagent_amount = 10

/datum/export/crack
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "crack"
	export_types = list(/obj/item/smokable/crack)
	include_subtypes = FALSE
