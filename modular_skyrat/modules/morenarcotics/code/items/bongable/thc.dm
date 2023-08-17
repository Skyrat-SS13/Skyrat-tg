/obj/item/bongable/hash
	name = "hash"
	desc = "Concentrated cannabis extract. Delivers a more intense high when used in a bong."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hash"

	bong_reagent = /datum/reagent/drug/thc/processed
	reagent_amount = 20

/obj/item/bongable/dab
	name = "dab"
	desc = "Oil extract from cannabis plants. Just delivers a different type of hit."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "dab"

	bong_reagent = /datum/reagent/drug/thc/processed
	reagent_amount = 40

/datum/export/hash
	cost = CARGO_CRATE_VALUE * 0.35
	unit_name = "hash"
	export_types = list(/obj/item/bongable/hash)
	include_subtypes = FALSE

/datum/export/dab
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "dab"
	export_types = list(/obj/item/bongable/dab)
	include_subtypes = FALSE
