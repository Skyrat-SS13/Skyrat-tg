/obj/item/reagent_containers/condiment/flour/small_ration
	name = "small flour sack"
	desc = "A maritime ration sized portion of flour, containing just enough to make a single good loaf of bread to fuel the day."
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/flour = 15)

/obj/item/reagent_containers/condiment/rice/small_ration
	name = "small rice sack"
	desc = "A maritime ration sized portion of rice, containing just enough to make the universe's saddest rice dish."
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/rice = 10)

/obj/item/reagent_containers/condiment/sugar/small_ration
	name = "small sugar sack"
	desc = "A maritime ration sized portion of sugar, containing just enough to make the day just a tiny bit sweeter."
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/sugar = 10)

/obj/item/reagent_containers/condiment/small_ration_korta_flour
	name = "small korta flour sack"
	desc = "A maritime ration sized portion of korta flour, containing just enough to make a single good loaf of bread to fuel the day."
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	icon_state = "flour_korta"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/korta_flour = 10)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/soymilk/small_ration
	name = "small soy milk"
	desc = "It's soy milk. White and nutritious goodness! This one is significantly smaller than normal cartons, just enough to make some rootdough with."
	icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi'
	list_reagents = list(/datum/reagent/consumable/soymilk = 15)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny
	name = "tiny glass bottle"
	volume = 10

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/Initialize(mapload, vol)
	. = ..()
	transform = transform.Scale(0.75, 0.75)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/lime_juice
	name = "tiny lime juice bottle"
	desc = "A maritime ration sized bottle of lime juice, containing enough to keep the scurvy away while on long voyages."
	list_reagents = list(/datum/reagent/consumable/limejuice = 10)

/obj/item/reagent_containers/cup/glass/bottle/small/tiny/vinegar
	name = "tiny vinegar bottle"
	desc = "A maritime ration sized bottle of lime juice, containing enough to... Well, we're not entirely sure, but law mandates you're given this, so..."
	list_reagents = list(/datum/reagent/consumable/vinegar = 10)
