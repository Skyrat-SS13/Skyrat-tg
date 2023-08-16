/obj/item/smokable
	name = "smokable"
	desc = "An indescribable substance that appears to be smokeable."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "crack"

	var/datum/reagent/smokable_reagent // leave blank for nothing
	var/reagent_amount = 0 // how much of powder_reagent the powder has in it

/obj/item/smokable/Initialize(mapload)
	. = ..()
	create_reagents(reagent_amount)
	if(smokable_reagent)
		reagents.add_reagent(smokable_reagent, reagent_amount)
