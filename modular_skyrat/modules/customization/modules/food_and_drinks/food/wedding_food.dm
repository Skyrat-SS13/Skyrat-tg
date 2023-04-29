/obj/item/food/cake/wedding
	name = "wedding cake"
	desc = "An expensive, multi-tiered cake."
	icon = 'modular_skyrat/master_files/icons/obj/food/wedding.dmi'
	icon_state = "weddingcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 40,
		/datum/reagent/consumable/nutriment/vitamin = 10
	)
	tastes = list("cake" = 3, "frosting" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/wedding

/obj/item/food/cakeslice/wedding
	name = "wedding cake slice"
	desc = "Traditionally, those getting married feed each other a slice of cake."
	icon = 'modular_skyrat/master_files/icons/obj/food/wedding.dmi'
	icon_state = "weddingcake_slice"
	tastes = list("cake" = 3, "frosting" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cake/wedding_hemo
	name = "bloody wedding cake"
	desc = "An expensive, multi-tiered cake, baked with blood instead of milk, to served hemophages."
	icon = 'modular_skyrat/master_files/icons/obj/food/wedding.dmi'
	icon_state = "weddingcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 40,
		/datum/reagent/blood = 90
	)
	tastes = list("cake" = 3, "blood" = 1)
	foodtypes = GRAIN | SUGAR | GORE | BLOODY
	color = "#810000"
	slice_type = /obj/item/food/cakeslice/wedding_hemo

/obj/item/food/cakeslice/wedding_hemo
	name = "bloody wedding cake slice"
	desc = "Traditionally, those getting married feed each other a slice of cake. This one is made of blood."
	icon = 'modular_skyrat/master_files/icons/obj/food/wedding.dmi'
	icon_state = "weddingcake_slice"
	tastes = list("cake" = 3, "blood" = 1)
	foodtypes = GRAIN | SUGAR | GORE | BLOODY
	color = "#810000"
