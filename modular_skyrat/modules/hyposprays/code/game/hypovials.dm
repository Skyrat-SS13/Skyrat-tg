/obj/item/reagent_containers/glass/bottle/vial
	name = "broken hypovial"
	desc = "A hypovial compatible with most hyposprays."
	icon = 'modular_skyrat/modules/hyposprays/icons/vials.dmi'
	icon_state = "hypovial"
	spillable = FALSE
	volume = 10
	possible_transfer_amounts = list(1,2,5,10)

/obj/item/reagent_containers/glass/bottle/vial/update_overlays()
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
        . += filling

/obj/item/reagent_containers/glass/bottle/vial/Initialize()
	. = ..()
	update_icon()

/obj/item/reagent_containers/glass/bottle/vial/on_reagent_change()
	update_icon()

/obj/item/reagent_containers/glass/bottle/vial/small
	name = "hypovial"
	volume = 60
	possible_transfer_amounts = list(1,2,5,10,20)

/obj/item/reagent_containers/glass/bottle/vial/large
	volume = 120
	possible_transfer_amounts = list(1,2,5,10,20,30,40,50,100,120)

/obj/item/reagent_containers/glass/bottle/vial/large/cmo
	name = "deluxe hypovial"
	list_reagents = list(/datum/reagent/medicine/omnizine = 20, /datum/reagent/medicine/leporazine = 20, /datum/reagent/medicine/atropine = 20)

/obj/item/reagent_containers/glass/bottle/vial/large/salglu
	name = "large green hypovial (salglu)"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/synthflesh
	name = "large orange hypovial (synthflesh)"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/multiver
	name = "large black hypovial (multiver)"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 60)
