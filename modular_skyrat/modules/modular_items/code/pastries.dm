// FOOD ITEM
/obj/item/food/mince_pie
	name = "mince pie"
	desc = "The edible embodiment of christmas cheer."
	w_class = WEIGHT_CLASS_TINY
	icon = 'modular_skyrat/modules/modular_items/icons/pastries.dmi'
	icon_state = "mince_pie"
	food_flags = FOOD_FINGER_FOOD
	foodtypes = GRAIN | SUGAR | FRUIT
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("fruit" = 1, "raisins" = 1, "christmas spirit" = 1)

// RECIPE

/datum/crafting_recipe/food/mince_pie
	name = "Mince pie"
	reqs = list(
		/obj/item/food/no_raisin = 1,
		/obj/item/food/grown/apple = 1,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/mince_pie
	subcategory = CAT_PASTRY
