/obj/item/smokable
	name = "smokable"
	desc = "An indescribable substance that appears to be smokeable."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "crack"

	/// The reagent contained in the item. Set blank for nothing.
	var/datum/reagent/smokable_reagent
	/// How much of the reagent is in the item.
	var/reagent_amount = 0

/obj/item/smokable/Initialize(mapload)
	. = ..()
	create_reagents(reagent_amount)
	if(smokable_reagent)
		reagents.add_reagent(smokable_reagent, reagent_amount)
