/obj/item/reagent_containers/glass/bottle/vial
	name = "broken hypovial"
	desc = "A hypovial compatible with most hyposprays."
	icon = 'modular_skyrat/modules/hyposprays/icons/vials.dmi'
	icon_state = "hypovial"
	spillable = FALSE
	volume = 10
	possible_transfer_amounts = list(1,2,5,10)

/obj/item/reagent_containers/glass/bottle/vial/update_overlays() //Fuck it, lets try this.
	. = ..()
	if(!fill_icon_thresholds)
		return
	if(reagents.total_volume)
		var/fill_name = fill_icon_state? fill_icon_state : icon_state
		var/mutable_appearance/filling = mutable_appearance('modular_skyrat/modules/hyposprays/icons/hypospray_fillings.dmi', "[fill_name][fill_icon_thresholds[1]]") //fuck vial, fuck vial

		var/percent = round((reagents.total_volume / volume) * 100)
		for(var/i in 1 to fill_icon_thresholds.len)
			var/threshold = fill_icon_thresholds[i]
			var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
			if(threshold <= percent && percent < threshold_end)
				filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"

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

/obj/item/reagent_containers/glass/bottle/vial/small/bicaridine
	name = "red hypovial (bicaridine)"
	icon_state = "hypovial-b"
	list_reagents = list(/datum/reagent/medicine/bicaridine = 30)

/obj/item/reagent_containers/glass/bottle/vial/small/antitoxin
	name = "green hypovial (Anti-Tox)"
	icon_state = "hypovial-a"
	list_reagents = list(/datum/reagent/medicine/antitoxin = 30)

/obj/item/reagent_containers/glass/bottle/vial/small/kelotane
	name = "orange hypovial (kelotane)"
	icon_state = "hypovial-k"
	list_reagents = list(/datum/reagent/medicine/kelotane = 30)

/obj/item/reagent_containers/glass/bottle/vial/small/dexalin
	name = "blue hypovial (dexalin)"
	icon_state = "hypovial-d"
	list_reagents = list(/datum/reagent/medicine/dexalin = 30)

/obj/item/reagent_containers/glass/bottle/vial/small/tricord
	name = "hypovial (tricordrazine)"
	icon_state = "hypovial"
	list_reagents = list(/datum/reagent/medicine/tricordrazine = 30)

/obj/item/reagent_containers/glass/bottle/vial/large/cmo
	name = "deluxe hypovial"
	icon_state = "hypoviallarge-cmos"
	list_reagents = list(/datum/reagent/medicine/omnizine = 20, /datum/reagent/medicine/leporazine = 20, /datum/reagent/medicine/atropine = 20)

/obj/item/reagent_containers/glass/bottle/vial/large/bicaridine
	name = "large red hypovial (bicaridine)"
	icon_state = "hypoviallarge-b"
	list_reagents = list(/datum/reagent/medicine/bicaridine = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/antitoxin
	name = "large green hypovial (anti-tox)"
	icon_state = "hypoviallarge-a"
	list_reagents = list(/datum/reagent/medicine/antitoxin = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/kelotane
	name = "large orange hypovial (kelotane)"
	icon_state = "hypoviallarge-k"
	list_reagents = list(/datum/reagent/medicine/kelotane = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/dexalin
	name = "large blue hypovial (dexalin)"
	icon_state = "hypoviallarge-d"
	list_reagents = list(/datum/reagent/medicine/dexalin = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/charcoal
	name = "large black hypovial (charcoal)"
	icon_state = "hypoviallarge-t"
	list_reagents = list(/datum/reagent/medicine/charcoal = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/tricord
	name = "large hypovial (tricord)"
	icon_state = "hypoviallarge"
	list_reagents = list(/datum/reagent/medicine/tricordrazine = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/salglu
	name = "large green hypovial (salglu)"
	icon_state = "hypoviallarge-a"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/synthflesh
	name = "large orange hypovial (synthflesh)"
	icon_state = "hypoviallarge-k"
	list_reagents = list(/datum/reagent/medicine/synthflesh = 60)
