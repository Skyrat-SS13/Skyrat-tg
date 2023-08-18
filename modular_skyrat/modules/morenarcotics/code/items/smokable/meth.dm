/obj/item/smokable/meth
	name = "crystal meth"
	desc = "A smokable crystaline form of methamphetamine."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "meth"

	smokable_reagent = /datum/reagent/drug/methamphetamine/crystal
	reagent_amount = 10

/obj/item/smokable/bluesky
	name = "crystal blue sky"
	desc = "A crystal of blue sky, an alternative form of methamphetamine."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "meth"
	color = "#78C8FA"

	smokable_reagent = /datum/reagent/drug/bluesky/crystal
	reagent_amount = 10

/obj/item/smokable/bluesky/proc/update_icon_purity(purity)
	var/effective_impurity = min(1, (1 - purity) / 0.5)
	color = BlendRGB(initial(color), "#FAFAFA", effective_impurity)
	update_icon()

/datum/export/meth
	cost = CARGO_CRATE_VALUE * 0.75
	unit_name = "crack"
	export_types = list(/obj/item/smokable/meth)
	include_subtypes = FALSE

/datum/export/bluesky
	cost = CARGO_CRATE_VALUE * 0.6
	unit_name = "crack"
	export_types = list(/obj/item/smokable/bluesky)
	include_subtypes = FALSE
