/obj/item/snortable/heroin
	name = "heroin"
	desc = "Take a line and take some time of man."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "heroin"

	powder_reagent = /datum/reagent/drug/heroin/powder_heroin // this needs to become a subtype
	reagent_amount = 4

/datum/export/heroin
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "heroin"
	export_types = list(/obj/item/snortable/heroin)
	include_subtypes = FALSE
