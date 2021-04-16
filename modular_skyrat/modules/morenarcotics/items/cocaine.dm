/obj/item/reagent_containers/crack
	name = "crack"
	desc = "A rock of freebase cocaine, otherwise known as crack."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "crack"
	possible_transfer_amounts = list()
	volume = 10
	list_reagents = list(/datum/reagent/drug/cocaine/freebase_cocaine = 10)
	grind_results = list(/datum/reagent/drug/cocaine = 5)

/obj/item/reagent_containers/crack/crackbrick
	name = "crack brick"
	desc = "A brick of crack cocaine."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "crackbrick"
	possible_transfer_amounts = list()
	volume = 40
	list_reagents = list(/datum/reagent/drug/cocaine/freebase_cocaine = 40)
	grind_results = list(/datum/reagent/drug/cocaine = 20)

/obj/item/reagent_containers/crack/crackbrick/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		user.show_message("<span class='notice'>You cut \the [src] into some rocks.</span>", MSG_VISUAL)
		for(var/i = 1 to 4)
			new /obj/item/reagent_containers/crack(user.loc)
		qdel(src)

/obj/item/reagent_containers/cocaine
	name = "cocaine"
	desc = "Reenact your favorite scenes from Scarface!"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "cocaine"
	possible_transfer_amounts = list()
	volume = 5
	list_reagents = list(/datum/reagent/drug/cocaine = 5)
	grind_results = list(/datum/reagent/drug/cocaine = 5)

/obj/item/reagent_containers/cocaine/attack(mob/M, mob/user, def_zone)
	if(M == user)
		M.visible_message("<span class='notice'>[user] starts snorting the [src].</span>")
		if(do_after(user,30))
			to_chat(M, "<span class='notice'>You finish snorting the [src].</span>")
			if(reagents.total_volume)
				reagents.trans_to(M, reagents.total_volume, transfered_by = user, methods = INGEST)
			qdel(src)

/datum/export/crack
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "crack"
	export_types = list(/obj/item/reagent_containers/crack)
	include_subtypes = FALSE

/datum/export/crack/crackbrick
	cost = CARGO_CRATE_VALUE * 2.5
	unit_name = "crack"
	export_types = list(/obj/item/reagent_containers/crack/crackbrick)
	include_subtypes = FALSE

/datum/export/cocaine
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "crack"
	export_types = list(/obj/item/reagent_containers/cocaine)
	include_subtypes = FALSE
