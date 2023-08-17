/obj/item/bongable
	name = "some shit you stuff in a bong"
	desc = "FUUUUUUUUUUUUUUUUUUUUUUUUUUUUUCK"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hashbrick"

	/// The reagent contained in the item. Set blank for nothing.
	var/datum/reagent/bong_reagent
	/// How much of the reagent is in the item.
	var/reagent_amount = 0

/obj/item/bongable/Initialize(mapload)
	. = ..()
	create_reagents(reagent_amount)
	if(bong_reagent)
		reagents.add_reagent(bong_reagent, reagent_amount)
