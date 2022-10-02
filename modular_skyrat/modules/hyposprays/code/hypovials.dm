/obj/item/reagent_containers/cup/vial
	name = "broken hypovial"
	desc = "You probably shouldn't be seeing this. Shout at a coder."
	icon = 'modular_skyrat/modules/hyposprays/icons/vials.dmi'
	icon_state = "hypovial"
	spillable = FALSE
	volume = 10
	/// The suffix of the overlay texture that the hypovial uses when loading textures.
	var/type_suffix = "-s"
	possible_transfer_amounts = list(1,2,5,10)
	fill_icon_thresholds = list(10, 25, 50, 75, 100)
	var/chem_color //Used for hypospray overlay

/obj/item/reagent_containers/cup/vial/update_overlays()
    . = ..()
    if(!fill_icon_thresholds)
        return
    if(reagents.total_volume)
        var/fill_name = fill_icon_state? fill_icon_state : icon_state
        var/fill_overlay = 10
        switch(round((reagents.total_volume / volume)*100))
            if(1 to 24)
                fill_overlay = 10
            if(25 to 49)
                fill_overlay = 25
            if(50 to 74)
                fill_overlay = 50
            if(75 to 89)
                fill_overlay = 75
            if(89 to 100)
                fill_overlay = 100
        var/mutable_appearance/filling = mutable_appearance('modular_skyrat/modules/hyposprays/icons/hypospray_fillings.dmi', "[fill_name][fill_overlay]")

        filling.color = mix_color_from_reagents(reagents.reagent_list)
        chem_color = filling.color
        . += filling

/obj/item/reagent_containers/cup/vial/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/cup/vial/on_reagent_change()
	update_icon()

//Fit in all hypos
/obj/item/reagent_containers/cup/vial/small
	name = "hypovial"
	desc = "A small, 60u capacity vial compatible with most hyposprays."
	volume = 60
	possible_transfer_amounts = list(1,2,5,10,20,30,40,50,60)

//Fit in CMO hypo only
/obj/item/reagent_containers/cup/vial/large
	name = "large hypovial"
	icon_state = "hypoviallarge"
	desc = "A large, 120u capacity vial that fits only in the most deluxe hyposprays."
	volume = 120
	type_suffix = "-l"
	possible_transfer_amounts = list(1,2,5,10,20,30,40,50,100,120)

//Hypos that are in the CMO's kit round start
/obj/item/reagent_containers/cup/vial/large/deluxe
	name = "deluxe hypovial"
	list_reagents = list(/datum/reagent/medicine/omnizine = 20, /datum/reagent/medicine/leporazine = 20, /datum/reagent/medicine/atropine = 20)

/obj/item/reagent_containers/cup/vial/large/salglu
	name = "large green hypovial (salglu)"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 60)

/obj/item/reagent_containers/cup/vial/large/synthflesh
	name = "large orange hypovial (synthflesh)"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 60)

/obj/item/reagent_containers/cup/vial/large/multiver
	name = "large black hypovial (multiver)"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 60)
