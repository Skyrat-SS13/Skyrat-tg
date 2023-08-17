/obj/item/smokable/blacktar
	name = "black tar heroin"
	desc = "A rock of black tar heroin, an impure freebase form of heroin."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "blacktar"

	smokable_reagent = /datum/reagent/drug/blacktar
	reagent_amount = 5

/datum/export/blacktar
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "black tar heroin"
	export_types = list(/obj/item/smokable/blacktar)
	include_subtypes = FALSE
