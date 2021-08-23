//Brazilian and Spanish Foods, for weird human!

//Grain dishes

/obj/item/food/tapioca
	name = "Empty Tapioca"
	desc = "Tapioca is the starch extracted from cassava (Mandioca), usually prepared in granulated form. It is the main ingredient of some typical Brazilian delicacies, such as beiju, an indigenous delicacy discovered by the Portuguese in Pernambuco in the 16th century. It is very common to use the term tapioca to refer to beiju. Yet it seems you can put some ingredients inside like a bun."
	icon = ''
	icon_state = ""
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3,)
	tastes = list("grains" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL


/obj/item/food/tapioca_cheese
	name = "Cheese Tapioca"
	desc = "This tapioca seems to have been filled with cheese. Delicia!"
	icon = ''
	icon_state = ""
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3,)
	tastes = list("sweet grains" = 1, "salty grains" = 1, "cheese" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL


/obj/item/food/tapioca_meat
	name = "Meaty Tapioca"
	desc = "This tapioca seems to have been filled with meat. Carne assada! Opá!"
	icon = ''
	icon_state = ""
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("sweet grains" = 1, "salty grains" = 1, "meat" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
