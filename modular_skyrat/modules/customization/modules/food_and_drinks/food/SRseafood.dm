/obj/item/food/canned/tuna
	name = "can of tuna"
	desc = "You can tune a piano, but you can't tuna fish."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "tunacan"
	trash_type = /obj/item/trash/can/food/tuna
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4, 
		/datum/reagent/consumable/nutriment/protein = 9, 
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("tuna" = 1)
	foodtypes = SEAFOOD

/obj/item/trash/can/food/tuna
	name = "can of tuna"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "tunacan_empty"
