/obj/item/snortable/cocaine
	name = "cocaine"
	desc = "A powdered form of cocaine, a stimulant extracted from coca leaves."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "cocaine"

	powder_reagent = /datum/reagent/drug/cocaine/powder_cocaine
	reagent_amount = 5

/datum/export/cocaine
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "cocaine"
	export_types = list(/obj/item/snortable/cocaine)
	include_subtypes = FALSE
